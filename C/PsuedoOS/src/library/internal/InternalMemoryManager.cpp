
#include "InternalMemoryManager.h"
#include "InternalOS.h"

#ifdef _WINDOWS_SIDE

HRESULT _MM_INITIALIZE()
{
	LPVOID lpBaseAddress;

	// allocate data memory
	lpBaseAddress = VirtualAlloc((LPVOID)_MM_DATARAM_START,
			_MM_DATARAM_SIZE,
			MEM_COMMIT | MEM_RESERVE,
			PAGE_READWRITE);

	if (NULL == lpBaseAddress) return ERROR_NOT_ENOUGH_MEMORY;
	
	// create the first free block
	((struct _MM_FREEBLOCK_STRUCT*)_USERDATA_ADDRESS)->_MM_CANARY    = _MM_CONST_CANARY;
	((struct _MM_FREEBLOCK_STRUCT*)_USERDATA_ADDRESS)->_MM_BLOCKSIZE = _USERDATA_SIZE;
	((struct _MM_FREEBLOCK_STRUCT*)_USERDATA_ADDRESS)->_MM_NEXTBLOCK = NULL;
		
	// allocate the code memory
	lpBaseAddress = VirtualAlloc((LPVOID)_MM_CODERAM_START,
			_MM_CODERAM_SIZE,
			MEM_COMMIT | MEM_RESERVE,
			PAGE_EXECUTE_READWRITE);

	if (NULL == lpBaseAddress) return ERROR_NOT_ENOUGH_MEMORY;

	// set the pointer to the kernel struct
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK    = _USERDATA_ADDRESS;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_CODEHEAP     = _MM_CODERAM_START;

	return ERROR_SUCCESS;
}

#else

HRESULT _MM_INITIALIZE()
{
	return ERROR_SUCCESS;
}

#endif

