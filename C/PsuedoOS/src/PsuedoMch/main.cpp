#include <windows.h> 
#include <stdio.h>
#include <tchar.h>

#include "RingBuffer.h"
#include "psuedomchexports.h"

#include "InternalOS.h"
#include "InternalMemoryManager.h"
#include "InternalLD.h"
#include "ErrorCodes.h"
 
#define ID_EDITCHILD 1001
#define BUFFER_SIZE  65000
#define STR_SIZE     128

// Global variables 
HWND       g_hwndEdit;
RingBuffer g_ringBuffer;
char       g_strReason[ STR_SIZE ];
size_t     g_prevLen;

 
// Function prototypes. 
BOOL    InitApplication(HINSTANCE);
BOOL    InitInstance(HINSTANCE, int);
BOOL    InitOSThread();
LRESULT CALLBACK MainWndProc(HWND, UINT, WPARAM, LPARAM);
 
int WINAPI WinMain(HINSTANCE hinstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) 
{
	MSG  msg;
	BOOL fGotMessage;

	// init globals
	g_prevLen  = 0;
	g_hwndEdit = NULL;

	// inialize the window
	if (!InitApplication(hinstance))
	{
		printf("Failed to inialize the application\n");
		return FALSE;
	}

	if (!InitInstance(hinstance, nCmdShow))
	{
		printf("Failed to instantiate the application\n");
		return FALSE;
	}

	if (!InitOSThread())
	{
		MessageBox(NULL,
			g_strReason,
			"Failed to init OS thread",
			MB_OK);
		return FALSE;
	}

	while ((fGotMessage = GetMessage(&msg, (HWND) NULL, 0, 0)) != 0 && fGotMessage != -1) 
	{ 
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	} 

	return msg.wParam;
}


BOOL InitApplication(HINSTANCE hinstance) 
{ 
	WNDCLASSEX wcx;
 
	wcx.cbSize        = sizeof(wcx);
	wcx.style         = CS_HREDRAW | CS_VREDRAW;
	wcx.lpfnWndProc   = MainWndProc;
	wcx.cbClsExtra    = 0;
	wcx.cbWndExtra    = 0;
	wcx.hInstance     = hinstance;
	wcx.hIcon         = LoadIcon(NULL, IDI_APPLICATION);
	wcx.hCursor       = LoadCursor(NULL, IDC_ARROW);
	wcx.hbrBackground = (HBRUSH)CreateSolidBrush(RGB(0, 0, 0));
	wcx.lpszMenuName  = "MainMenu";
	wcx.lpszClassName = "MainWClass";
	wcx.hIconSm       = (HICON__*)LoadImage(hinstance, MAKEINTRESOURCE(5), IMAGE_ICON, GetSystemMetrics(SM_CXSMICON), GetSystemMetrics(SM_CYSMICON), 0);
 
	return RegisterClassEx(&wcx);
} 

BOOL InitInstance(HINSTANCE hinstance, int nCmdShow) 
{ 
	HWND hwnd;
 
	// Create the main window. 
 
	hwnd = CreateWindow(
			"MainWClass",		// name of window class 
			"Psuedo Machine",	// title-bar string 
			WS_OVERLAPPEDWINDOW,	// top-level window 
			CW_USEDEFAULT,	   	// default horizontal position 
			CW_USEDEFAULT,	   	// default vertical position 
			640,	   		// default width 
			480,	   		// default height 
			(HWND)NULL,		// no owner window 
			(HMENU)NULL,		// use class menu 
			hinstance,		// handle to application instance 
			(LPVOID)NULL);	  	// no window-creation data 
 
	if (!hwnd)
	{
		printf("Failed to create main window\n");
		return FALSE;
	}

	ShowWindow(hwnd, nCmdShow);
	UpdateWindow(hwnd);
	return TRUE;
 
}

BOOL InitOSThread()
{
	HRESULT   retVal;
	LPVOID    lpBaseAddress;
	HANDLE    tKThread;
	DWORD     dwThreadID;

	retVal = _OS_INITIALIZE();

	if (HFAILED(retVal))
	{
		if (retVal == ERROR_FILE_NOT_FOUND)
		{
			strcpy_s(g_strReason, STR_SIZE, "Failed to initalize the OS - ensure hnd exists\n");
		}
		else
		{
			sprintf_s(g_strReason, STR_SIZE, "Failed to initalize the OS (0x%x)\n", retVal);
		}
		return FALSE;
	}

	// read in the kernel
	_LD_ENTRYPOINT lpEntrypoint = NULL;
	retVal = _LD_LOADMODULE("kernel", &lpEntrypoint);

	if (HFAILED(retVal))
	{
		if (retVal == ERROR_FILE_NOT_FOUND)
		{
			strcpy_s(g_strReason, STR_SIZE, "Failed to load kernel - ensure kernel is loaded into the root of hnd\n");
		}
		else
		{
			sprintf_s(g_strReason, STR_SIZE, "Failed to load kernel (0x%x)\n", retVal);
		}
		return FALSE;
	}

	// start kernel
	tKThread = CreateThread(NULL,
			0, // attributes
			(LPTHREAD_START_ROUTINE)lpEntrypoint,
			NULL,
			0,
			&dwThreadID);

	if (NULL == tKThread)
	{
		sprintf_s(g_strReason, STR_SIZE, "%s", "Failed to start krnl up\n");
		return FALSE;
	}

	return TRUE;
}

