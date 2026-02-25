:: Cleanup

@echo on

set WORKSPACE=%CD%
set path=%path%;d:\vector\tools\gnat\2021\bin;%VECTORCAST_DIR%\mingw\bin;
:: set WORKING_DIR=D:\vector\sandbox\jenkins\working_dir
set WORKING_DIR=%~dp0working_dir
set VCAST_VC_SCRIPTS=D:\vector\github\vectorcast-execution-plugin_080\src\main\resources\scripts

git reset --hard
git clean -fxd

:: Prepare for testing
if not exist vc_scripts (
    mkdir vc_scripts
    xcopy /E /S /Y /I /Q %VCAST_VC_SCRIPTS%\*.* %WORKSPACE%\vc_scripts 
)
