# Architecture

## Overall
The system is a layer cake of functionality.  There are three primary layers:

 0. PAL/HAL (platform and hardware abstraction layer)
 1. Kernel
 2. User mode

Due to layering, modules can depend modules in higher layers.  For example, module 0 cannot depend on any other module (including 1).  On the other hand, module 1 can rely on 0.

 0. PAL/HAL (PseudoMachine)

 1. Kernel
  - IO
  - Code heap manager
  - Memory manager
  - File system
  - Function pointers
  - Logging
  - Command line processing

 2. User mode / Applications
  - shell
  - dbmod

Pseduo Machine is a normal Windows application with an edit control to handle console input and output.  Layers 1 and 2 live within the pseudo machine and have special developement requirements for how the code is written.

## Memory Management
The memory for the system is broken into several chunks with specific purposes.

 - Data heap (loaded as RW)
  - Kernel memory
  - Function table
  - Log
  - User data
 - Code heap (loaded as RWX)
 - File system

Direct access to these memory sections and the management of the memory is done in individual subsystems within the kernel.

### File System
The file system is were all foreign files are placed before loading within the psuedo machine.  This includes the code for the kernel.

The overall design of the file system is a structure that represents all files and directories which resides in-line with the data and a bit field representing free space.

```
// Layout
// 0x00000 ---------------------------
//         | _FS_DIRECOTYR_STRUCT
//         |   Parent directory
// 0x00039 ---------------------------
// 0x00040 | _FS_FREE_SPACE
//         |   Byte array for disk
//         |   free space
// 0x00800 ---------------------------
// 0x00801 | directories/files
//         | ...
// 0xfffff ---------------------------
```

The structure has a canary (to validate correctness), size, name, and offset based links to parents, peers, and children.

Freespace is managed with a bit map that has 1 bit for every segment in on disk.
 - Disks are 1mb of space (0x10_0000)
 - Segement are 64bytes (0x40) (which is just larger than the file/directory structure)
 - 1mb represents 16k segements where each segment is represented by 1 bit or 2k bytes (less than 1% of book keeping)

The file system is backed by a file on disk.

### Function Table
The function table contains pointers to functions that are defined within the PAL/HAL and are callable from layers 1 and up.

### OS Exports
The OS exports are a set of pointers to functions that originate within the psuedo machine (layer 1) and are callable from layer 2.  These pointers are pointing to code that resides in the code heap.

### Logging
Log all over the code, as this is the primary and most effective way to understand what has happened and more likely why it is not working.  The log buffer is a ring buffer of 512 bytes (most messages are 5 bytes long)

### Code Heap
The code heap is allocated such that code can execute.  All code that resides in this heap was produced by the 

### Malloc/Free
Native alloc and free is managed by an inline data structure within the free spaces.  The data structure has a canary to ensure data consistency, size, and a pointer to the next free block.

## Command Line Processing
The kernel manages the input and tool calling in the command line.  The user code can register commands that show up in the help and expand what commands can be called.

## IO
Console IO is really simple, PutChar, GetChar, and PutNewLine.


