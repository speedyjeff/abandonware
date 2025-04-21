
#include "InternalLD.h"
#include "InternalFS.h"
#include "InternalFunctionTable.h"
#include "InternalOS.h"
#include "InternalLog.h"

ULONG_PTR AllocOnCodeHeap(SIZE_T szBytes);

HRESULT _LD_LOADMODULE(char* szModuleName, _LD_ENTRYPOINT* lpEntrypoint)
{
	char*     start;
	char*     end;
	int       dirDepth;
	_FS_FILEH fHandle;
	HRESULT   hr;
	DWORD     dwSize;
	ULONG_PTR blockAdr;

	_LOG_WRITE('l',' ','d','r');

	if (NULL == szModuleName) return ERROR_INVALIDDIRNAME;

	// change directory to the module
	dirDepth = 0;
	start = end = szModuleName;
	while('\0' != *end)
	{
		if ('\\' == *end || '/' == *end)
		{
			if (start != end)
			{
				*end = '\0';
				// change current dir
				hr = _FS_CHANGEDIR(start);

				if (HFAILED(hr)) goto CleanUp;

				dirDepth++;
			}
			end++;
			start = end;
		}
		else
		{
			end++;
		}
	}

	// open the file
	hr = _FS_OPENFILE(&fHandle, start);
	if (HFAILED(hr)) goto CleanUp;

	// allocate enough space to hold this module
	hr = _FS_FILESIZE(&fHandle, &dwSize);
	if (HFAILED(hr)) goto CleanUp;

	// allocate on the code heap
	blockAdr = AllocOnCodeHeap(dwSize);
	if (NULL == blockAdr) goto CleanUp;

	// read the module into memory
	hr = _FS_READ(&fHandle, (BYTE*)blockAdr, dwSize);
	if (HFAILED(hr)) goto CleanUp;

	_LOG_WRITE('l', ' ', 'g', 'o');

	// call the initalization function
	//_LD_ENTRYPOINT callback = (_LD_ENTRYPOINT)(blockAdr);
	//callback(blockAdr);

	// return the entry point to the caller
	(*lpEntrypoint) = (_LD_ENTRYPOINT)(blockAdr);

	hr = ERROR_SUCCESS;
CleanUp:
	// close the file
	_FS_CLOSEFILE(&fHandle);

	// change the current dir back
	char backDir[3] = {'.','.','\0'};
	for(int i=0; i<dirDepth; i++)
	{
		_FS_CHANGEDIR(backDir);
	}

	return hr;
}

ULONG_PTR AllocOnCodeHeap(SIZE_T szBytes)
{
	// check if we can allocate this amount of memory
	if (szBytes > _MM_CODERAM_SIZE - (((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_CODEHEAP) - _MM_CODERAM_START)
	{
		return NULL;
	}

	// capture the current code heap address
	ULONG_PTR lpCodeHeap = ((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_CODEHEAP;

	// update the code heap address
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_MM_CODEHEAP += szBytes;

	return lpCodeHeap;
}
