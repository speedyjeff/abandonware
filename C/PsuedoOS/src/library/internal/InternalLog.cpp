
#include "InternalLog.h"
#include "InternalMemoryManager.h"

char HEX(BYTE b);

HRESULT _LOG_WRITE(char id, char msg1, char msg2, char msg3, BOOL terminate)
{
	DWORD dwCurrentOffset;
	DWORD dwNewEntries = 4 + (terminate ? 1 : 0);

	// the first dword in memory is the offset
	dwCurrentOffset = *((DWORD*)_LOG_ADDRESS);

	// log back around if we are at the end
	if (_LOG_SIZE < (dwCurrentOffset+dwNewEntries))
	{
		dwCurrentOffset = sizeof(DWORD);
	}

	// add the entry
	*((BYTE*)_LOG_ADDRESS + dwCurrentOffset + 0) = (BYTE)id;
	*((BYTE*)_LOG_ADDRESS + dwCurrentOffset + 1) = (BYTE)msg1;
	*((BYTE*)_LOG_ADDRESS + dwCurrentOffset + 2) = (BYTE)msg2;
	*((BYTE*)_LOG_ADDRESS + dwCurrentOffset + 3) = (BYTE)msg3;

	if (terminate)
	{
		*((BYTE*)_LOG_ADDRESS + dwCurrentOffset + 4) = '*';
	}

	// store the value again
	dwCurrentOffset += dwNewEntries;
	*((DWORD*)_LOG_ADDRESS) = dwCurrentOffset;

	return ERROR_SUCCESS;
}

HRESULT _LOG_WRITE(HRESULT hr)
{
	BYTE msgs[7];

	for (int i=0; i<7; i++)	msgs[i] = (BYTE)((hr >> (i*4)) & 0xf);
	
	_LOG_WRITE('h'         , HEX(msgs[6]), HEX(msgs[5]), HEX(msgs[4]), FALSE);
	_LOG_WRITE(HEX(msgs[3]), HEX(msgs[2]), HEX(msgs[1]), HEX(msgs[0]));

	return ERROR_SUCCESS;
}

char HEX(BYTE b)
{
	switch(b)
	{
	case 15: return 'f';
	case 14: return 'e';
	case 13: return 'd';
	case 12: return 'c';
	case 11: return 'b';
	case 10: return 'a';
	default: return (char)(b + '0');
	}
}
