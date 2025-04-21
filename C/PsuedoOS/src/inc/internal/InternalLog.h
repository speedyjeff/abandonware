
#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#include "ErrorCodes.h"
#endif

// Logging spec:
//  Logging consists of an ID char and 3 message chars
//  The capital IDs (ie. A) are for the Windows side
//  The lower case IDs (ie. a) are for the Kernel side
//  The identifier should help identify the module it came
//   from.
//   FS - F/f
//   OS - O/o
//   IO - I/i
//   FT - T/t
//   MM - M/m
//   ...

#ifndef _INTERNALLOG__H
#define _INTERNALLOG__H

#define HFAILED_RETURN(hr)            \
			if (HFAILED(hr))            \
			{                         \
				_LOG_WRITE(hr); \
				return hr;            \
			}                         \

HRESULT _LOG_WRITE(char id, char msg1, char msg2, char msg3, BOOL terminate = TRUE);
HRESULT _LOG_WRITE(HRESULT hr);

#endif
