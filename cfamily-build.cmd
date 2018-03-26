
curl -L -O https://cmake.org/files/v3.9/cmake-3.9.1-win32-x86.zip
unzip -o cmake-3.9.1-win32-x86.zip
set PATH=%PATH%;%CD%\cmake-3.9.1-win32-x86\bin

git apply --whitespace=fix cfamily-build.patch
if %errorlevel% neq 0 exit /b %errorlevel%

REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
REM x86 call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvars64.bat"

rmdir /Q /S output-VS-i386
rmdir /Q /S output-VS-amd64

call configure.cmd VSSolution
if %errorlevel% neq 0 exit /b %errorlevel%

cd output-VS-amd64

REM disable msbuild node reuse
set MSBUILDDISABLENODEREUSE=1
..\build-wrapper-win-x86\build-wrapper-win-x86-64.exe --out-dir ..\cfamily-compilation-database %MSBUILD15_PATH% /t:rebuild reactos.sln

dir ..\cfamily-compilation-database
