
echo off

echo %DATE% %TIME% > build.log
echo %DATE% %TIME% > build.err

echo calling [del %BIN%\shell*] >> build.log
del %BIN%\shell* >> build.log 2>> build.err

pushd Library\shell
call build.bat ..\..\build.log ..\..\build.err
popd
