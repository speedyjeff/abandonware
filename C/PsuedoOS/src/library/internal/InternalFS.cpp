
#include "InternalFS.h"
#include "InternalFunctionTable.h"
#include "InternalOS.h"
#include "InternalLog.h"
#include "ErrorCodes.h"

void PrintAllDirectories(_FS_DIRECTORY_STRUCT* currentDir, DWORD level);
void PrintDirectoryName(_FS_DIRECTORY_STRUCT* currentDir, DWORD level);
void PrintFullDirectoryName(_FS_DIRECTORY_STRUCT* currentDir);
BOOL IsSegmentUsed(_FS_FREESPACE* freeSpace, DWORD dwFSSegment, DWORD dwFSSegmentOffset);
BOOL DirNameEqualsCaseSensitive(char* dir1, char* dir2);
_FS_DIRECTORY_STRUCT* FindDirectory(char* chDirName, _FS_DIRECTORY_STRUCT* currentDir);
HRESULT CreateDirectoryEntry(_FS_DIRECTORY_STRUCT* currentDir, char* dirName, BOOL isDir, DWORD dwSizeInBytes);

#ifdef _WINDOWS_SIDE

#include <windows.h>
#include <stdio.h>
#include <sys\stat.h>

HRESULT _FS_INITIALIZE()
{
	LPVOID lpBaseAddress;
	FILE*  fFileSystem;
	
	_LOG_WRITE('F', 'i', 'n', ' ');

	// set the global flag to indicate that we
	//  have not setup the FS yet
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_INITIALIZED = 0;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR  = NULL;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_FREESPACE   = NULL;

	// allocate the space for the FS
	lpBaseAddress = VirtualAlloc((LPVOID)_FS_DEVICEADDRESS,
			_FS_DEVICESIZE,
			MEM_COMMIT | MEM_RESERVE,
			PAGE_READWRITE);

	if (NULL == lpBaseAddress) return ERROR_NOT_ENOUGH_MEMORY;

	// load the FS into this memory block
	fopen_s(&fFileSystem, "hnd", "r");

	if (NULL == fFileSystem)
	{
		// no harddrive on disk, create it and flush
		_FS_FORMATDISK();

		fopen_s(&fFileSystem, "hnd", "r");

		if (fFileSystem == NULL) return ERROR_FILE_NOT_FOUND;
	}

	fread((BYTE*)_FS_DEVICEADDRESS, 1, _FS_DEVICESIZE, fFileSystem);
	fclose(fFileSystem);
	
	// indicate that the FS has been initialized
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_INITIALIZED = 1;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR  = _FS_DEVICEADDRESS;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_FREESPACE   = _FS_DEVICEADDRESS + _FS_CONST_FS_SEGMENT_SIZE;

	return ERROR_SUCCESS;
}

HRESULT _FS_FLUSHDISK()
{
	FILE* fFileSystem;

	if (_FS_DEVICEADDRESS == NULL) return ERROR_BAD_ENVIRONMENT;

	// load the FS into this memory block
	fopen_s(&fFileSystem, "hnd", "wb");
	
	if (NULL == fFileSystem) return ERROR_FILE_NOT_FOUND;

	fwrite((BYTE*)_FS_DEVICEADDRESS, 1, _FS_DEVICESIZE, fFileSystem);
	fclose(fFileSystem);

	return ERROR_SUCCESS;
}

