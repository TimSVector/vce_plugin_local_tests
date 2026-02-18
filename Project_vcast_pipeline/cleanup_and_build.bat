

set VECTORCAST_DIR=c:\vcast\%VCAST_DIRECTORY%
set PATH=%VECTORCAST_DIR%;d:\vector\tools\gnat\2021\bin;%VECTORCAST_DIR%\mingw\bin;%PATH%

git reset --hard
git clean -fxd

pushd Project_vcast_pipeline\working_dir

del foo.cpp /Q
echo Starting build of building process for Project.vcm

manage -p Project --create
manage -p Project --level GNU_C_49/C_SUITE --group C --create
manage -p Project --level GNAT/ADA_SUITE --group ADA --create
manage -p Project --level GNU_CPP_49/CPP_SUITE --group CPP --create
clicast -lc TEMplate GNU_C_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -lc environment build ENV_MIGRATED_C.env
clicast -lc -e ENV_MIGRATED_C TOols Script Run ENV_MIGRATED_C.tst
manage -p Project --import ENV_MIGRATED_C.vce -lc
manage -p Project --group C --add ENV_MIGRATED_C
manage -p Project --level GNU_C_49/C_SUITE --group C -e ENV_MIGRATED_C --migrate
manage -p Project --level GNU_C_49/C_SUITE/ENV_MIGRATED_C --build --workspace=Project\build
manage -p Project --level GNU_C_49/C_SUITE/ENV_MIGRATED_C --apply-changes --force --verbose
manage -p Project --level GNU_C_49/C_SUITE --group C -e ENV_MIGRATED_C --clean
gcc -c unit.adb
clicast -lada options COMPILATION_SYSTEM GNAT
clicast -lada environment build ENV_MONITORED_ADA.env
clicast -lada -e ENV_MONITORED_ADA TOols Script Run ENV_MONITORED_ADA.tst
manage -p Project --import ENV_MONITORED_ADA.vce -lada
manage -p Project --group ADA --add ENV_MONITORED_ADA
manage -p Project --group ALL --list
clicast Cover Environment Create ENV_COVER
clicast TEMplate GNU_CPP_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -e ENV_COVER Cover Source Add source_a.c
clicast -e ENV_COVER Cover Source Add source_b.c
clicast -e ENV_COVER Cover Instrument STATEMENT
manage -p Project --import ENV_COVER.vcp
manage -p Project --group CPP --add ENV_COVER
manage -p Project --environment ENV_COVER --apply-instrumentation=BUILD

manage -p Project --status
manage -p Project --config=VCAST_COVERAGE_SOURCE_FILE_PERSPECTIVE=FALSE

if "%VCAST_DIRECTORY%"=="2020sp1" (
    copy /Y ENV_COVER_system_tests_2020sp1.py Project\python\ENV_COVER_system_tests.py

) else if "%VCAST_DIRECTORY%"=="2018sp2" (
    copy /Y system_tests.py Project\python\system_tests.py

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

if not defined JENKINS_URL (
  xcopy /E /S /Y /I /Q %VCAST_VC_SCRIPTS%\*.* %WORKSPACE%\vc_scripts
)


manage -p Project_vcast_pipeline\working_dir\Project --full-status

