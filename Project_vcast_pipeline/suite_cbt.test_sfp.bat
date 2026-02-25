@echo on

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_sfp

set orig_path=%PATH%

call cleanup.bat

pushd %WORKING_DIR%

manage -p Project_cbt_spf --create
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE --create
manage -p Project_cbt_spf --level GNU_CPP_49/CPP_SUITE --create
clicast -lc TEMplate GNU_C_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -lc environment build ENV_MIGRATED_C.env
clicast -lc -e ENV_MIGRATED_C TOols Script Run ENV_MIGRATED_C.tst
manage -p Project_cbt_spf --import ENV_MIGRATED_C.vce -lc
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE --add ENV_MIGRATED_C
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE -e ENV_MIGRATED_C --migrate
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE/ENV_MIGRATED_C --build --workspace=%WORKING_DIR%\Project_cbt_spf\build
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE/ENV_MIGRATED_C --apply-changes --force --verbose
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE -e ENV_MIGRATED_C --clean
clicast -lc TEMplate GNU_C_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -lc environment build ENV_MONITORED_C.env
clicast -lc -e ENV_MONITORED_C TOols Script Run ENV_MONITORED_C.tst
manage -p Project_cbt_spf --import ENV_MONITORED_C.vce -lc
manage -p Project_cbt_spf --level GNU_C_49/C_SUITE --add ENV_MONITORED_C
manage -p Project_cbt_spf --group ALL --list
clicast Cover Environment Create ENV_COVER
clicast TEMplate GNU_CPP_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -e ENV_COVER Cover Base_dir Add ROOT %WORKING_DIR%
clicast -e ENV_COVER Cover Base_dir ALlowlist ROOT source_a.c
clicast -e ENV_COVER Cover Base_dir ALlowlist ROOT source_b.c
clicast -e ENV_COVER Cover Base_dir update
clicast -e ENV_COVER Cover Instrument STATEMENT
manage -p Project_cbt_spf --import ENV_COVER.vcp
manage -p Project_cbt_spf --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --add ENV_COVER
manage -p Project_cbt_spf --config=VCAST_COVERAGE_FOR_HEADERS=TRUE
manage -p Project_cbt_spf --config=VCAST_COVERAGE_SOURCE_FILE_PERSPECTIVE=TRUE
copy /Y ENV_COVER_system_tests.py %WORKING_DIR%\Project_cbt_spf\python\ENV_COVER_system_tests.py 

:: Pipeline testing

vpython vc_scripts/archive_extract_reports.py --archive
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --status"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --force --release-locks"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
vpython vc_scripts/getjobs.py %WORKING_DIR%\Project_cbt_spf.vcm --type
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --build-execute --incremental --output GNU_CPP_49_CPP_SUITE_ENV_COVER_rebuild.html" > unstashed_build.log
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_C_49/C_SUITE -e ENV_MONITORED_C --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_MONITORED_C_rebuild.html" >> unstashed_build.log
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"  --level GNU_C_49/C_SUITE -e ENV_MIGRATED_C --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_MIGRATED_C_rebuild.html" >> unstashed_build.log
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project_cbt_spf.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project_cbt_spf.vcm --jobs max
vpython vc_scripts/incremental_build_report_aggregator.py Project_cbt_spf --rptfmt HTML
vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project_cbt_spf.vcm"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project_cbt_spf.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"

mkdir xml_data_orig

copy xml_data\* xml_data_orig

vpython vc_scripts/vcast_exec.py %WORKING_DIR%\Project_cbt_spf.vcm --cobertura_extended --lcov --sonarqube

set path=%orig_path%

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_sfp
popd