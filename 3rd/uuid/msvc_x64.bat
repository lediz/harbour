set WINSDK_VER=10.0.18362.0
set LIBRARY=uuid
set LIB_SOURCE_DIR=uuid-1.6.2-win32-patched

IF NOT DEFINED UUID_BUILD set INCLUDE=
IF NOT DEFINED UUID_BUILD set LIBPATH=
IF NOT DEFINED UUID_BUILD set PATH=c:\windows;c:\windows\system32

REM amd64 ili x86
IF NOT DEFINED UUID_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

IF NOT DEFINED UUID_BUILD SET PATH=%PATH%;C:\Strawberry\c\bin
IF NOT DEFINED UUID_BUILD SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED UUID_BUILD SET PATH=%PATH%;C:\Strawberry\perl\site\bin
IF NOT DEFINED UUID_BUILD SET PATH=%PATH%;C:\users\%USERNAME%\NASM64

IF NOT DEFINED UUID_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED UUID_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED UUID_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64
set UUID_BUILD=1

set ROOT_DIR=\users\%USERNAME%\harbour
set LIB_TARGET=%ROOT_DIR%\3rd\x64\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\x64\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

nmake -f Makefile.win32

mkdir %ROOT_DIR%\3rd\x64
mkdir %LIB_TARGET%
mkdir %LIB_TARGET%\include
mkdir %LIB_TARGET%\lib

copy *.h %LIB_TARGET%\include
copy Release\*.lib %LIB_TARGET%\lib

cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
