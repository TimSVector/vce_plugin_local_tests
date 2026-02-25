

set VECTORCAST_DIR=c:\vcast\%VCAST_DIRECTORY%
set PATH=%VECTORCAST_DIR%;d:\vector\tools\gnat\2021\bin;%VECTORCAST_DIR%\mingw\bin;%PATH%
set WORKSPACE=%~dp0..

git reset --hard
git clean -fxd

pushd Project_vcast_pipeline\working_dir

echo Starting build of building process for Project.vcm

call ENV_COVER.bat
call ENV_MONITORED_ADA.bat
call ENV_MONITORED_C.bat

manage -p Project_vcast_pipeline\working_dir\Project --status

if "%VCAST_DIRECTORY%"=="2020sp1" (
    copy /Y ENV_COVER_system_tests_2020sp1.py Project\python\ENV_COVER_system_tests.py

) else if "%VCAST_DIRECTORY%"=="2018sp5" (
    copy /Y system_tests.py Project\python\system_tests.py

) else if "%VCAST_DIRECTORY%"=="2019" (
    copy /Y system_tests_2019.py Project\python\ENV_COVER_system_tests.py

) else if "%VCAST_DIRECTORY%"=="2019sp6" (
    copy /Y system_tests_2019.py Project\python\ENV_COVER_system_tests.py

) else (
    copy /Y ENV_COVER_system_tests.py Project\python\ENV_COVER_system_tests.py
)

popd


manage -p Project_vcast_pipeline\working_dir\Project --full-status

