set INCLUDE=C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\um;%INCLUDE%
set INCLUDE=C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\shared;%INCLUDE%
set INCLUDE=C:\Program Files (x86)\Windows Kits\10\Include\10.0.19041.0\ucrt;%INCLUDE%
set INCLUDE=C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Tools\MSVC\14.43.34618\include;%INCLUDE%
set LIB=C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\um\x64;%LIB%
set LIB=C:\Program Files (x86)\Windows Kits\10\Lib\10.0.19041.0\ucrt\x64;%LIB%
set LIB=C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Tools\MSVC\14.43.34618\lib\x64;%LIB%

REM Must be absolute path
set BIN=%CD%\bin
mkdir %BIN%

set CP_NCPP="C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Tools\MSVC\14.43.34618\bin\Hostx64\x64\cl.exe"
set CP_LINK="C:\Program Files\Microsoft Visual Studio\2022\Preview\VC\Tools\MSVC\14.43.34618\bin\Hostx64\x64\link.exe"
set CP_EXELDR=%BIN%\ExeLdr.exe
set CP_FSCONTROL=%BINT%\FSControl.exe

set _NT_SYMBOL_PATH=%BIN%
set _NT_SOURCE_PATH=src

