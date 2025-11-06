
@echo on

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt/test_sfp

set orig_path=%PATH%

call cleanup.bat

pushd %WORKING_DIR%

manage -p Project --create
manage -p Project --level GNU_C_49/C_SUITE --create
manage -p Project --level GNU_CPP_49/CPP_SUITE --create


clicast Cover Environment Create ENV_COVER
clicast TEMplate GNU_CPP_49
clicast option VCAST_NO_LONG_DOUBLE TRUE
clicast -e ENV_COVER Cover Base_dir Add ROOT %WORKING_DIR%
clicast -e ENV_COVER Cover Base_dir ALlowlist ROOT source_a.c
clicast -e ENV_COVER Cover Base_dir ALlowlist ROOT source_b.c
clicast -e ENV_COVER Cover Base_dir update
clicast -e ENV_COVER Cover Instrument STATEMENT
manage -p Project --import ENV_COVER.vcp
manage -p Project --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --add ENV_COVER
manage -p Project --config=VCAST_COVERAGE_FOR_HEADERS=TRUE
manage -p Project --config=VCAST_COVERAGE_SOURCE_FILE_PERSPECTIVE=TRUE
manage -p Project --apply-instrumentation=BUILD
manage -p Project --migrate
copy /Y ENV_COVER_system_tests.py %WORKING_DIR%\Project\python\ENV_COVER_system_tests.py 

vpython vc_scripts/archive_extract_reports.py --archive
vpython vc_scripts/getjobs.py %WORKING_DIR%\Project.vcm --type
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --status"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --force --release-locks"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --build-execute --incremental --output GNU_CPP_49_CPP_SUITE_ENV_COVER_rebuild.html" > unstashed_build.log
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project.vcm --jobs max
vpython vc_scripts/incremental_build_report_aggregator.py Project --rptfmt HTML
vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project.vcm"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"

mkdir xml_data_orig1
copy xml_data\* xml_data_orig1

vpython vc_scripts/archive_extract_reports.py --archive
vpython vc_scripts/getjobs.py %WORKING_DIR%\Project.vcm --type
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --status"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --force --release-locks"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --build-execute --incremental --output GNU_CPP_49_CPP_SUITE_ENV_COVER_rebuild.html"
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project.vcm --jobs max
vpython vc_scripts/incremental_build_report_aggregator.py Project --rptfmt HTML
vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project.vcm"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"

mkdir xml_data_orig2
copy xml_data\* xml_data_orig2

copy /Y source_a.orig source_a.c
copy /Y source_b.orig source_b.c

vpython vc_scripts/vcast_exec.py %WORKING_DIR%\Project.vcm --cobertura_extended --lcov --sonarqube

start bcompare xml_data_orig1 xml_data_orig2
set path=%orig_path%

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_scm/test_scm
popd
