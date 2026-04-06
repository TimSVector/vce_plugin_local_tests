

set PATH=%VECTORCAST_DIR%;d:\vector\tools\gnat\2021\bin;%VECTORCAST_DIR%\mingw\bin;%PATH%
for %%I in ("%~dp0..") do set WORKSPACE=%%~fI

echo %WORKSPACE%

git reset --hard
git clean -fxd

pushd Project_vcast_pipeline\working_dir

echo Starting build of building process for Project.vcm

call ENV_MONITORED_ADA.bat

cd ENV_COVER_wd
call ENV_COVER.bat

cd ..\ENV_MONITORED_C_wd
call ENV_MONITORED_C.bat
cd ..

%VECTORCAST_DIR%\manage -p Project --status

cd ENV_COVER_wd

set /p FIRSTTOKEN=<%VECTORCAST_DIR%\DATA\tool_version.txt

if "%FIRSTTOKEN:~0,2%"=="18" (
    copy /Y system_tests.py ..\Project\python\system_tests.py
    goto SKIP_OTHER_COPIES
) 

if "%FIRSTTOKEN:~0,2%"=="19" (
    copy /Y system_tests_2019.py ..\Project\python\ENV_COVER_system_tests.py
    goto SKIP_OTHER_COPIES
) 

if "%FIRSTTOKEN:~0,2%"=="20" (
    copy /Y ENV_COVER_system_tests_2020sp1.py ..\Project\python\ENV_COVER_system_tests.py
    goto SKIP_OTHER_COPIES
)

copy /Y ENV_COVER_system_tests.py ..\Project\python\ENV_COVER_system_tests.py


:SKIP_OTHER_COPIES


popd


manage -p Project_vcast_pipeline\working_dir\Project --full-status

