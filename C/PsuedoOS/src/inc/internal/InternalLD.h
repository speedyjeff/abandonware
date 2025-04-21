
#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#include "ErrorCodes.h"
#endif

#ifndef _INTERNALLD__H
#define _INTERNALLD__H

typedef VOID (__cdecl *_LD_ENTRYPOINT)(ULONG_PTR);

HRESULT _LD_LOADMODULE(char* szModuleName, _LD_ENTRYPOINT* lpEntrypoint);

#endif
