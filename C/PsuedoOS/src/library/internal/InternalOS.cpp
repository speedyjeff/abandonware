
#include "InternalOS.h"

#include "InternalMemoryManager.h"
#include "InternalFunctionTable.h"
#include "InternalIO.h"
#include "InternalFS.h"
#include "InternalLog.h"

#if _WINDOWS_SIDE
#include "psuedomchexports.h"
#endif

#pragma optimize("", off)
// avoid the memset optimization
HRESULT _OS_INITIALIZE()
{
	HRESULT    retVal;
	ULONG_PTR* osCallBacks;

	// sanity checks
	if (sizeof(_KERNEL_STRUCT) > _KERNEL_SIZE) return ERROR_BAD_ENVIRONMENT;

	// initialize RAM
	retVal = _MM_INITIALIZE();
	if (HFAILED(retVal)) return retVal;

	// 
	// No logging until after this point
	//
	// initialize function table
	retVal = _FUNCTABLE_INITIALIZE();
	HFAILED_RETURN(retVal);

	// initialize IO
	retVal = _IO_INITIALIZE();
	HFAILED_RETURN(retVal);

	//
	// No IO until after this point
	//

	// initalize FS
	retVal = _FS_INITIALIZE();
	HFAILED_RETURN(retVal);

	// initialize OS data structures
	osCallBacks = (ULONG_PTR*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_CALLBACKS;

	if (NULL == osCallBacks) return ERROR_BAD_ENVIRONMENT;


	for(int i=0; i<_OS_CONST_MAX_CALLBACKS; i++)
	{
		osCallBacks[i] = NULL;
	}

#if !_WINDOWS_SIDE
	// OS
	_OS_EXPORTFUNCTION(_OS_EXPORTS_OS_REGISTERCALLBACK, (ULONG_PTR)(_OS_REGISTERCALLBACK));

	// FS
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_MAKEDIR,    (ULONG_PTR)(_FS_MAKEDIR));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_REMOVEENTRY, (ULONG_PTR)(_FS_REMOVEENTRY));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_CHANGEDIR,  (ULONG_PTR)(_FS_CHANGEDIR));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_CREATEFILE, (ULONG_PTR)(_FS_CREATEFILE));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_OPENFILE,   (ULONG_PTR)(_FS_OPENFILE));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_EOF,        (ULONG_PTR)(_FS_EOF));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_READ,       (ULONG_PTR)(_FS_READ));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_CLOSEFILE,  (ULONG_PTR)(_FS_CLOSEFILE));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_FS_LISTDIR,    (ULONG_PTR)(_FS_LISTDIR));

	// IO
	_OS_EXPORTFUNCTION(_OS_EXPORTS_IO_PUTCHAR,    (ULONG_PTR)(_IO_PUTCHAR));
	_OS_EXPORTFUNCTION(_OS_EXPORTS_IO_PUTNEWLINE, (ULONG_PTR)(_IO_PUTNEWLINE));
#endif

	_LOG_WRITE('o', 'u', 't', ' ');

	return ERROR_SUCCESS;
}
#pragma optimize("", on)

#if _WINDOWS_SIDE
HRESULT _OS_REGISTERCALLBACK(CHAR* czCommand, CHAR* czDescription, _OS_CALLBACK lpMethodAdr)
{
	return ERROR_NOT_IMPLEMENTED;
}

HRESULT _OS_EXPORTFUNCTION(DWORD dwExportOrdinal, ULONG_PTR lpMethodAdr)
{
	return ERROR_NOT_IMPLEMENTED;
}

HRESULT _OS_BREAKPOINT()
{
	// nothing
	return ERROR_SUCCESS;
}

#else
HRESULT _OS_REGISTERCALLBACK(CHAR* czCommand, CHAR* czDescription, _OS_CALLBACK lpMethodAdr)
{
	_LOG_WRITE('o', ' ', 'c', 'b');

	if (NULL == lpMethodAdr) return ERROR_POINTER;

	// check to see if there is an open slot
	_KERNEL_CALLBACK_STRUCT** osCallBacks = (_KERNEL_CALLBACK_STRUCT**)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_CALLBACKS;
	if (NULL == osCallBacks) return ERROR_BAD_ENVIRONMENT;

	// find the first empty slot
	for(int cnt=0; cnt<_OS_CONST_MAX_CALLBACKS; cnt++)
	{
		if (osCallBacks[cnt] == NULL)
		{
			// allocate the new struct and populate the fields
			HRESULT hr = _MM_NALLOC((ULONG_PTR*)&osCallBacks[cnt], sizeof(struct _KERNEL_CALLBACK_STRUCT));
			if (HFAILED(hr)) return hr;

			// copy the function pointer
			osCallBacks[cnt]->lpMethodAdr = lpMethodAdr;
			
			// copy the command
			int index = 0;
			for (index=0; index < _OS_CALLBACK_MAX && czCommand[index] != '\0'; index++)
			{
				osCallBacks[cnt]->chCommand[index] = czCommand[index];
			}
			if (index < _OS_CALLBACK_MAX) osCallBacks[cnt]->chCommand[index] = '\0';
			else osCallBacks[cnt]->chCommand[_OS_CALLBACK_MAX-1] = '\0';

			// copy the description
			index = 0;
			for (index=0; index < _OS_CALLBACK_MAX && czDescription[index] != '\0'; index++)
			{
				osCallBacks[cnt]->chDescription[index] = czDescription[index];
			}
			if (index < _OS_CALLBACK_MAX) osCallBacks[cnt]->chDescription[index] = '\0';
			else osCallBacks[cnt]->chDescription[_OS_CALLBACK_MAX-1] = '\0';

			return ERROR_SUCCESS;
		}
	}

	return ERROR_MAX_CAPACITY;
}

HRESULT _OS_EXPORTFUNCTION(DWORD dwExportOrdinal, ULONG_PTR lpMethodAdr)
{
	_LOG_WRITE('o', ' ', 'e', 'f');

	if (_OS_CONST_MAX_EXPORTS <= dwExportOrdinal) return ERROR_MAX_CAPACITY;

	// check to see if there is an open slot
	ULONG_PTR* osExports = (ULONG_PTR*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_EXPORTS;
	if (NULL == osExports) return ERROR_BAD_ENVIRONMENT;

	osExports[dwExportOrdinal] = lpMethodAdr; 

	return ERROR_SUCCESS;
}

HRESULT _OS_BREAKPOINT()
{
	HRESULT (__cdecl *_OS_FP_BREAKPOINT)();
	_OS_FP_BREAKPOINT = (HRESULT (__cdecl *)())(_FUNCTABLE_ACCESS(_FUNCTABLE_BREAKPOINT));
	return _OS_FP_BREAKPOINT();
}
#endif

