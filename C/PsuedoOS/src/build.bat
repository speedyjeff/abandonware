echo off

echo %DATE% %TIME% > build.log
echo %DATE% %TIME% > build.err

echo calling [del %BIN%\kernel] >> build.log
del %BIN%\kernel >> build.log 2>> build.err
echo calling [del %BIN%\kernel.exe] >> build.log
del %BIN%\kernel.exe >> build.log 2>> build.err
echo calling [del %BIN%\psuedomch.*] >> build.log
del %BIN%\psuedomch.* >> build.log 2>> build.err

pushd PsuedoMch
call build.bat ..\build.log ..\build.err
popd

pushd kernel
call build.bat ..\build.log ..\build.err
popd

if not exist "%BIN%\psuedomch.exe" echo ERROR: psuedomch.exe failed to build
