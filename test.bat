@echo on

:: Created with vectorcast-execution plugin v0.80-SNAPSHOT (private-c9314578-vaprti)

set VCAST_PROJECT_NAME=Project_vcast_pipeline/working_dir/Project.vcm
set VCAST_PROJECT_BASENAME=Project
set PATH=%VECTORCAST_DIR%;d:/vector/tools/gnat/2021/bin;%VECTORCAST_DIR%/mingw/bin;%PATH%
call %WORKSPACE%/Project_vcast_pipeline/minimum_cleanup_and_build.bat
set VCAST_EXECUTE_PREAMBLE_WIN=
dir %WORKSPACE%

set VCAST_USE_STRICT_IMPORT=TRUE
set VCAST_USE_RGW3=FALSE
set VCAST_USE_LOCAL_IMPORTED_RESULTS=FALSE
set VCAST_USE_EXTERNAL_IMPORTED_RESULTS=TRUE
set VCAST_USE_EXTERNAL_FILENAME=Project_vc25sp4_exported_results.vcr
set VCAST_USE_IMPORTED_RESULTS=TRUE
set VCAST_USE_COVERAGE_PLUGIN=TRUE

set VCAST_WAIT_TIME=30
set VCAST_WAIT_LOOPS=1
set VCAST_OPTION_USE_REPORTING=TRUE
set VCAST_rptFmt=HTML
set VCAST_HTML_OR_TEXT=html
set VCAST_DONT_GENERATE_EXEC_RPT=
set VCAST_USE_CBT=--incremental


:: Baseline Single Job Windows Batch file
set VCAST_RPTS_PRETTY_PRINT_HTML=FALSE
set VCAST_NO_FILE_TRUNCATION=1
set VCAST_RPTS_SELF_CONTAINED=FALSE
    
:: Use strict testcase import 
if "%VCAST_USE_STRICT_IMPORT%"=="TRUE" (
   echo "%VCAST_USE_STRICT_IMPORT%"=="TRUE"
   %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
) 

:: Default Setup
%VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --full-status"
%VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --force --release-locks"
%VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --config VCAST_CUSTOM_REPORT_FORMAT=%VCAST_REPORT_FORMAT%"

:: Use Imported Results
if "%VCAST_USE_IMPORTED_RESULTS%"=="TRUE" (  
   echo "%VCAST_USE_IMPORTED_RESULTS%"=="TRUE"
   if "%VCAST_USE_LOCAL_IMPORTED_RESULTS%"=="TRUE" if exist "%VCAST_PROJECT_BASENAME%_results.vcr" (
        echo "%VCAST_USE_LOCAL_IMPORTED_RESULTS%"=="TRUE"
        dir "%VCAST_PROJECT_BASENAME%_results.vcr" 
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --import-result=""%VCAST_PROJECT_BASENAME%_results.vcr"""
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --full-status""
        if exist %VCAST_PROJECT_BASENAME%_results.vcr  ( copy %VCAST_PROJECT_BASENAME%_results.vcr %VCAST_PROJECT_BASENAME%_results_orig.vcr ) 
    ) 
    if "%VCAST_USE_EXTERNAL_IMPORTED_RESULTS%"=="TRUE" if exist "%VCAST_USE_EXTERNAL_FILENAME%" ( 
        echo "%VCAST_USE_EXTERNAL_IMPORTED_RESULTS%"=="TRUE"
        echio External File Name  "%VCAST_USE_EXTERNAL_FILENAME%"
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --import-result=""%VCAST_USE_EXTERNAL_FILENAME%"""
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --full-status"
    ) 
)

:: Clean up old files
del command.log > nul 2>&1
del *_rebuild.html > nul 2>&1
del coverage_diffs.html_tmp > nul 2>&1
del combined_incr_rebuild.tmp > nul 2>&1
del %VCAST_PROJECT_BASENAME%_full_report.html_tmp > nul 2>&1
del %VCAST_PROJECT_BASENAME%_metrics_report.html_tmp > nul 2>&1

echo calling %VCAST_EXECUTE_PREAMBLE_WIN% %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --build-execute %VCAST_USE_CBT% --output %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%"

%VCAST_EXECUTE_PREAMBLE_WIN% %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --build-execute %VCAST_USE_CBT% --output %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%"
copy command.log complete_build.log

if exist "%VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%" (
    copy %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT% %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%_tmp
    echo dir %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT% %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%_tmp
    dir %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT% %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%_tmp

    :: strip off the ToC, etc
    %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\fixup_reports.py" %VCAST_PROJECT_BASENAME%_rebuild.%VCAST_HTML_OR_TEXT%_tmp
)

if "%VCAST_OPTION_USE_REPORTING%" == "TRUE" (
    echo "%VCAST_OPTION_USE_REPORTING%"=="TRUE"
    %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
    %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\generate-results.py" --junit --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% %VCAST_PROJECT_NAME% %VCAST_DONT_GENERATE_EXEC_RPT% --buildlog complete_build.log
    if "%VCAST_USE_RGW3%"=="TRUE" (
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --clicast-args rgw export"
    ) 
    if "%VCAST_USE_COVERAGE_PLUGIN%"=="TRUE" ( 
        echo calling %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\cobertura.py" --extended %VCAST_PROJECT_NAME%
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\cobertura.py" --extended %VCAST_PROJECT_NAME%
    )
    %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\full_report_no_toc.py" "%VCAST_PROJECT_NAME%" 
    %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --create-report=aggregate --output=""%VCAST_PROJECT_BASENAME%_aggregate_report.html"""

    :: Use Imported Results
    if "%VCAST_USE_IMPORTED_RESULTS%"=="TRUE" if "%VCAST_USE_LOCAL_IMPORTED_RESULTS%"=="TRUE" ( 
        echo calling export and merge
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\managewait.py" --wait_time %VCAST_WAIT_TIME% --wait_loops %VCAST_WAIT_LOOPS% --command_line "--project %VCAST_PROJECT_NAME% --export-result=%VCAST_PROJECT_BASENAME%_results.vcr"
        %VECTORCAST_DIR%\vpython "%WORKSPACE%\vc_scripts\merge_vcr.py" --orig "%VCAST_PROJECT_BASENAME%_results_orig.vcr" --new %VCAST_PROJECT_BASENAME%_results.vcr
    )
)




