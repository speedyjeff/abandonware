
#include "types.h"
#include "InternalOS.h"
#include "InternalIO.h"
#include "InternalFS.h"
#include "InternalLog.h"
#include "InternalLD.h"

void  CommandLineLoop();
BOOL  Match(char* str, char* command);
char  Lwr(char c);
void  WriteHresult(HRESULT hr);
void  DisplayString(char* str);
void  CreateArray(char* str, DWORD dwLen, DWORD* argc, char** argv);
void  ShowHelp(DWORD argc, CHAR** argv);
void  LoadModule(DWORD argc, CHAR** argv);

DWORD main(ULONG_PTR lpParameter)
{
	HRESULT  retVal;

	retVal = _OS_INITIALIZE();

	if (HFAILED(retVal)) return 1;

	_LOG_WRITE('m', 'a', 'i', 'n');

	_IO_PUTCHAR('O');
	_IO_PUTCHAR('S');
	_IO_PUTCHAR(' ');
	_IO_PUTCHAR('L');
	_IO_PUTCHAR('o');
	_IO_PUTCHAR('a');
	_IO_PUTCHAR('d');
	_IO_PUTCHAR('i');
	_IO_PUTCHAR('n');
	_IO_PUTCHAR('g');
	_IO_PUTCHAR('.');
	_IO_PUTCHAR('.');
	_IO_PUTCHAR('.');
	_IO_PUTCHAR('\r');
	_IO_PUTCHAR('\n');

	// register the base shell commands
	CHAR szC1[] = {'h','e','l','p','\0'};
	CHAR szD1[] = {'\0'};
	retVal = _OS_REGISTERCALLBACK(szC1, szD1, (_OS_CALLBACK)ShowHelp);

	if (HFAILED(retVal))
	{
		_IO_PUTCHAR('F');
		_IO_PUTCHAR('a');
		_IO_PUTCHAR('i');
		_IO_PUTCHAR('l');
		_IO_PUTCHAR('e');
		_IO_PUTCHAR('d');
		_IO_PUTCHAR(' ');
		WriteHresult(retVal);
	}

	CHAR szC2[] = {'l','o','a','d','\0'};
	CHAR szD2[] = {'<','f','i','l','e',' ','n','a','m','e','>','\0'};
	retVal = _OS_REGISTERCALLBACK(szC2, szD2, (_OS_CALLBACK)LoadModule);

	if (HFAILED(retVal))
	{
		_IO_PUTCHAR('F');
		_IO_PUTCHAR('a');
		_IO_PUTCHAR('i');
		_IO_PUTCHAR('l');
		_IO_PUTCHAR('e');
		_IO_PUTCHAR('d');
		_IO_PUTCHAR(' ');
		WriteHresult(retVal);
	}

	// run the command line loop
	CommandLineLoop();

	_FS_FLUSHDISK();

	return 0;
}

#define MAX_BUFFER_SIZE 128
#define MAX_ARGUMENTS   20

