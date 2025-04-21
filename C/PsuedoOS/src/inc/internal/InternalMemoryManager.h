
#include "ErrorCodes.h"

#ifdef _WINDOWS_SIDE
#include <windows.h>
#else
#include "types.h"
#include "constants.h"
#endif

#ifndef _INTERNALMEMORYMANAGER__H
#define _INTERNALMEMORYMANAGER__H

#define PAGE_SIZE 0x1000 // 4k page size

// Be very careful of the math and constants in this
//  file.  Make sure there is no overlap!

// data (RW)
const ULONG_PTR _MM_DATARAM_START  = 0x02100000; // start address
const ULONG_PTR _MM_DATARAM_SIZE   = 0x00100000; // size

const ULONG_PTR _KERNEL_DATASTRUCT =_MM_DATARAM_START; //0x02100000;
const ULONG_PTR _KERNEL_SIZE       = 0x00000200; // 512

const ULONG_PTR _FUNCTABLE_ADDRESS = _KERNEL_DATASTRUCT + _KERNEL_SIZE; // 0x02100200;
const ULONG_PTR _FUNCTABLE_SIZE    = 0x00000200; // 512

const ULONG_PTR _LOG_ADDRESS       = _FUNCTABLE_ADDRESS + _FUNCTABLE_SIZE; // 0x02100400;
const ULONG_PTR _LOG_SIZE          = 0x00000200; // 512

const ULONG_PTR _USERDATA_ADDRESS   = _LOG_ADDRESS + _LOG_SIZE; // 0x02100600; 
const ULONG_PTR _USERDATA_SIZE      = _MM_DATARAM_SIZE - _KERNEL_SIZE - _FUNCTABLE_SIZE - _LOG_SIZE; // size

const ULONG_PTR _MM_DATARAM_END    = _USERDATA_ADDRESS + _USERDATA_SIZE; // 0x02200000 

// todo - this code heap must be expanded to allow for more than 1 module load :)
// code (RWX)
const ULONG_PTR _MM_CODERAM_START  = _MM_DATARAM_END; // 0x02200000; 
const ULONG_PTR _MM_CODERAM_SIZE   = 0x00100000; // size

const ULONG_PTR _MM_CODERAM_END     = _MM_CODERAM_START + _MM_CODERAM_SIZE; // 0x02300000; 

// file system (FS) (RW)
const ULONG_PTR _FS_DEVICEADDRESS = _MM_CODERAM_END; // 0x02300000; 
const ULONG_PTR _FS_DEVICESIZE    = 0x00100000;

const ULONG_PTR _FS_END           = _FS_DEVICEADDRESS + _FS_DEVICESIZE; // 0x02400000; 


const ULONG_PTR _MM_CONST_CANARY   = 0x12345678;

struct _MM_FREEBLOCK_STRUCT
{
	ULONG_PTR                    _MM_CANARY;
	ULONG_PTR                    _MM_BLOCKSIZE;
	struct _MM_FREEBLOCK_STRUCT* _MM_NEXTBLOCK;
};

HRESULT _MM_INITIALIZE();

HRESULT _MM_NALLOC(ULONG_PTR* blockAdr, ULONG_PTR dwBlockSize);
HRESULT _MM_NFREE(ULONG_PTR* blockAdr);

#endif
