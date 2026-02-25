@echo on

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_sfp

set orig_path=%PATH%

call Project_vcast_pipeline\cleanup.bat

pushd %WORKING_DIR%

manage -p Project_cbt_spf --create
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE --group C --create
manage -p Project_cbt_spf --level GNU_CPP_49/CPP_SUITE --group CPP --create
clicast -lc TEMplate GNU_C_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -lc environment build ENV_MONITORED_C.env
clicast -lc -e ENV_MONITORED_C TOols Script Run ENV_MONITORED_C.tst
manage -p Project_cbt_spf --import ENV_MONITORED_C.vce -lc
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE --group C --add ENV_MONITORED_C
manage -p Project_cbt_spf --group ALL --list

call ENV_COVER.bat

manage -p Project_cbt_spf --import ENV_COVER.vcp
manage -p Project_cbt_spf --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --add ENV_COVER
manage -p Project_cbt_spf --config=VCAST_COVERAGE_FOR_HEADERS=TRUE
manage -p Project_cbt_spf --config=VCAST_COVERAGE_SOURCE_FILE_PERSPECTIVE=TRUE

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



REM :: Pipeline testing

REM vpython vc_scripts/archive_extract_reports.py --archive
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --status"
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --force --release-locks"
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
REM vpython vc_scripts/getjobs.py %WORKING_DIR%\Project_cbt_spf.vcm --type
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --build-execute --incremental --output GNU_CPP_49_CPP_SUITE_ENV_COVER_rebuild.html" > unstashed_build.log
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_C_49/C_SUITE -e ENV_MONITORED_C --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_MONITORED_C_rebuild.html" >> unstashed_build.log
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_C_49/C_SUITE -e ENV_MIGRATED_C --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_MIGRATED_C_rebuild.html" >> unstashed_build.log
REM vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project_cbt_spf.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
REM vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project_cbt_spf.vcm --jobs max
REM vpython vc_scripts/incremental_build_report_aggregator.py Project_cbt_spf --rptfmt HTML
REM vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project_cbt_spf.vcm"
REM vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"

REM mkdir xml_data_orig

REM copy xml_data\* xml_data_orig

REM vpython vc_scripts/vcast_exec.py %WORKING_DIR%\Project_cbt_spf.vcm --cobertura_extended --lcov --sonarqube

REM set path=%orig_path%

REM echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_sfp
REM popd