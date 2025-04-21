
#include "Types.h"

typedef void (__cdecl *_OS_CALLBACK)(DWORD argc, CHAR** argv);

ULONG_PTR GetExportAddress(DWORD dwExportOrdinal);

bool RegisterCmdCallback(CHAR* czCommand, CHAR* czDescription, _OS_CALLBACK lpMethodAdr);

void Breakpoint();

// string

// lower case a character
char lower(char c);

// string comparision case insensitive
bool strcmpi(char* str1, char* str2);
// string comparision case sensitive
bool strcmp(char* str1, char* str2);

// convert a string to an integer
DWORD stoi(char* str);


