
echo off

echo %DATE% %TIME% > build.log
echo %DATE% %TIME% > build.err

echo calling [del %BIN%\ExeLdr.*] >> build.log
del %BIN%\ExeLdr.* >> build.log 2>> build.err
echo calling [del %BIN%\FSControl.*] >> build.log
del %BIN%\FSControl.* >> build.log 2>> build.err

echo calling [pushd tools\win32\ExeLdr] >> build.log
pushd tools\win32\ExeLdr
call build.bat ..\..\..\build.log ..\..\..\build.err
popd

echo calling [pushd tools\win32\FSControl] >> build.log
pushd tools\win32\FSControl
call build.bat ..\..\..\build.log ..\..\..\build.err
popd

echo calling [pushd tools\win32\MemSim] >> build.log
pushd tools\win32\MemSim
call build.bat ..\..\..\build.log ..\..\..\build.err
popd

REM Verify output
if not exist "%BIN%\exeldr.exe" echo ERROR: exeldr.exe failed to build
if not exist "%BIN%\fscontrol.exe" echo ERROR: fscontrol.exe failed to build
if not exist "%BIN%\memsim.exe" echo ERROR: memsim.exe failed to build
