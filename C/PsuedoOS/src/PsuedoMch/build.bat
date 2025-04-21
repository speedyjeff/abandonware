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

set TARGETNAM=psuedomch
set COMPFLAGS=/Zi /wd4005 /I..\inc\internal /I..\inc\platform /I. /D_WINDOWS_SIDE /D_DEBUG /DX64
set LINKFLAGS=kernel32.lib user32.lib Gdi32.lib /DEBUG 

echo TARGETDIR:   %BIN% >> %1
echo TARGETNAM: %TARGETNAM% >> %1
echo COMPFLAGS: %COMPFLAGS% >> %1
echo LINKFLAGS:   %LINKFLAGS% >> %1

echo calling [%CP_NCPP% %COMPFLAGS% /c ringbuffer.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ringbuffer.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalLD.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalLD.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalMemoryManager.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalMemoryManager.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalFunctionTable.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalFunctionTable.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalIO.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalIO.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalOS.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalOS.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalFS.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalFS.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalLog.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c ..\library\internal\InternalLog.cpp >> %1 2>>%2 & echo .
echo calling [%CP_NCPP% %COMPFLAGS% /c main.cpp] >> %1
%CP_NCPP% %COMPFLAGS% /c main.cpp >> %1 2>>%2 & echo .

echo calling [%CP_LINK% %LINKFLAGS% main.obj ringbuffer.obj InternalLog.obj InternalFunctionTable.obj InternalIO.obj InternalMemoryManager.obj InternalOS.obj InternalFS.obj InternalLD.obj /out:%BIN%\%TARGETNAM%.exe /PDB:%BIN%\%TARGETNAM%.pdb] >> %1
%CP_LINK% %LINKFLAGS% main.obj ringbuffer.obj InternalLog.obj InternalFunctionTable.obj InternalIO.obj InternalMemoryManager.obj InternalOS.obj InternalFS.obj InternalLD.obj /out:%BIN%\%TARGETNAM%.exe /PDB:%BIN%\%TARGETNAM%.pdb >> %1 2>>%2 & echo .

echo calling [del *.obj] >> %1
del *.obj >> %1 2>> %2 & echo .
echo calling [del *.pdb] >> %1
del *.pdb >> %1 2>> %2 & echo .

findstr /SIP error %1

if not exist "%BIN%\psuedomch.exe" echo ERROR: psuedomch.exe failed to build

endlocal