HRESULT _MM_NALLOC(ULONG_PTR* blockAdr, ULONG_PTR blockSize)
{
	ULONG_PTR                    lpFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsPrevFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsNewFreeBlock;

	if (NULL == blockAdr) return ERROR_POINTER;
	
	// the smallest block that we can allocate is
	//  the size of our FREE block struct
	if (sizeof(struct _MM_FREEBLOCK_STRUCT) > (blockSize + sizeof(ULONG_PTR)))
	{
		blockSize = sizeof(struct _MM_FREEBLOCK_STRUCT);
	}
	
	lpFreeBlock = ((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK;

	// check if there is any free space, or
	//  if there is enough free space
	if (NULL == lpFreeBlock) return ERROR_NOT_ENOUGH_MEMORY;
	
	// iterate through all the free blocks, until you find one that 
	//  has enough free room
	fsFreeBlock     = ((struct _MM_FREEBLOCK_STRUCT*)lpFreeBlock);
	fsPrevFreeBlock = NULL;
	
	while (fsFreeBlock != NULL && (fsFreeBlock->_MM_BLOCKSIZE < (blockSize + sizeof(ULONG_PTR))))
	{
		fsPrevFreeBlock = fsFreeBlock;
		fsFreeBlock     = fsFreeBlock->_MM_NEXTBLOCK;
	}
	
	if (NULL == fsFreeBlock) return ERROR_NOT_ENOUGH_MEMORY;
	
	// check for heap corruption
	if (_MM_CONST_CANARY != fsFreeBlock->_MM_CANARY) return ERROR_HEAP_CORRUPTION;
	
	// at this point there should be enough space
	//  in the free block pointed to by fsFreeBlock
	fsNewFreeBlock = ((struct _MM_FREEBLOCK_STRUCT*)((BYTE*)fsFreeBlock+(blockSize + sizeof(ULONG_PTR))));

	fsNewFreeBlock->_MM_CANARY    = _MM_CONST_CANARY;
	fsNewFreeBlock->_MM_BLOCKSIZE = fsFreeBlock->_MM_BLOCKSIZE - (blockSize + sizeof(ULONG_PTR));
	fsNewFreeBlock->_MM_NEXTBLOCK = fsFreeBlock->_MM_NEXTBLOCK;
	
	// update the free block list
	if (NULL != fsPrevFreeBlock)
	{
		fsPrevFreeBlock->_MM_NEXTBLOCK = fsNewFreeBlock;
	}
	else
	{
		((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK = (ULONG_PTR)fsNewFreeBlock;
	}
	
	// Zero out the memory
	for (int i=0; i < (blockSize + sizeof(ULONG_PTR)); i++)
	{
		*((BYTE*)fsFreeBlock+i) = 0x0;
	}

	// put the size at the start of the block
	*((ULONG_PTR*)fsFreeBlock) = blockSize;
	
	// return the pointer to the memory block
	*blockAdr = (ULONG_PTR)((BYTE*)fsFreeBlock+sizeof(ULONG_PTR));

	return ERROR_SUCCESS;
}

HRESULT _MM_NFREE(ULONG_PTR* blockAdr)
{
	ULONG_PTR                    lpFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsPrevFreeBlock;
	struct _MM_FREEBLOCK_STRUCT* fsNewFreeBlock;
	
	if (NULL == blockAdr) ERROR_POINTER;
	
	// BUG BUG! Need to Validate the block that is being freed

	// free this memory and add it back into the free list
	
	// check if this will be the first free block
	lpFreeBlock = ((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK;
	if (NULL == lpFreeBlock)
	{
		fsFreeBlock = (struct _MM_FREEBLOCK_STRUCT*)blockAdr;
				
		// the ULONG_PTR before the block of memory is the size
		fsFreeBlock = (_MM_FREEBLOCK_STRUCT*)((BYTE*)fsFreeBlock-sizeof(ULONG_PTR));
		fsFreeBlock->_MM_BLOCKSIZE = *((ULONG_PTR*)fsFreeBlock); // size
		fsFreeBlock->_MM_CANARY    = _MM_CONST_CANARY;
		fsFreeBlock->_MM_NEXTBLOCK = NULL;
		
		((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK = (ULONG_PTR)fsFreeBlock;
		
		return ERROR_SUCCESS;
	}
	
	// search for a free list that is right before it 
	//  or right after it.
	lpFreeBlock = ((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK;
	fsFreeBlock = (struct _MM_FREEBLOCK_STRUCT*)lpFreeBlock;
	fsPrevFreeBlock = NULL;
	while(NULL != fsFreeBlock)
	{
		// check if the new free block is at the end of 
		//  another free block
		if (((BYTE*)fsFreeBlock + fsFreeBlock->_MM_BLOCKSIZE) == ((BYTE*)blockAdr-sizeof(ULONG_PTR)))
		{
			// we are at the end
			fsFreeBlock->_MM_BLOCKSIZE += *(ULONG_PTR*)((BYTE*)blockAdr-sizeof(ULONG_PTR)) + sizeof(ULONG_PTR);
			break;
		}
		else if (( ((ULONG_PTR*)blockAdr-1) + *((ULONG_PTR*)blockAdr-1)) == (ULONG_PTR*)fsFreeBlock)
		{
			// we are at the begining
			fsNewFreeBlock = (struct _MM_FREEBLOCK_STRUCT*)((BYTE*)blockAdr - sizeof(ULONG_PTR));
			
			fsNewFreeBlock->_MM_BLOCKSIZE = fsFreeBlock->_MM_BLOCKSIZE + *(ULONG_PTR*)((BYTE*)blockAdr-sizeof(ULONG_PTR)) + sizeof(ULONG_PTR);
			fsNewFreeBlock->_MM_CANARY    = _MM_CONST_CANARY;			
			fsNewFreeBlock->_MM_NEXTBLOCK = fsFreeBlock->_MM_NEXTBLOCK;
			
			if (NULL != fsPrevFreeBlock)
			{
				fsPrevFreeBlock->_MM_NEXTBLOCK = fsNewFreeBlock;
			}
			else
			{
				((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_FREEBLOCK = (ULONG_PTR)fsNewFreeBlock;
			}
			
			break;
		}
		fsPrevFreeBlock = fsFreeBlock;
		fsFreeBlock = fsFreeBlock->_MM_NEXTBLOCK;
	}

	// BUG BUG! Need to look for ajacent free blocks

	return ERROR_SUCCESS;
}
