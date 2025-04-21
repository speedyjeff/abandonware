
#if !defined(_TYPES__H)
#define _TYPES__H

// Type def
typedef int DWORD;
typedef short WORD;
typedef unsigned char BYTE;
typedef long LONG;
typedef DWORD HRESULT;
typedef int BOOL;
typedef BYTE CHAR;
typedef void VOID;

// platform specific
#if X86
typedef LONG SIZE_T;
typedef LONG ULONG_PTR;
#elif X64
typedef long long SIZE_T;
typedef unsigned long long ULONG_PTR;
#else
#error undefined processor architecture
#endif

// custom
typedef ULONG_PTR HANDLE;
typedef struct { ULONG_PTR p1; DWORD p2; DWORD p3; } FILE;

#endif
