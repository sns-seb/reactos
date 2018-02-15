
curl -O http://www.7-zip.org/a/7z1801-x64.exe
if %errorlevel% neq 0 exit /b %errorlevel%

7z1801-x64.exe /S /D=%CD%\7zip
dir
if %errorlevel% neq 0 exit /b %errorlevel%
dir 7zip
set PATH=%CD%\7zip;%PATH%
7z

curl -O https://svn.reactos.org/amine/RosCMakeNinja.zip
if %errorlevel% neq 0 exit /b %errorlevel%

7z x RosCMakeNinja.zip -oRosCMakeNinja
if %errorlevel% neq 0 exit /b %errorlevel%

set PATH=%CD%\RosCMakeNinja\bin;%PATH%

git apply --whitespace=fix cfamily-build.patch
if %errorlevel% neq 0 exit /b %errorlevel%

REM call "C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"
REM x86 call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools\VsDevCmd.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
cmake --version
ninja --version

rmdir /Q /S rosbuild
mkdir rosbuild
cd rosbuild

call ..\configure.cmd -DENABLE_ROSTESTS=1
if %errorlevel% neq 0 exit /b %errorlevel%

..\build-wrapper-win-x86\build-wrapper-win-x86-64.exe --out-dir ..\cfamily-compilation-database ninja
if %errorlevel% neq 0 exit /b %errorlevel%

dir ..\cfamily-compilation-database
