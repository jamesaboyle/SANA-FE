@echo off
cd /d "%~dp0"
setlocal

REM VCVARS_PATH is passed in from the Linux side (translated to a Windows path).
REM Fallback to a sensible default if it's not set.
if "%VCVARS_PATH%"=="" (
  set "VCVARS_PATH=C:\Program Files\Microsoft Visual Studio\18\Community\VC\Auxiliary\Build\vcvars64.bat"
)

call "%VCVARS_PATH%"
if errorlevel 1 (
  echo Failed to load MSVC environment from "%VCVARS_PATH%"
  exit /b 1
)

cmake -S . -B build-msvc -G Ninja -DCMAKE_BUILD_TYPE=Release
if errorlevel 1 exit /b 1

cmake --build build-msvc --parallel 8
if errorlevel 1 exit /b 1

exit /b 0