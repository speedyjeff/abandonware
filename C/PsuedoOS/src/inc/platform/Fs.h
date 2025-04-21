
#include "Types.h"

// directory
bool MakeDirectory(char* chDirectoryName);
bool RemoveEntity(char* chName);
bool ChangeDirectory(char* chDirectoryName);
bool ListCurrentDirectory();

// file
bool CreateFile(char* chFileName, DWORD dwSize);
bool OpenFile(FILE* fHandle, char* chFileName);
bool EndOfFile(FILE* fHandle);
bool ReadFile(FILE* fHandle, BYTE* bArr, DWORD dwNumBytes);
bool CloseFile(FILE* fHandle);
