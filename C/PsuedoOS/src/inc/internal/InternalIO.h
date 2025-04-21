
#include "ErrorCodes.h"

#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#endif

#include "InternalFunctionTable.h"

#ifndef _INTERNALIO__H
#define _INTERNALIO__H

HRESULT _IO_INITIALIZE();

VOID _IO_PUTCHAR(CHAR c);
VOID _IO_PUTNEWLINE();
CHAR _IO_GETCHAR();

#endif

