
#include "io.h"
#include "os.h"
#include "InternalOS.h"

void print(char* str)
{
	while(NULL != str && '\0' != *str)
	{
		print(*str);
		str++;
	}
}

void print(char c)
{
	VOID (__cdecl *_IO_FP_PUTCHAR)(CHAR);
	_IO_FP_PUTCHAR = (VOID (__cdecl *)(CHAR))(GetExportAddress(_OS_EXPORTS_IO_PUTCHAR));

	_IO_FP_PUTCHAR(c);
}

char ToHex(BYTE b)
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

void print(DWORD d)
{
	char header[3] = {'0', 'x', '\0'};

	print(header);

	// convert HRESULT to chars
	for (int i=7; i>=0; i--) print( ToHex((BYTE)((d >> (i*4)) & 0xf)) );
}

void newline()
{
	VOID (__cdecl *_IO_FP_PUTNEWLINE)(VOID);
	_IO_FP_PUTNEWLINE = (VOID (__cdecl *)(VOID))(GetExportAddress(_OS_EXPORTS_IO_PUTNEWLINE));

	_IO_FP_PUTNEWLINE();
}