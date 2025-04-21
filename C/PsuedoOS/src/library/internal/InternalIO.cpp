
#include "InternalIO.h"
#include "InternalLog.h"

HRESULT _IO_INITIALIZE()
{
	_LOG_WRITE('i', 'i', 'n', ' ');
	return ERROR_SUCCESS;
}

VOID _IO_PUTCHAR(CHAR c)
{
	VOID (__cdecl *_IO_FP_PUTCHAR)(CHAR);
	_IO_FP_PUTCHAR = (VOID (__cdecl *)(CHAR))(_FUNCTABLE_ACCESS(_FUNCTABLE_PUTCHAR));
	_IO_FP_PUTCHAR(c);
}

VOID _IO_PUTNEWLINE()
{
	_IO_PUTCHAR('\r');
	_IO_PUTCHAR('\n');
}

CHAR _IO_GETCHAR()
{
	CHAR (__cdecl *_IO_FP_GETCHAR)(VOID);
	_IO_FP_GETCHAR = (CHAR (__cdecl *)(VOID))(_FUNCTABLE_ACCESS(_FUNCTABLE_GETCHAR));
	return _IO_FP_GETCHAR();
}

