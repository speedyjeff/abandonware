
#include "Os.h"
#include "InternalMemoryManager.h"
#include "InternalOS.h"

ULONG_PTR GetExportAddress(DWORD dwExportOrdinal)
{
	ULONG_PTR* lpExportAddress;

	if (_OS_CONST_MAX_EXPORTS <= dwExportOrdinal) return NULL;

	lpExportAddress = (ULONG_PTR*)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_EXPORTS;

	return lpExportAddress[ dwExportOrdinal ];
}

bool RegisterCmdCallback(CHAR* czCommand, CHAR* czDescription, _OS_CALLBACK lpMethodAdr)
{
	HRESULT (__cdecl *_OS_CALLBACK_REGISTER)(CHAR*, CHAR*, _OS_CALLBACK);
	_OS_CALLBACK_REGISTER = (HRESULT (__cdecl *)(CHAR*, CHAR*, _OS_CALLBACK))(GetExportAddress(_OS_EXPORTS_OS_REGISTERCALLBACK));
	if (NULL == _OS_CALLBACK_REGISTER) return FALSE;
	HRESULT hr = _OS_CALLBACK_REGISTER(czCommand, czDescription, lpMethodAdr);
	return HSUCCEED(hr);
}

void Breakpoint()
{
	// todo
}

char lower(char c)
{
	// convert the char to lowercase
	if ('A' <= c && c <= 'Z')
	{
		return 'a' + (c - 'A');
	}
	else
	{
		return c;
	}
}

bool strcmp_helper(char* str1, char* str2, bool caseSensitive)
{
	int i;

	if (NULL == str1 || NULL == str2) return FALSE;

	// ASSERT() command must be null terminated
	// ASSERT() str is always longer than command
	for(i=0; '\0' != str1[i] && '\0' != str2[i]; i++)
	{
		if ( caseSensitive && str1[i] != str2[i])               return FALSE;
		if (!caseSensitive && lower(str1[i]) != lower(str2[i])) return FALSE;
	}

	return ('\0' == str1[i] && '\0' == str2[i]);
}

bool strcmp(char* str1, char* str2)  { return strcmp_helper(str1, str2, true); }
bool strcmpi(char* str1, char* str2) { return strcmp_helper(str1, str2, false); }

DWORD stoi(char* str)
{
	// conver the base 10 string into a DWORD
	DWORD num;
	DWORD cnt;

	if (NULL == str) return -1;

	// ASSERT() str is null terminated

	num = 0;
	cnt = 0;
	while('\0' != str[cnt])
	{
		num *= 10;
		if ('0' <= str[cnt] && str[cnt] <= '9')
		{
			num += (str[cnt] - '0');
		}
		else
		{
			return -1;
		}
		cnt++;
	}

	return num;
}