void CommandLineLoop()
{
	char       buffer[MAX_BUFFER_SIZE];	// must be long enough to hold the longest command
	char*      argv[MAX_ARGUMENTS];
	DWORD      argc;
	int        counter;
	HRESULT    hr;
	_KERNEL_CALLBACK_STRUCT** osCallBacks;

	_LOG_WRITE('t', 's', 'h', ' ');

	// grab pointer to callback array
	osCallBacks = (_KERNEL_CALLBACK_STRUCT**)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_CALLBACKS;

	if (osCallBacks == NULL)
	{
		// this is a bad environment
		_LOG_WRITE('t', 's', 'h', 'n');
		_IO_PUTCHAR('b');
		_IO_PUTCHAR('a');
		_IO_PUTCHAR('d');
		_IO_PUTCHAR(' ');
		_IO_PUTCHAR('e');
		_IO_PUTCHAR('n');
		_IO_PUTCHAR('v');
		_IO_PUTCHAR('i');
		_IO_PUTCHAR('r');
		_IO_PUTCHAR('o');
		_IO_PUTCHAR('n');
		_IO_PUTCHAR('m');
		_IO_PUTCHAR('e');
		_IO_PUTCHAR('n');
		_IO_PUTCHAR('t');
		_IO_PUTNEWLINE();
		return;
	}

	ShowHelp(0, NULL);

	_IO_PUTCHAR('>');
	_IO_PUTCHAR(' ');

	counter = 0;
	while(true)
	{
		// get input and print it back out
		char c = _IO_GETCHAR();

		// this is an error condition... just cheat and continue to replace the last element
		if (counter >= MAX_BUFFER_SIZE)
		{
			_IO_PUTCHAR('\b');
			counter = MAX_BUFFER_SIZE-1;
		}
	
		// indicates a complete command has been entered
		if ('\n' == c || '\r' == c)
		{
			if (counter > 0)
			{
				_IO_PUTCHAR('\r');
				_IO_PUTCHAR('\n');

				// parse the buffer into tokens
				buffer[ counter ] = '\0';
				CreateArray((char*)buffer, MAX_BUFFER_SIZE, &argc, (char**)argv);

				// put the command place holder
				_LOG_WRITE('-', '-', '-', '-');

				// run the command
				hr = ERROR_UNKNOWN_COMMAND;

				// try all callbacks to see if this command
				//  is knownh
				if (NULL != osCallBacks)
				{
					for(int i=0; i<_OS_CONST_MAX_CALLBACKS; i++)
					{
						if (NULL != osCallBacks[i])
						{
							// check to see if the command matches
							if (Match(argv[0], (char*)osCallBacks[i]->chCommand))
							{
								_LOG_WRITE('t', 's', 'h', 'c');
								// call the function
								_OS_CALLBACK lpMethodAdr = (_OS_CALLBACK)(osCallBacks[i]->lpMethodAdr);
								_OS_BREAKPOINT();
								lpMethodAdr(argc, (CHAR**)argv);
								hr = ERROR_SUCCESS;									
								break;
							}
						}
					}
				}

				// check if the command was successful
				if (HFAILED(hr))
				{
					// write out a message that it was not successful
					_IO_PUTCHAR('f');
					_IO_PUTCHAR('a');
					_IO_PUTCHAR('i');
					_IO_PUTCHAR('l');
					_IO_PUTCHAR('e');
					_IO_PUTCHAR('d');
					_IO_PUTCHAR(' ');
					_IO_PUTCHAR('t');
					_IO_PUTCHAR('o');
					_IO_PUTCHAR(' ');
					_IO_PUTCHAR('e');
					_IO_PUTCHAR('x');
					_IO_PUTCHAR('e');
					_IO_PUTCHAR('c');
					_IO_PUTCHAR('u');
					_IO_PUTCHAR('t');
					_IO_PUTCHAR('e');
					_IO_PUTCHAR(' ');
					_IO_PUTCHAR('c');
					_IO_PUTCHAR('o');
					_IO_PUTCHAR('m');
					_IO_PUTCHAR('m');
					_IO_PUTCHAR('a');
					_IO_PUTCHAR('n');
					_IO_PUTCHAR('d');
					_IO_PUTNEWLINE();
				}

				// reset the shell
				counter = 0;
				_IO_PUTCHAR('\r');
				_IO_PUTCHAR('\n');
				_IO_PUTCHAR('>');
				_IO_PUTCHAR(' ');
			}
		}
		else
		{
			// accumulate the command in the buffer
			if (c == '\b')
			{
				// backspace
				if (counter > 0) buffer[--counter] = '\0';
			}
			else
			{
				// add to buffer and write to screen
				_IO_PUTCHAR(c);
				buffer[counter++] = c;
			}
		}
	}
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

void WriteHresult(HRESULT hr)
{
	_IO_PUTCHAR('h');
	_IO_PUTCHAR('r');
	_IO_PUTCHAR('=');
	_IO_PUTCHAR('0');
	_IO_PUTCHAR('x');

	// convert HRESULT to chars
	for (int i=7; i>=0; i--) _IO_PUTCHAR( ToHex((BYTE)((hr >> (i*4)) & 0xf)) );
}

void CreateArray(char* str, DWORD dwLen, DWORD* argc, char** argv)
{
	// iterate through the string and convert all "non-words"
	//  into \0
	// Also create the 2D array
	// There are two types patterns that we are checking:
	//   'abcd efg  hi' == 'abcd\0efg\0\0hi'
	//   '"abcd efg"  hi' == '\0abcd efg\0\0\0hi'
	BOOL  inQuote;
	char* sPtr;

	if (NULL == str) return;

	(*argc) = 0;

	// mark the first element
	sPtr   = (str);
	while (*sPtr == '"') { sPtr++; }
	if (*sPtr != '\0' && *sPtr != '\n' && *sPtr != '\r')
	{
		argv[(*argc)++]  = sPtr;
	}

	inQuote = FALSE;
	for(int i=0; i<dwLen; i++)
	{
		if ('"' == str[i])
		{
			inQuote = !inQuote;
			str[i] = '\0';
		}
		else if (!inQuote && (' ' == str[i] || '\t' == str[i]))
		{
			str[i] = '\0';
			// mark the next element
			sPtr   = (str+i+1);
			while (*sPtr == '"') { sPtr++; }
			if (*sPtr != '\0' && *sPtr != '\n' && *sPtr != '\r' && MAX_ARGUMENTS > (*argc))
			{
				argv[(*argc)++]  = sPtr;
			}
		}
	}
}

char Lwr(char c)
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

BOOL  Match(char* str, char* command)
{
	int i;

	if (NULL == str || NULL == command) return FALSE;

	// ASSERT() command must be null terminated
	// ASSERT() str is always longer than command
	for(i=0; '\0' != command[i] && '\0' != str[i]; i++)
	{
		if (Lwr(str[i]) != Lwr(command[i])) return FALSE;
	}

	return ('\0' == str[i] && '\0' == command[i]);
}

void DisplayString(char* str)
{
	while(NULL != str && '\0' != *str)
	{
		_IO_PUTCHAR(*str);
		str++;
	}
}

void  ShowHelp(DWORD argc, CHAR** argv)
{
	_KERNEL_CALLBACK_STRUCT** osCallBacks;

	_LOG_WRITE('t', 's', 'h', 'h');

	// grab pointer to callback array
	osCallBacks = (_KERNEL_CALLBACK_STRUCT**)((struct _KERNEL_STRUCT*)_KERNEL_DATASTRUCT)->_OS_CALLBACKS;

	if (osCallBacks != NULL)
	{
		// print out the list of commands
		for(int i=0; i<_OS_CONST_MAX_CALLBACKS; i++)
		{
			if (NULL != osCallBacks[i])
			{
				DisplayString((char*)osCallBacks[i]->chCommand);
				_IO_PUTCHAR(' ');
				DisplayString((char*)osCallBacks[i]->chDescription);
				_IO_PUTCHAR('\r');
				_IO_PUTCHAR('\n');
			}
		}
	}
	else
	{
		CHAR szMsg[] = {'N','o',' ','C','o','m','m','a','n','d','s',' ','R','e','g','i','s','t','e','r','e','d', '\0'};
		DisplayString((char*)szMsg);
		_IO_PUTNEWLINE();
	}
}

void LoadModule(DWORD argc, CHAR** argv)
{
	_LOG_WRITE('t', 's', 'h', 'l');

	if (argc >= 2)
	{
		_LD_ENTRYPOINT lpEntrypoint = NULL;
		// load the code and run the module
		HRESULT hr = _LD_LOADMODULE((char*)argv[1], &lpEntrypoint);
		if (HFAILED(hr))
		{
			_IO_PUTCHAR('f');
			_IO_PUTCHAR('a');
			_IO_PUTCHAR('i');
			_IO_PUTCHAR('l');
			_IO_PUTCHAR(' ');
			WriteHresult(hr);
			_IO_PUTNEWLINE();
		}
		else
		{
			lpEntrypoint(NULL);
		}
	}
	else
	{
		CHAR szMsg[] = {'I','n','v','a','l','i','d',' ','n','u','m','b','e','r',' ','o','f',' ','a','r','g','u','m','e','n','t','s', '\0'};
		DisplayString((char*)szMsg);
		_IO_PUTNEWLINE();
	}
}
