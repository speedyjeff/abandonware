
echo off

if "%1"=="" (
	del build.log
	del build.err
	call %0 build.log build.err
	goto :EOF
)

setlocal

echo calling [del *.obj] >> %1
del *.obj >> %1 2>> %2
echo calling [del %BIN%\shell*] >> %1
del %BIN%\shell* >> %1 2>> %2

set INCLUDE=
set LIB=

set TARGETDIR=%BIN%
set TARGETNAM=shell
set COMPFLAGS=/I..\..\inc\internal /I..\..\inc\platform /Od /DX64
set LINKFLAGS=/NODEFAULTLIB /entry:main /release /DEBUG:FULL

echo TARGETDIR: %BIN% >> %1
echo TARGETNAM: %TARGETNAM% >> %1
echo COMPFLAGS: %COMPFLAGS% >> %1
echo LINKFLAGS: %LINKFLAGS% >> %1

echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Io.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Io.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Os.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Os.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Fs.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\platform\Fs.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c main.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c main.cpp >> %1 2>> %2 & echo .

echo calling [%CP_LINK% %LINKFLAGS% main.obj Io.obj Os.obj Fs.obj /out:%BIN%\%TARGETNAM%.exe] >> %1
%CP_LINK% %LINKFLAGS% main.obj Io.obj Os.obj Fs.obj /out:%BIN%\%TARGETNAM%.exe >> %1 2>> %2 & echo .

echo calling [%CP_EXELDR% %BIN%\%TARGETNAM%.exe /write %BIN%\%TARGETNAM% /wrtBase 0] >> %1
%CP_EXELDR% %BIN%\%TARGETNAM%.exe /write %BIN%\%TARGETNAM% /wrtBase 0 >> %1 2>> %2 & echo .

echo calling [del *.obj] >> %1
del *.obj >> %1 2>> %2 & echo .
echo calling [del *.pdb] >> %1
del *.pdb >> %1 2>> %2 & echo .

findstr /SIP error %1

endlocal

if not exist "%BIN%\shell.exe" echo ERROR: shell.exe failed to build
if not exist "%BIN%\shell" echo ERROR: shell failed to build
