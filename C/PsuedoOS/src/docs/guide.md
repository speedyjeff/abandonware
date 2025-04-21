# Guide for development
The code written in this psuedo machine is overly constrained.  As such there are very strict guidelines to follow to remain functional.

## Building
The build is broken into three parts.

The tools used to extract the code an package for use within the psuedo machine and setup the file system.
```
buildtools.bat
```

Builds the psuedo machine and kernel.
```
build.bat
```

Builds the extension libraries - eg. shell.
```
buildext.bat
```

A common command line to run is the following, which sets up the file system with fresh copies of kernel and shell and starts the psuedo machine.
```
FSControl.exe /format /copy kernel kernel /copy shell shell & psuedomch.exe
```

## Platform Code
Examples of this code are the shell.  All code must be:
 - C only
 - No strings and no need for a .data section
 - Use only the headers and code provided in Platform

## Kernel Code
Same rules as Platform, but you have access to the Full range of Internal components.

## PsuedoMch and Tools Code
In shared code it is written under the define _WINDOWS_SIDE.  This code can use anything in the platform.

## Debugging
Debugging the platform/hardware abstraction side of the code is traditional C - straight forward.  Debugging the kernel and subsequent platform modules (shell, dbmod, etc.) is a challenge.  The most useful tool is to log often and use the log as a trace of what has happened within the process.  

Each of the complex subsystems can be debugged on the platform side via command line tools - fscontrol for file system and memsim for memory management.  Debugging first in these environments will provide the least frustrating experience.

Once debugging within the pseudo machine, below are a few tricks.

```
0:004> dt psuedomch!_LOG_ADDRESS
_LOG_ADDRESS = 0x2100400
0:004> dc 0x2100400 l50
00000000`02100400  00000087 6e69492a 69462a20 6f2a206e  ....*Iin *Fin *o
00000000`02100410  2a207475 7264206c 706f662a 73662a6e  ut *l dr*fopn*fs
00000000`02100420  662a7a69 2a206472 6f67206c 6c63662a  iz*frd *l go*fcl
00000000`02100430  69742a73 692a206e 2a206e69 206e6966  s*tin *iin *fin 
00000000`02100440  65206f2a 206f2a66 6f2a6665 2a666520  *o ef*o ef*o ef*
00000000`02100450  6665206f 65206f2a 206f2a66 6f2a6665  o ef*o ef*o ef*o
00000000`02100460  2a666520 6665206f 65206f2a 206f2a66   ef*o ef*o ef*o 
00000000`02100470  6f2a6665 2a666520 2074756f 69616d2a  ef*o ef*out *mai
00000000`02100480  73742a6e 002a2068 00000000 00000000  n*tsh *.........
00000000`02100490  00000000 00000000 00000000 00000000  ................
00000000`021004a0  00000000 00000000 00000000 00000000  ................
00000000`021004b0  00000000 00000000 00000000 00000000  ................
00000000`021004c0  00000000 00000000 00000000 00000000  ................
00000000`021004d0  00000000 00000000 00000000 00000000  ................
00000000`021004e0  00000000 00000000 00000000 00000000  ................
00000000`021004f0  00000000 00000000 00000000 00000000  ................
00000000`02100500  00000000 00000000 00000000 00000000  ................
00000000`02100510  00000000 00000000 00000000 00000000  ................
00000000`02100520  00000000 00000000 00000000 00000000  ................
00000000`02100530  00000000 00000000 00000000 00000000  ................
```

To get near/at a point of interest in the code, add a call to Breakpoint() in the code and set a breakpoint on the platform side.

```
bp psuedomch!_WND_BREAKPOINT()
```
