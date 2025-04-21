# Tools
These tools are crical for setting up the environment to execute within the psuedo machine.  They are also useful for debugging some of the more complex sub systems within the psuedo machine.

## FSControl
The FSControl tool manages the files system.  In order for the psuedo machine to boot, there must be a formatted file system with 'kernel' in the root folder.

```
Usage: FSControl.exe [/create] [/format] [/md <dir>] [/cd <dir>] [/ls]
       [/copy <source file> <dest file>]
       [/rm <file>]
```

A few good tests:

```
FSControl.exe /cd .. /ls
FSControl.exe /format /copy kernel kernel /md usr /cd usr /copy kernel kernel /cd .. /ls
FSControl.exe /format /copy kernel kernel /md usr /copy shell shell /rm kernel /ls
...
```

## ExeLdr
The ExeLdr tool parses the PE32+ image and extracts the first .text section seen and emits a jmp thunk to the entry point method.  This tool is used to process every binary suitable to run within the psuedo machine.

```
Usage: ExeLdr.exe PEImageName [/test] [/dump]
          [/write fileName] [/wrtBase int] [/wrtSize int]
          [/emitJmpThunk]
  /test      - The app will be loaded into memory
               and the main method will be called
  /dump      - Dump PE information
  /write str - Write image to file
  /wrtBase # - Image base for the image written to file
  /wrtSize # - Size of image to write to file
  /emitJmpThunk - Emit a jump thunk at the first address of the file

```

## MemSim
The MemSim tool uses the memory management system and allows for validation and debugging.

```
Usage: MemSim.exe [/alloc size] [/free id]
   * id's increment with every alloc starting at 0
   * max of 1000 allocs
```

A few good tests:

```
MemSim.exe /alloc 100 /alloc 100
MemSim.exe /alloc 100 /alloc 100 /free 0 /alloc 200 /free 1 /alloc 100
...
```
