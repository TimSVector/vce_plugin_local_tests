:: Cleanup

@echo on

set WORKSPACE=%CD%\working_dir
set path=%path%;d:\vector\tools\gnat\2021\bin;%VECTORCAST_DIR%\mingw\bin;
:: set WORKING_DIR=D:\vector\sandbox\jenkins\working_dir
set WORKING_DIR=%CD%\working_dir
set VCAST_VC_SCRIPTS=D:\vector\github\vectorcast-execution-plugin_079\src\main\resources\scripts

pushd %WORKING_DIR%

rmdir xml_data /S /Q
rmdir xml_data_orig /S /Q
rmdir xml_data_orig1 /S /Q
rmdir xml_data_orig2 /S /Q
rmdir execution /S /Q
rmdir management /S /Q
rmdir rebuild_reports /S /Q
del *.html
del *tmp
del *css
del *png
del *.log
del *.tar
del unit_test*.txt
del *.ali *.o

rmdir /s /q vc_scripts

:: Prepare for testing
if not exist vc_scripts (
    mkdir vc_scripts
    xcopy /E /S /Y /I /Q %VCAST_VC_SCRIPTS%\*.* %WORKSPACE%\vc_scripts 
)


::pushd %WORKING_DIR%

rmdir ENV_UNIT /S /Q
rmdir ENV_COVER /S /Q
rmdir ENV_MIGRATED_C /S /Q
rmdir ENV_MONITORED_ADA /S /Q
rmdir ENV_MIGRATED_COVER /S /Q

rmdir Project /S /Q
del *.vc*


del *.qik /S /Q

vpython %VECTORCAST_DIR%\python\vector\apps\AutomationController\UnInstrument.py

copy /Y source_a.orig source_a.c
copy /Y source_b.orig source_b.c

popd
