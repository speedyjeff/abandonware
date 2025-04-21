
#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#include "ErrorCodes.h"
#endif

#ifndef _INTERNALOS__H
#define _INTERNALOS__H

#define _OS_CONST_MAX_CALLBACKS 42
#define _OS_CONST_MAX_EXPORTS   12

// copy of this is found in Os.h (platform side)
#define _OS_EXPORTS_OS_REGISTERCALLBACK 0
#define _OS_EXPORTS_FS_MAKEDIR          1
#define _OS_EXPORTS_FS_REMOVEENTRY      2
#define _OS_EXPORTS_FS_CHANGEDIR        3
#define _OS_EXPORTS_FS_CREATEFILE       4
#define _OS_EXPORTS_FS_OPENFILE         5
#define _OS_EXPORTS_FS_EOF              6
#define _OS_EXPORTS_FS_READ             7
#define _OS_EXPORTS_FS_CLOSEFILE        8
#define _OS_EXPORTS_FS_LISTDIR          9
#define _OS_EXPORTS_IO_PUTCHAR          10
#define _OS_EXPORTS_IO_PUTNEWLINE       11

#define _OS_CALLBACK_MAX 16

typedef void (__cdecl *_OS_CALLBACK)(DWORD argc, CHAR** argv);

struct _KERNEL_CALLBACK_STRUCT
{
	CHAR chCommand[_OS_CALLBACK_MAX];
	CHAR chDescription[_OS_CALLBACK_MAX];
	_OS_CALLBACK lpMethodAdr;
};

// If the size of the kernel changes you need
//  to update the size in InternalMemoryManager.h

// cannot exceed 512 bytes! as defined in InternalMemoryManager.h
struct _KERNEL_STRUCT
{
	/* FS */
	DWORD     _FS_INITIALIZED;
	ULONG_PTR _FS_CURRENTDIR;
	ULONG_PTR _FS_FREESPACE;
	
	/* MM */
	ULONG_PTR _MM_FREEBLOCK;
	ULONG_PTR _MM_CODEHEAP;

	/* OS */
	_KERNEL_CALLBACK_STRUCT* _OS_CALLBACKS[_OS_CONST_MAX_CALLBACKS];
	ULONG_PTR _OS_EXPORTS[_OS_CONST_MAX_EXPORTS];
};

HRESULT _OS_INITIALIZE();
HRESULT _OS_REGISTERCALLBACK(CHAR* czCommand, CHAR* czDescription, _OS_CALLBACK lpMethodAdr);
HRESULT _OS_EXPORTFUNCTION(DWORD dwExportOrdinal, ULONG_PTR lpMethodAdr);
// this method is defined in the psuedo machine (eg. _WINDOWS_SIDE) and can be used to set a breakpoint within a debugger
HRESULT _OS_BREAKPOINT();

#endif
