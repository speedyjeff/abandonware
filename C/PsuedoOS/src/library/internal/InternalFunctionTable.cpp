
#include "InternalFunctionTable.h"
#include "InternalLog.h"

#ifdef _WINDOWS_SIDE

#include "psuedomchexports.h"

HRESULT _FUNCTABLE_INITIALIZE()
{
	_LOG_WRITE('T', 'i', 'n', ' ');

	// write the IO function pointers
	_FUNCTABLE_ACCESS(_FUNCTABLE_PUTCHAR) = (ULONG_PTR)(_WND_PUTCHAR);
	_FUNCTABLE_ACCESS(_FUNCTABLE_GETCHAR) = (ULONG_PTR)(_WND_GETCHAR);
	_FUNCTABLE_ACCESS(_FUNCTABLE_BREAKPOINT) = (ULONG_PTR)(_WND_BREAKPOINT);

	return ERROR_SUCCESS;
}

#else

HRESULT _FUNCTABLE_INITIALIZE()
{
	_LOG_WRITE('t', 'i', 'n', ' ');
	return ERROR_SUCCESS;
}

#endif
