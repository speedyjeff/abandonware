
#include "Types.h"
#include "ErrorCodes.h"
#include "Io.h"
#include "Os.h"
#include "Fs.h"

HRESULT CmdCallBack(DWORD argc, char** argv);
void DisplayHelp(char* szDIR, char* szCD, char* szCFILE, char* szTYPE);

void ListDirectory(DWORD argc, char** argv)
{
	ListCurrentDirectory();
}

void ChangeCurrentDirectory(DWORD argc, char** argv)
{
	if (2 <= argc)
	{
		ChangeDirectory(argv[1]);
	}
	else
	{
		print("Invalid number of arguments for cd command\n");
	}
}

void MakeNewDirectory(DWORD argc, char** argv)
{
	if (2 <= argc)
	{
		MakeDirectory(argv[1]);
	}
	else
	{
		print("Invalid number of arguments for md command\n");
	}
}

void RemoveExistingDirectory(DWORD argc, char** argv)
{
	if (2 <= argc)
	{
		RemoveEntity(argv[1]);
	}
	else
	{
		print("Invalid number of arguments for rm command\n");
	}
}

DWORD main(ULONG_PTR lpModule)
{
	char title[13] = {'S', 'h', 'e', 'l', 'l', ' ', 'L', 'o', 'a', 'd', 'e', 'd', '\0'};

	print(title);
	newline();

	CHAR szC1[] = {'l','s','\0'};
	CHAR szD1[] = {'\0'};
	RegisterCmdCallback(szC1, szD1, (_OS_CALLBACK)ListDirectory);

	CHAR szC2[] = {'c','d','\0'};
	CHAR szD2[] = {'<', 'd', 'i', 'r', 'e', 'c', 't', 'o', 'r', 'y', '>', '\0'};
	RegisterCmdCallback(szC2, szD2, (_OS_CALLBACK)ChangeCurrentDirectory);

	CHAR szC3[] = {'m','d','\0'};
	CHAR szD3[] = {'<', 'd', 'i', 'r', 'e', 'c', 't', 'o', 'r', 'y', '>', '\0'};
	RegisterCmdCallback(szC3, szD3, (_OS_CALLBACK)MakeNewDirectory);

	CHAR szC4[] = {'r','m','\0'};
	CHAR szD4[] = {'<', 'd', 'i', 'r', 'e', 'c', 't', 'o', 'r', 'y', '|', 'f', 'i', 'l', 'e', '>', '\0'};
	RegisterCmdCallback(szC4, szD4, (_OS_CALLBACK)RemoveExistingDirectory);

	return 0;
}