HRESULT _FS_RAWCOPY(char* chSource, ULONG_PTR lpDest, ULONG_PTR lpSize)
{
	FILE*  fStream;
	size_t stBytesRead;

	_LOG_WRITE('F','r','a','w');
	
	if (!((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_INITIALIZED) return ERROR_BAD_ENVIRONMENT;

	// open chSource and read lpSize bytes
	fopen_s(&fStream, chSource, "rb");

	if (NULL == fStream) return ERROR_FILE_NOT_FOUND;

	// ready lpSize bytes
	stBytesRead = fread((byte*)lpDest, sizeof(byte), lpSize, fStream);

	// close the stream
	fclose(fStream);

	// don't think that we want this guarantee
	//	if (lpSize != stBytesRead) return ERROR_INVALID_SIZE;

	return ERROR_SUCCESS;
}

HRESULT _FS_FORMATDISK()
{
	HRESULT hr;
	DWORD   dwSize;

	// wipe the drive
	ZeroMemory((byte*)_FS_DEVICEADDRESS, _FS_DEVICESIZE); 

	// reset the main entry
	_FS_DIRECTORY_STRUCT* currentDir = (_FS_DIRECTORY_STRUCT*)_FS_DEVICEADDRESS;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR = (ULONG_PTR)currentDir;
	((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_FREESPACE   = _FS_DEVICEADDRESS + _FS_CONST_FS_SEGMENT_SIZE;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// create root directory
	currentDir->dwCanary     = _FS_CONST_CONARY;
	currentDir->dwSize       = _FS_CONST_DIRECTORY;
	currentDir->offsetParentDir = -1;
	currentDir->offsetPeerDirs  = -1;
	currentDir->offsetChildDirs = -1;
	currentDir->chName[0] = 'h';
	currentDir->chName[1] = 'n';
	currentDir->chName[2] = 'd';
	currentDir->chName[3] = '\0';

	// the free space array is all zeroed out

	// always mark the first segment and free space table as used
	hr = _FS_FREESPACE_SET(0, (sizeof(_FS_DIRECTORY_STRUCT) + sizeof(_FS_FREESPACE)) / _FS_CONST_FS_SEGMENT_SIZE, FALSE /* clear */);
	HFAILED_RETURN(hr);

	_FS_FLUSHDISK();

	return ERROR_SUCCESS;
}

#else

HRESULT _FS_INITIALIZE()
{
	_LOG_WRITE('f', 'i', 'n', ' ');

	if (!((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_INITIALIZED)
	{
		return ERROR_BAD_ENVIRONMENT;
	}
	else
	{
		return ERROR_SUCCESS;
	}
}

HRESULT _FS_FLUSHDISK()
{
	return ERROR_NOT_IMPLEMENTED;
}

HRESULT _FS_RAWCOPY(char* chSource, ULONG_PTR lpDest, ULONG_PTR lpSize)
{
	return ERROR_NOT_IMPLEMENTED;
}

HRESULT _FS_FORMATDISK()
{
	return ERROR_NOT_IMPLEMENTED;
}

#endif

HRESULT _FS_FREESPACE_SET(DWORD dwSegmentOffset, DWORD dwNumSegments, BOOL clear)
{
	_LOG_WRITE('f', 'f', 's', 's');

	_FS_FREESPACE* freeSpace = (_FS_FREESPACE*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_FREESPACE;

	if (NULL == freeSpace) return ERROR_BAD_ENVIRONMENT;

	while (0 < dwNumSegments)
	{
		// get the right freespace segment pointer
		DWORD dwFSSegment       = dwSegmentOffset / 32; // 32 == num of bits in a DWORD
		DWORD dwFSSegmentOffset = dwSegmentOffset % 32; // 32 == num of bits in DWORD

		// this bit should not be set

		if (dwFSSegment >= _FS_NUM_SEGMENTS_BITS) 
		{
			_LOG_WRITE('f', 'r', 'n', 'g');
			return ERROR_DISKCORUPTION;
		}

		// clear or set the bit in the freespace array
		if (clear) freeSpace->bFreeSegments[dwFSSegment] &= ~(1 << dwFSSegmentOffset);
		else freeSpace->bFreeSegments[dwFSSegment] |= (1 << dwFSSegmentOffset);

		// decrement the segment counter
		dwNumSegments--;
		// increment the segment offset
		dwSegmentOffset++;
	}

	_FS_FLUSHDISK();

	return ERROR_SUCCESS;
}

HRESULT _FS_FREESPACE_GET(DWORD* dwFreeSegment, DWORD dwNumSegments)
{
	// find a segment that has dwNumSegments free

	_LOG_WRITE('f', 'f', 's', 'g');

	if (NULL == dwFreeSegment) return ERROR_POINTER;

	_FS_FREESPACE* freeSpace = (_FS_FREESPACE*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_FREESPACE;

	if (NULL == freeSpace) return ERROR_BAD_ENVIRONMENT;

	// save the original
	DWORD dwFSOrgNumSegments = dwNumSegments;
	DWORD dwSegmentOffset    = 0;
	DWORD dwFSSegment        = 0;
	DWORD dwFSSegmentOffset  = 0;
	while (dwNumSegments > 0)
	{
		// get the right freespace segment pointer
		dwFSSegment       = dwSegmentOffset / 32; // 32 == num of bits in a DWORD
		dwFSSegmentOffset = dwSegmentOffset % 32; // 32 == num of bits in DWORD

		// check if we are out of bounds
		if (dwFSSegment >= _FS_NUM_SEGMENTS_BITS) break;

		// this bit should not be set
		if (IsSegmentUsed(freeSpace, dwFSSegment, dwFSSegmentOffset)) 
		{
			// reset the counter
			dwNumSegments = dwFSOrgNumSegments;
		}
		else
		{
			// decrement the segment counter (as it is free)
			dwNumSegments--;
		}

		// increment the segment offset
		dwSegmentOffset++;
	}

	// check if we found a free block
	if (0 == dwNumSegments && dwFSSegment < _FS_NUM_SEGMENTS_BITS)
	{
		*(dwFreeSegment) = dwSegmentOffset - dwFSOrgNumSegments;
		return ERROR_SUCCESS;
	}
	else
	{
		*(dwFreeSegment) = 0;
		return ERROR_DISKFULL;
	}
}

HRESULT _FS_FREESPACE_SEGTOADDR(_FS_DIRECTORY_STRUCT** lpDirStruct, DWORD dwSegment)
{
	if (NULL == lpDirStruct) return ERROR_POINTER;

	_LOG_WRITE('f', 'f', 's', 's');

	*(lpDirStruct) = (_FS_DIRECTORY_STRUCT*)(_FS_DEVICEADDRESS + (dwSegment * _FS_CONST_FS_SEGMENT_SIZE));

	return ERROR_SUCCESS;
}

HRESULT _FS_FREESPACE_ADDRTOSEG(_FS_DIRECTORY_STRUCT* lpDirStruct, DWORD* dwSegment)
{
	if (NULL == lpDirStruct) return ERROR_POINTER;

	_LOG_WRITE('f', 'f', 's', 'a');

	(*dwSegment) = ((ULONG_PTR)lpDirStruct - (ULONG_PTR)_FS_DEVICEADDRESS) / _FS_CONST_FS_SEGMENT_SIZE;

	return ERROR_SUCCESS;
}

HRESULT _FS_LISTDIR()
{
	_FS_DIRECTORY_STRUCT* currentDir;

	_LOG_WRITE('f', 'd', 'i', 'r');
		
	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// recursively print all directories
	PrintAllDirectories(currentDir, 0);

	return ERROR_SUCCESS;
}

HRESULT _FS_MAKEDIR(char* dirName)
{
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;
	char* dPtr;

	_LOG_WRITE('f', 'm', 'k', ' ');
		
	if (NULL == dirName) return ERROR_INVALIDDIRNAME;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// make sure the dirName does not contain the FS seperator
	dPtr = dirName;
	while('\\' != *dPtr && '/' != *dPtr && '\0' != *dPtr) dPtr++;
	if ('\0' != *dPtr) return ERROR_INVALIDDIRNAME;

	// make sure that this dir does not exist
	if (NULL != FindDirectory(dirName, currentDir)) return ERROR_NAME_EXISTS;

	// create the directory
	hr = CreateDirectoryEntry(currentDir, dirName, TRUE /* IsDir */, _FS_CONST_FS_SEGMENT_SIZE);

	_FS_FLUSHDISK();

	return hr;
}

HRESULT _FS_REMOVEENTRY(char* chName)
{
	// remove empty directories or files
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;

	_LOG_WRITE('f', 'r', 'm', ' ');
		
	if (NULL == chName) return ERROR_INVALIDDIRNAME;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// make sure the chName does not contain the FS seperator
	char* dPtr = chName;
	while('\\' != *dPtr && '/' != *dPtr && '\0' != *dPtr) dPtr++;
	if ('\0' != *dPtr) return ERROR_INVALIDDIRNAME;

	// make sure that this dir does exists
	_FS_DIRECTORY_STRUCT* entryDir = FindDirectory(chName, currentDir);
	if (entryDir == NULL) return ERROR_FILE_NOT_FOUND;

	// check if we can remove this entry (must be empty)
	// check if this directory is empty
	if (entryDir->offsetChildDirs >= 0) return ERROR_DIRECTORY_NOT_EMPTY;

	// check if this is the current directory
	if (entryDir == currentDir) return ERROR_DIRECTORY_NOT_EMPTY;

	// check if this is the root directory
	if (entryDir->offsetParentDir < 0) return ERROR_DIRECTORY_NOT_EMPTY;

	// check if in a chain of peers and fix the chain
	// go back to the parent and iterate through the childs peers and ensure that this entry is removed
	// scenarios:
	//  first (or only) in the list => update the parent to the current entry's peer
	//  middle (or last) of the list => update the previous entry to the current entry's peer
	DWORD entryOffset = (ULONG_PTR)entryDir - (ULONG_PTR)_FS_DEVICEADDRESS;
	_FS_DIRECTORY_STRUCT* parentDir = (struct _FS_DIRECTORY_STRUCT*)((ULONG_PTR)_FS_DEVICEADDRESS + entryDir->offsetParentDir);
	if (entryDir->offsetParentDir < 0) return ERROR_BAD_ENVIRONMENT;
	if (parentDir->offsetChildDirs == entryOffset)
	{
		// first or only in the list
		parentDir->offsetChildDirs = entryDir->offsetPeerDirs;
	}
	else
	{
		// middle or last in the list
		_FS_DIRECTORY_STRUCT* prevDir = (struct _FS_DIRECTORY_STRUCT*)((ULONG_PTR)_FS_DEVICEADDRESS + parentDir->offsetChildDirs);
		if (parentDir->offsetChildDirs < 0) return ERROR_BAD_ENVIRONMENT;
		while (prevDir->offsetPeerDirs != entryOffset && prevDir->offsetPeerDirs >= 0)
		{
			// advance to the next peer
			prevDir = (struct _FS_DIRECTORY_STRUCT*)((ULONG_PTR)_FS_DEVICEADDRESS + prevDir->offsetPeerDirs);
		}
		if (prevDir->offsetPeerDirs != entryOffset) return ERROR_DISKCORUPTION; // should not happen
		// update the previous entry to point to the current entry's peer
		prevDir->offsetPeerDirs = entryDir->offsetPeerDirs;
	}

	// todo - there can be failures and the disk would be corrupt

	// at this point, entryDir is no longer necessary and can be removed

	// this can now be reclaimed as free space
	// get the segement number of this directory
	DWORD dwSegment;
	hr = _FS_FREESPACE_ADDRTOSEG(entryDir, &dwSegment);
	if (HFAILED(hr)) return hr;
		
	// set the freespace table to clear this segment
	DWORD numSegements = (entryDir->dwSize == _FS_CONST_DIRECTORY) ? 1 : (entryDir->dwSize + _FS_CONST_FS_SEGMENT_SIZE) / _FS_CONST_FS_SEGMENT_SIZE;
	hr = _FS_FREESPACE_SET(dwSegment, numSegements, TRUE /* clear */);
	HFAILED_RETURN(hr);

	// clear out the entry (some)
	entryDir->dwCanary     = 0xBAADF00D;
	entryDir->dwSize       = 0;
	entryDir->offsetParentDir = -1;
	entryDir->offsetPeerDirs  = -1;
	entryDir->offsetChildDirs = -1;
	entryDir->chName[0] = '\0';

	// todo - wipe the rest of the entry?

	// done
	hr = ERROR_SUCCESS;

	_FS_FLUSHDISK();

	return hr;
}

HRESULT _FS_CREATEFILE(char* dirName, DWORD dwSize)
{
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;
	char* dPtr;

	_LOG_WRITE('f', 'c', 'r', 't');
		
	if (NULL == dirName) return ERROR_INVALIDDIRNAME;
	if (0 >= dwSize)     return ERROR_INVALID_SIZE;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// make sure the dirName does not contain the FS seperator
	dPtr = dirName;
	while('\\' != *dPtr && '/' != *dPtr && '\0' != *dPtr) dPtr++;
	if ('\0' != *dPtr) return ERROR_INVALIDDIRNAME;

	// make sure that this dir does not exist
	if (NULL != FindDirectory(dirName, currentDir)) return ERROR_NAME_EXISTS;

	// create the directory
	hr = CreateDirectoryEntry(currentDir, dirName, FALSE /* IsDir */, dwSize + _FS_CONST_FS_SEGMENT_SIZE);

	_FS_FLUSHDISK();

	return hr;
}

HRESULT _FS_CHANGEDIR(char* chDirName)
{
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;
	_FS_DIRECTORY_STRUCT* newDir;

	_LOG_WRITE('f', 'c', 'd', ' ');
		
	if (NULL == chDirName) return ERROR_INVALIDDIRNAME;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// search all child dirs for one that matches chDirName
	newDir = FindDirectory(chDirName, currentDir);

	// newDir is the correct direcotry
	if (NULL != newDir)
	{
		if (_FS_CONST_DIRECTORY == newDir->dwSize)
		{
			// set the current as the new
			((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR = (ULONG_PTR)newDir;
			return ERROR_SUCCESS;
		}
		else
		{
			return ERROR_INVALIDDIRNAME;
		}
	}
	else if (currentDir->offsetParentDir >= 0 && *(chDirName) == '.' && *(chDirName+1) == '.')
	{
		((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR = (ULONG_PTR)currentDir->offsetParentDir + (ULONG_PTR)_FS_DEVICEADDRESS;
		return ERROR_SUCCESS;
	}
	else
	{
		return ERROR_FILE_NOT_FOUND;
	}
}

HRESULT _FS_REMOTECOPY(char* chRemoteFileName, char* chDest)
{
	// copy a file from a remote source (ie. Windows) to 
	//  the internal file system
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;
	_FS_DIRECTORY_STRUCT* destFile;

	_LOG_WRITE('f','r','c','p');
		
	if (NULL == chRemoteFileName || NULL == chDest) return ERROR_INVALIDDIRNAME;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// make sure that this dir does not exist
	destFile = FindDirectory(chDest, currentDir);
	if (NULL == destFile) return ERROR_FILE_NOT_FOUND;

	hr = _FS_RAWCOPY(chRemoteFileName, (ULONG_PTR)destFile+(ULONG_PTR)_FS_CONST_FS_SEGMENT_SIZE, destFile->dwSize);

	// make sure that that last byte is '\0'
	*((char*)destFile+(_FS_CONST_FS_SEGMENT_SIZE+destFile->dwSize) ) = '\0';

	_FS_FLUSHDISK();

	return hr;
}

HRESULT _FS_EOF(_FS_FILEH* fHandle)
{
	_LOG_WRITE('f', 'e', 'o', 'f');

	if (NULL == fHandle || NULL == fHandle->lpPtr) return ERROR_INVALID_HANDLE;
	if ('\0' == *((char*)fHandle->lpPtr+fHandle->dwOffset)) return ERROR_EOF;

	return ERROR_SUCCESS;
}

HRESULT _FS_OPENFILE(_FS_FILEH* fHandle, char* chFileName)
{
	HRESULT hr;
	_FS_DIRECTORY_STRUCT* currentDir;
	_FS_DIRECTORY_STRUCT* destFile;

	_LOG_WRITE('f','o','p','n');

	if (NULL == fHandle) return ERROR_INVALID_HANDLE;

	fHandle->lpPtr    = NULL;
	fHandle->dwOffset = 0;
	fHandle->dwSize   = 0;

	if (NULL == chFileName) return ERROR_INVALIDDIRNAME;

	currentDir = (struct _FS_DIRECTORY_STRUCT*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_FS_CURRENTDIR;

	if (NULL == currentDir) return ERROR_BAD_ENVIRONMENT;

	// make sure that this dir does exist
	destFile = FindDirectory(chFileName, currentDir);
	if (NULL == destFile) return ERROR_FILE_NOT_FOUND;

	if (_FS_CONST_DIRECTORY == destFile->dwSize) return ERROR_FILE_NOT_FOUND;

	// set up the file handle
	fHandle->lpPtr  = (ULONG_PTR)destFile+(ULONG_PTR)_FS_CONST_FS_SEGMENT_SIZE;
	fHandle->dwSize = destFile->dwSize;

	return ERROR_SUCCESS;
}

HRESULT _FS_CLOSEFILE(_FS_FILEH* fHandle)
{
	_LOG_WRITE('f', 'c', 'l', 's');

	if (NULL == fHandle || NULL == fHandle->lpPtr) return ERROR_INVALID_HANDLE;

	fHandle->lpPtr = NULL;

	return ERROR_SUCCESS;
}

HRESULT _FS_READ(_FS_FILEH* fHandle, BYTE* byteArr, DWORD dwNumBytes)
{
	DWORD cnt;

	_LOG_WRITE('f', 'r', 'd', ' ');

	if (NULL == fHandle || NULL == fHandle->lpPtr) return ERROR_INVALID_HANDLE;
	if (NULL == byteArr) return ERROR_POINTER;

	cnt = 0;
	while (cnt < dwNumBytes)
	{
		byteArr[cnt] = *((BYTE*)((ULONG_PTR)fHandle->lpPtr+fHandle->dwOffset));
		if(fHandle->dwOffset < fHandle->dwSize) fHandle->dwOffset++;
		cnt++;
	}

	return ERROR_SUCCESS;
}

HRESULT _FS_FILESIZE(_FS_FILEH* fHandle, DWORD* dwSize)
{
	_LOG_WRITE('f', 's', 'i', 'z');

	if (NULL == fHandle || NULL == fHandle->lpPtr) return ERROR_INVALID_HANDLE;
	if (NULL == dwSize) return ERROR_POINTER;

	*dwSize = fHandle->dwSize;

	return ERROR_SUCCESS;
}

HRESULT CreateDirectoryEntry(_FS_DIRECTORY_STRUCT* currentDir, char* dirName, BOOL isDir, DWORD dwSizeInBytes)
{
	HRESULT hr;
	DWORD   dwFreeSpace;
	DWORD   cnt;
	DWORD   dwSegments;
	_FS_DIRECTORY_STRUCT* newDir;

	// convert the size in bytes to segments
	dwSegments  = (dwSizeInBytes / _FS_CONST_FS_SEGMENT_SIZE);

	// ceiling of the divison
	if (dwSizeInBytes != (dwSegments*_FS_CONST_FS_SEGMENT_SIZE))
	{
		dwSegments++;
	}

	// grab some empty space to put the new directory
	hr = _FS_FREESPACE_GET(&dwFreeSpace, dwSegments);
	HFAILED_RETURN(hr);

	// mark the space as used
	hr = _FS_FREESPACE_SET(dwFreeSpace, dwSegments, FALSE /* clear */);
	HFAILED_RETURN(hr);

	// we now have a free block
	hr = _FS_FREESPACE_SEGTOADDR(&newDir, dwFreeSpace);
	HFAILED_RETURN(hr);

	// create the new directory
	newDir->dwCanary     = _FS_CONST_CONARY;
	newDir->dwSize       = (isDir) ? _FS_CONST_DIRECTORY : dwSizeInBytes - _FS_CONST_FS_SEGMENT_SIZE; // removal as this is added by the caller
	newDir->offsetParentDir = (int)((ULONG_PTR)currentDir - (ULONG_PTR)_FS_DEVICEADDRESS);
	newDir->offsetPeerDirs  = -1;
	newDir->offsetChildDirs = -1;
	cnt = 0;
	while (*dirName != '\0' && cnt < _FS_CONST_MAXNAMESIZE)
	{
		newDir->chName[ cnt ] = *dirName;
		dirName++;
		cnt++;
	}

	// make sure there is a trailing null
	if (cnt < _FS_CONST_MAXNAMESIZE)
	{
		newDir->chName[ cnt ] = '\0';
	}
	else
	newDir->chName[ _FS_CONST_MAXNAMESIZE-1 ] = '\0';

	// hook up the new directory
	if (currentDir->offsetChildDirs < 0)
	{
		// set this as the first child
		currentDir->offsetChildDirs = (int)((ULONG_PTR)newDir - (ULONG_PTR)_FS_DEVICEADDRESS);
	}
	else
	{
		// put this at the end of the peer list of the child
		//  directories
		_FS_DIRECTORY_STRUCT* tmpDir = (_FS_DIRECTORY_STRUCT*)((ULONG_PTR)currentDir->offsetChildDirs + (ULONG_PTR)_FS_DEVICEADDRESS);
		while (tmpDir->offsetPeerDirs >= 0)
		{
			tmpDir = (_FS_DIRECTORY_STRUCT*)((ULONG_PTR)tmpDir->offsetPeerDirs + (ULONG_PTR)_FS_DEVICEADDRESS);
		}
		tmpDir->offsetPeerDirs = (int)((ULONG_PTR)newDir - (ULONG_PTR)_FS_DEVICEADDRESS);
	}

	return ERROR_SUCCESS;
}

_FS_DIRECTORY_STRUCT* FindDirectory(char* chDirName, _FS_DIRECTORY_STRUCT* currentDir)
{
	_FS_DIRECTORY_STRUCT* newDir;

	if (NULL == currentDir) return NULL;

	// search all child dirs for one that matches chDirName
	if (currentDir->offsetChildDirs < 0) newDir = NULL;
	else newDir = (_FS_DIRECTORY_STRUCT*)((ULONG_PTR)currentDir->offsetChildDirs + (ULONG_PTR)_FS_DEVICEADDRESS);
	while(NULL != newDir)
	{
		if (DirNameEqualsCaseSensitive(chDirName, (char*)newDir->chName))
		{
			break;
		}
		else
		{
			if (newDir->offsetPeerDirs < 0) newDir = NULL;
			else newDir = (_FS_DIRECTORY_STRUCT*)((ULONG_PTR)newDir->offsetPeerDirs + (ULONG_PTR)_FS_DEVICEADDRESS);
		}
	}

	return newDir;
}

BOOL DirNameEqualsCaseSensitive(char* dir1, char* dir2)
{
	if (NULL == dir1 || NULL == dir2) return FALSE;

	while(*dir1 != '\0' && *dir2 != '\0' && *dir1 == *dir2)
	{
		dir1++;
		dir2++;
	}

	if (*dir1 == '\0' && *dir2 == '\0')
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}

void PrintFullDirectoryName(_FS_DIRECTORY_STRUCT* currentDir)
{
	// print out the current name (go up the chain of parents to the start)
	if (currentDir == NULL) return;

	if (currentDir->offsetParentDir >= 0) PrintFullDirectoryName((_FS_DIRECTORY_STRUCT*)((ULONG_PTR)currentDir->offsetParentDir + (ULONG_PTR)_FS_DEVICEADDRESS));
	
	// print out the name of this directory
	_IO_PUTCHAR('/');
	for(int i=0; i<_FS_CONST_MAXNAMESIZE; i++)
	{
		if ('\0' == currentDir->chName[i]) break;
		_IO_PUTCHAR(currentDir->chName[i]);
	}
}

void PrintDirectoryName(_FS_DIRECTORY_STRUCT* currentDir, DWORD level)
{
	int   counter;
	BYTE  msgs[10];
	DWORD dwNum;

	for (int i=0; i<level; i++) _IO_PUTCHAR(' ');

	if (_FS_CONST_DIRECTORY == currentDir->dwSize)
	{
		PrintFullDirectoryName(currentDir);
		_IO_PUTCHAR('/');
	}
	else
	{
		_IO_PUTCHAR(' ');

		counter = 0;
		dwNum   = currentDir->dwSize;
		while(0 < dwNum)
		{
			msgs[counter++] = (BYTE)(dwNum % 10);
			dwNum = dwNum / 10;
		}

		for(--counter; 0<=counter; counter--) _IO_PUTCHAR('0' + msgs[counter]);

		_IO_PUTCHAR('b');
		_IO_PUTCHAR(' ');

		// print current name
		for(int i=0; i<_FS_CONST_MAXNAMESIZE; i++)
		{
			if ('\0' == currentDir->chName[i]) break;
			_IO_PUTCHAR(currentDir->chName[i]);
		}
	}

	_IO_PUTNEWLINE();
}

void PrintAllDirectories(_FS_DIRECTORY_STRUCT* currentDir, DWORD level)
{
	while(NULL != currentDir)
	{
		PrintDirectoryName(currentDir, level);

		// print out all child dirs
		if (_FS_CONST_DIRECTORY == currentDir->dwSize)
		{
			if (currentDir->offsetChildDirs >= 0)
			{	
				PrintAllDirectories((_FS_DIRECTORY_STRUCT*)(currentDir->offsetChildDirs + _FS_DEVICEADDRESS), level+1);
			}
		}

		// advance to the next dir
		if (0 != level)
		{
			if (currentDir->offsetPeerDirs >= 0)
			{
				currentDir = (_FS_DIRECTORY_STRUCT*)(currentDir->offsetPeerDirs + _FS_DEVICEADDRESS);
			}
			else
			{
				currentDir = NULL;
			}
		}
		else
		{
			// this is the end
			currentDir = NULL;
		}
	}
}

BOOL IsSegmentUsed(_FS_FREESPACE* freeSpace, DWORD dwFSSegment, DWORD dwFSSegmentOffset)
{
	// todo - what actually checks if the SEGMENT is used?
	if (dwFSSegment >= _FS_NUM_SEGMENTS_BITS) return FALSE;
	if (freeSpace == NULL) return FALSE;
	if (freeSpace->bFreeSegments == NULL) return FALSE;
	if (dwFSSegmentOffset >= 32) return FALSE;
	if (dwFSSegment < 0) return FALSE;
	if (dwFSSegmentOffset < 0) return FALSE;
	return (freeSpace->bFreeSegments[dwFSSegment] & (1 << dwFSSegmentOffset)) != 0; 
}
