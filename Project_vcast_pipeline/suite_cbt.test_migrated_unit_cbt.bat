echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_migrated_unit_cbt

call cleanup.bat

pushd %WORKING_DIR%

manage.exe -p Project --create
manage.exe -p Project --level GNU_C_49/C_SUITE --create
manage.exe -p Project --group ALL --list
clicast.exe -lc TEMplate GNU_CPP11_X
clicast options TESTABLE_SOURCE_DIR %WORKING_DIR%
clicast.exe -lc environment build ENV_UNIT.env
clicast.exe -lc -e ENV_UNIT TOols Script Run ENV_UNIT.tst
manage.exe -p Project --import ENV_UNIT.bat ENV_UNIT.tst ENV_UNIT.env -lc
manage.exe -p Project --level GNU_C_49/C_SUITE -e ENV_UNIT --add ENV_UNIT
manage.exe -p Project --level GNU_C_49/C_SUITE -e ENV_UNIT --migrate
manage.exe -p Project --level GNU_C_49/C_SUITE/ENV_UNIT --build --workspace=%WORKING_DIR%\Project\build
manage.exe -p Project --level GNU_C_49/C_SUITE/ENV_UNIT --apply-changes --force --verbose
manage.exe -p Project --level GNU_C_49/C_SUITE -e ENV_UNIT --clean


:: Pipeline testing

vpython vc_scripts/archive_extract_reports.py --archive
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --status"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --force --release-locks"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
vpython vc_scripts/getjobs.py %WORKING_DIR%\Project.vcm --type
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_C_49/C_SUITE -e ENV_UNIT --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_UNIT_rebuild.html" > unstashed_build.log
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project.vcm --jobs max
vpython vc_scripts/incremental_build_report_aggregator.py Project --rptfmt HTML
vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project.vcm"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"

mkdir xml_data_orig
copy xml_data\* xml_data_orig

vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_C_49/C_SUITE -e ENV_UNIT --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_UNIT_rebuild.html" > unstashed_build.log
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project.vcm --jobs max

mkdir xml_data_orig2
copy xml_data\* xml_data_orig2

vpython vc_scripts/vcast_exec.py %WORKING_DIR%\Project.vcm --cobertura_extended --lcov --sonarqube

set path=%orig_path%

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_migrated_unit_cbt

start bcompare xml_data_orig2 xml_data_orig

popd
