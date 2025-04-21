
#include "ErrorCodes.h"

#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#endif

#include "InternalMemoryManager.h"
#include "InternalIO.h"

#ifndef _INTERNALFS__H
#define _INTERNALFS__H

// FS Layout
// 0x00000 ---------------------------
//         | _FS_DIRECOTYR_STRUCT
//         |   Parent directory
// 0x00039 ---------------------------
// 0x00040 | _FS_FREE_SPACE
//         |   Byte array for disk
//         |   free space
// 0x00800 ---------------------------
// 0x00801 | directories/files
//         | ...
// 0xfffff ---------------------------

#define _FS_CONST_CONARY          0xF11EF11E
#define _FS_CONST_MAXNAMESIZE     32
#define _FS_CONST_DIRECTORY       -1
#define _FS_CONST_FS_SEGMENT_SIZE 0x40 // 64 Closest power of 2 greater/equal to the size of the FS struct

// IMPORTANT If the following structure grows make sure that it still is within the size of the 
//  FS_SEGMENT_SiZE
// NOTE: This structure is embedded within the HD and should not contain any pointers
//       all offsets are relative to the start of the FS segment

struct _FS_DIRECTORY_STRUCT
{
	DWORD dwCanary;
	DWORD dwSize;
	int offsetParentDir;
	int offsetPeerDirs;
	int offsetChildDirs;
	CHAR  chName[_FS_CONST_MAXNAMESIZE];
};

const DWORD _FS_NUM_SEGMENTS = (_FS_DEVICESIZE / _FS_CONST_FS_SEGMENT_SIZE);
const DWORD _FS_NUM_SEGMENTS_BITS  = _FS_NUM_SEGMENTS / 32; // sizeof(DWORD) in bits 

// This struct is found right after the first directory structure

struct _FS_FREESPACE
{
	// a bit for every SEGMENT_SIZE of space in the harddrive
	DWORD bFreeSegments[ _FS_NUM_SEGMENTS_BITS ];
};

// If the size of the struct changes you MUST change Types.h
struct _FS_FILEH
{
	ULONG_PTR lpPtr;
	DWORD     dwOffset;
	DWORD     dwSize;
};

HRESULT _FS_INITIALIZE();

HRESULT _FS_FREESPACE_SET(DWORD dwSegmentOffset, DWORD dwNumSegments, BOOL clear);
HRESULT _FS_FREESPACE_GET(DWORD* dwFreeSegment, DWORD dwNumSegments);
HRESULT _FS_FREESPACE_SEGTOADDR(_FS_DIRECTORY_STRUCT* lpDirStruct, DWORD dwSegment);
HRESULT _FS_FREESPACE_ADDRTOSEG(_FS_DIRECTORY_STRUCT* lpDirStruct, DWORD* dwSegment);

HRESULT _FS_FLUSHDISK();
HRESULT _FS_FORMATDISK();

HRESULT _FS_RAWCOPY(char* chSource, ULONG_PTR lpDest, ULONG_PTR lpSize);

HRESULT _FS_LISTDIR();
HRESULT _FS_MAKEDIR(char* chDirName);
HRESULT _FS_REMOVEENTRY(char* chName);
HRESULT _FS_CHANGEDIR(char* chDirName);
HRESULT _FS_CREATEFILE(char* chFileName, DWORD dwSize);
HRESULT _FS_REMOTECOPY(char* chRemoteFileName, char* chDest);

HRESULT _FS_EOF(_FS_FILEH* fHandle);
HRESULT _FS_OPENFILE(_FS_FILEH* fHandle, char* chFileName);
HRESULT _FS_CLOSEFILE(_FS_FILEH* fHandle);
HRESULT _FS_READ(_FS_FILEH* fHandle, BYTE* bArr, DWORD dwNumBytes);
HRESULT _FS_FILESIZE(_FS_FILEH* fHandle, DWORD* dwSize);

#endif
