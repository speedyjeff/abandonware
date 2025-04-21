
#include "ErrorCodes.h"
#include "InternalMemoryManager.h"

#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#endif

#ifndef _INTERNALFUNCTIONTALBE__H
#define _INTERNALFUNCTIONTALBE__H

// if you add constants you need to update the 
//  total size in InternalMemoryManager.h

const ULONG_PTR _FUNCTABLE_PUTCHAR    = 0; // _WND_PUTCHAR
const ULONG_PTR _FUNCTABLE_GETCHAR    = 2; // _WND_GETCHAR
const ULONG_PTR _FUNCTABLE_BREAKPOINT = 3; // _WND_BREAKPOINT

HRESULT _FUNCTABLE_INITIALIZE();

#define _FUNCTABLE_ACCESS( index ) (*(ULONG_PTR*)(_FUNCTABLE_ADDRESS + index * sizeof(ULONG_PTR)))

#endif
