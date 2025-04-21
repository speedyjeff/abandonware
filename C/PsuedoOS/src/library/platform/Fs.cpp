
#include "Fs.h"
#include "Os.h"
#include "InternalOS.h"

bool MakeDirectory(char* chDirectoryName)
{
	HRESULT (__cdecl *_FP_FS_MAKEDIR)(char*);
	_FP_FS_MAKEDIR = (HRESULT (__cdecl *)(char*))(GetExportAddress(_OS_EXPORTS_FS_MAKEDIR));

	return HSUCCEED(_FP_FS_MAKEDIR(chDirectoryName));
}

bool RemoveEntity(char* chName)
{
	HRESULT (__cdecl *_FP_FS_REMOVE)(char*);
	_FP_FS_REMOVE = (HRESULT (__cdecl *)(char*))(GetExportAddress(_OS_EXPORTS_FS_REMOVEENTRY));

	return HSUCCEED(_FP_FS_REMOVE(chName));
}

bool ChangeDirectory(char* chDirectoryName)
{
	HRESULT (__cdecl *_FP_FS_CHANGEDIR)(char*);
	_FP_FS_CHANGEDIR = (HRESULT (__cdecl *)(char*))(GetExportAddress(_OS_EXPORTS_FS_CHANGEDIR));

	return HSUCCEED(_FP_FS_CHANGEDIR(chDirectoryName));
}

bool ListCurrentDirectory()
{
	HRESULT (__cdecl *_FP_FS_LISTDIR)(VOID);
	_FP_FS_LISTDIR = (HRESULT (__cdecl *)(VOID))(GetExportAddress(_OS_EXPORTS_FS_LISTDIR));

	return HSUCCEED(_FP_FS_LISTDIR());
}

// file
bool CreateFile(char* chFileName, DWORD dwSize)
{
	HRESULT (__cdecl *_FP_FS_CREATEFILE)(char*,DWORD);
	_FP_FS_CREATEFILE = (HRESULT (__cdecl *)(char*,DWORD))(GetExportAddress(_OS_EXPORTS_FS_CREATEFILE));

	return HSUCCEED(_FP_FS_CREATEFILE(chFileName, dwSize));
}

bool OpenFile(FILE* fHandle, char* chFileName)
{
	HRESULT (__cdecl *_FP_FS_OPENFILE)(FILE*,char*);
	_FP_FS_OPENFILE = (HRESULT (__cdecl *)(FILE*,char*))(GetExportAddress(_OS_EXPORTS_FS_OPENFILE));

	return HSUCCEED(_FP_FS_OPENFILE(fHandle, chFileName));
}

bool EndOfFile(FILE* fHandle)
{
	HRESULT (__cdecl *_FP_FS_EOF)(FILE*);
	_FP_FS_EOF = (HRESULT (__cdecl *)(FILE*))(GetExportAddress(_OS_EXPORTS_FS_EOF));

	return HSUCCEED(_FP_FS_EOF(fHandle));
}

bool ReadFile(FILE* fHandle, BYTE* bArr, DWORD dwNumBytes)
{
	HRESULT (__cdecl *_FP_FS_READ)(FILE*,BYTE*,DWORD);
	_FP_FS_READ = (HRESULT (__cdecl *)(FILE*,BYTE*,DWORD))(GetExportAddress(_OS_EXPORTS_FS_READ));

	return HSUCCEED(_FP_FS_READ(fHandle, bArr, dwNumBytes));
}

bool CloseFile(FILE* fHandle)
{
	HRESULT (__cdecl *_FP_FS_CLOSEFILE)(FILE*);
	_FP_FS_CLOSEFILE = (HRESULT (__cdecl *)(FILE*))(GetExportAddress(_OS_EXPORTS_FS_CLOSEFILE));

	return HSUCCEED(_FP_FS_CLOSEFILE(fHandle));
}
