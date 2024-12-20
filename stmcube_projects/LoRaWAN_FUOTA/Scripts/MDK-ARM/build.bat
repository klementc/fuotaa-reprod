@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
cls

set "current_dir=%~dp0"

echo ###########################################
echo # 0- Set all global variables
echo ###########################################
call %current_dir%..\setenv.bat
set compile_all_projects=1

if not exist !MDK_EXE! (
  echo Error: the command line !MDK_EXE! doesn't exist.
  echo        Check the setenv.bat content and your installation path
  exit /B 1
)

REM Get Arguments
:continue
if not "%1"=="" (
  if "%1"=="-app" (
    set compile_all_projects=0
  )
  if [%1]==[/?] goto help
  shift
  goto continue
)

if %compile_all_projects% equ 1 (
  echo ###########################################
  echo # 1- Compile all BFU projects
  echo ###########################################
  echo Build 1_Image_KMS_Blob
  call :compile_func %current_dir%..\..\1_Image_KMS_Blob\MDK-ARM\Project.uvprojx || goto :eof
  echo Build 1_Image_SECoreBin
  call :compile_func %current_dir%..\..\1_Image_SECoreBin\MDK-ARM\Project.uvprojx || goto :eof
  echo Build 1_Image_BFU
  call :compile_func %current_dir%..\..\1_Image_BFU\MDK-ARM\Project.uvprojx || goto :eof
)

echo ###########################################
echo # 2- Compile Application projects
echo ###########################################
echo Build LoRaWAN_End_Node
call :compile_func %current_dir%..\..\LoRaWAN_End_Node\MDK-ARM\LoRaWAN_End_Node.uvprojx || goto :eof

exit /B 0

:--------------------------------------
:compile_func
  %MDK_EXE% -r "%~1" -o "%~dp0\temp.log" -j0
  REM return 0 if OK, 1 if warning, 2 if error
  if %errorlevel% equ 2 (
    type "%~dp0\temp.log"
    del "%~dp0\temp.log"
    echo Error: Compilation of %~1 Failed. Abort of compile batch ...
    exit /B 1
  )
  type "%~dp0\temp.log"
  del "%~dp0\temp.log"
  exit /B 0

:help
  echo ###########################################
  echo # HELP
  echo ###########################################
  echo Usage: %0 [-app ^| /?]
  echo.
  echo -app        Compile only Application projects (exclude SBSFU projects)
  echo ?           Print Help
  goto eof
