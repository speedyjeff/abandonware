
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

set INCLUDE=
set LIB=

set TARGETNAM=kernel
set COMPFLAGS=/I..\inc\internal /I..\inc\platform /O1 /DX64
set LINKFLAGS=/NODEFAULTLIB /entry:main /release /DEBUG:FULL

echo TARGETDIR: %BIN% >> %1
echo TARGETNAM: %TARGETNAM% >> %1
echo COMPFLAGS: %COMPFLAGS% >> %1
echo LINKFLAGS: %LINKFLAGS% >> %1

echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalLog.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalLog.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalIO.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalIO.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalOS.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalOS.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalFS.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalFS.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalMemoryManager.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalMemoryManager.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalFunctionTable.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalFunctionTable.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalLD.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /GS- /c ..\library\internal\InternalLD.cpp >> %1 2>> %2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /Od /GS- /c main.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /Od /GS- /c main.cpp >> %1 2>> %2 & echo .

echo calling [%CP_LINK% %LINKFLAGS% main.obj InternalLog.obj InternalIO.obj InternalOS.obj InternalFS.obj InternalMemoryManager.obj InternalFunctionTable.obj InternalLD.obj /out:%BIN%\%TARGETNAM%.exe] >> %1
%CP_LINK% %LINKFLAGS% main.obj InternalLog.obj InternalIO.obj InternalOS.obj InternalFS.obj InternalMemoryManager.obj InternalFunctionTable.obj InternalLD.obj /out:%BIN%\%TARGETNAM%.exe >> %1 2>> %2 & echo .

echo calling [%CP_EXELDR% %BIN%\%TARGETNAM%.exe /write %BIN%\%TARGETNAM% /wrtBase 0] >> %1
%CP_EXELDR% %BIN%\%TARGETNAM%.exe /write %BIN%\%TARGETNAM% /wrtBase 0 >> %1 2>> %2 & echo .

echo calling [del *.obj] >> %1
del *.obj >> %1 2>> %2 & echo .
echo calling [del *.pdb] >> %1
del *.pdb >> %1 2>> %2 & echo .

findstr /SIP error %1

endlocal

if not exist "%BIN%\kernel.exe" echo ERROR: kernel.exe failed to build
if not exist "%BIN%\kernel" echo ERROR: kernel failed to build