LRESULT CALLBACK MainWndProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam)
{
	switch(uMsg) {
	case WM_CREATE:
		// create the edit box
		g_hwndEdit = CreateWindowExA(
					0, // Extended window style
					"EDIT",	// Window class name
					NULL,		// Window name
					WS_CHILD | WS_VISIBLE | WS_VSCROLL | ES_LEFT | ES_MULTILINE | ES_AUTOVSCROLL, // Window style
					0, // x pos
					0, // y pos
					0, // width
					0, // height
					hWnd, // parent window 
					(HMENU)ID_EDITCHILD, // menu
					(HINSTANCE)NULL, // instance handle
					NULL // additional data
					);

		// initalize the edit box
		HFONT hFont;

		hFont = CreateFont(20,			// nHeight
				0,			// nWidth
				0,			// nEscapement
				0,			// nOrientation
				FW_NORMAL,		// nWeight
				FALSE,			// bItalic
				FALSE,			// bUnderline
				0,			// cStrikeOut
				ANSI_CHARSET,		// nCharSet
				OUT_DEFAULT_PRECIS,	// nOutPrecision
				CLIP_DEFAULT_PRECIS,	// nClipPrecision
				DEFAULT_QUALITY,	// nQuality
				DEFAULT_PITCH | FF_SWISS,	// nPitchAndFamily
				"Courier New");		// lpszFacename


		SendMessage(g_hwndEdit, WM_SETFONT, (WPARAM)hFont, 0);

		return TRUE;
	case WM_COMMAND:
		switch(HIWORD(wParam))
		{
		case EN_CHANGE:
			// BUG BUG!  For now it only gets the last character
			size_t size;
			TCHAR buffer[ BUFFER_SIZE ];
			TCHAR c;

			size = SendMessage(g_hwndEdit, WM_GETTEXTLENGTH, 0, 0);

			if (size < BUFFER_SIZE)
			{
				SendMessage(g_hwndEdit, WM_GETTEXT, BUFFER_SIZE, (LPARAM)buffer);
				size_t len = _tcslen(buffer);

				if (len < g_prevLen)
				{
					c = '\b';
				}
				else
				{
					c = buffer[ len - 1 ];
				}
				g_prevLen = len;

				switch(c)
				{
				case '\n':
				case '\r':
					// special case the newline / cariage returns
					g_ringBuffer.Push( '\r' );
					g_ringBuffer.Push( '\n' );
					len--;
					break;
				default:
					// save the character
					g_ringBuffer.Push( c );
				}

				// delete the character just typed
				if ('\b' != c) buffer[ len - 1 ] = _T('\0');

				SendMessage(g_hwndEdit, WM_SETTEXT, 0, (LPARAM)buffer); 
				_WND_MOVECURSEND();
			}
			else
			{
				_WND_PUTCHAR('O');
				_WND_PUTCHAR('O');
				_WND_PUTCHAR('M');
				_WND_PUTCHAR('!');
			}

			break;
		}
		break;
	case WM_SIZE: 
            // Make the edit control the size of the window's client area. 

            MoveWindow(g_hwndEdit, 
                       20, 20,                  // starting x- and y-coordinates 
                       LOWORD(lParam)-40,        // width of client area 
                       HIWORD(lParam)-40,        // height of client area 
                       TRUE);                 // repaint window 
            return 0; 
	case WM_DESTROY:
		PostQuitMessage(0);
		break;
	}
	return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

VOID _WND_PUTCHAR(CHAR c)
{
	// this algorithm always puts the char at the end
	//  of the stream
	size_t size;
	TCHAR buffer[ BUFFER_SIZE ];

	size = SendMessage(g_hwndEdit, WM_GETTEXTLENGTH, 0, 0);

	// add room for the new character character
	size++;

	if (size < BUFFER_SIZE)
	{
		SendMessage(g_hwndEdit, WM_GETTEXT, BUFFER_SIZE, (LPARAM)buffer);
		size_t len = _tcslen(buffer);
		buffer[ len ]   = c;
		buffer[ len+1 ] = _T('\0');
	}
	else
	{
		_tcscpy_s(buffer, BUFFER_SIZE, _T("oom"));
	}

	SendMessage(g_hwndEdit, WM_SETTEXT, 0, (LPARAM)buffer); 
	_WND_MOVECURSEND();
}

CHAR _WND_GETCHAR()
{
	// block if empty
	while (g_ringBuffer.IsEmpty()) { Sleep(0); }
	return g_ringBuffer.Pop();
}

HRESULT _WND_BREAKPOINT()
{
	return ERROR_SUCCESS;
}

VOID _WND_MOVECURSEND()
{
	SendMessage(g_hwndEdit, EM_SETSEL , (WPARAM)BUFFER_SIZE, (LPARAM)BUFFER_SIZE);
	SendMessage(g_hwndEdit, EM_SCROLL , (WPARAM)SB_PAGEDOWN, (LPARAM)0);
	SendMessage(g_hwndEdit, EM_SCROLL , (WPARAM)SB_PAGEDOWN, (LPARAM)0);
	SendMessage(g_hwndEdit, EM_SCROLL , (WPARAM)SB_PAGEDOWN, (LPARAM)0);
	SendMessage(g_hwndEdit, EM_SCROLL , (WPARAM)SB_PAGEDOWN, (LPARAM)0);
}

VOID _WND_CLEARSREEN()
{
	SendMessage(g_hwndEdit, WM_SETTEXT, 0, (LPARAM)"");
}

