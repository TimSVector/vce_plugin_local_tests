

set orig_path=%PATH%
set orig_vcd=%VECTORCAST_DIR%

set VECTORCAST_DIR=c:\vcast\2019
set path=%VECTORCAST_DIR%;%path%

call cleanup.bat

pushd %WORKING_DIR%


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
manage -p Project --level GNU_C_49/C_SUITE/ENV_MIGRATED_C --build
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

copy /Y system_tests_2019.py %WORKING_DIR%\Project\python\ENV_COVER_system_tests.py

manage -p Project --clean
manage -p Project --full-status

:: Pipeline testing
vpython vc_scripts/archive_extract_reports.py --archive
vpython vc_scripts/getjobs.py %WORKING_DIR%\Project.vcm --type
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config=VCAST_STRICT_TEST_CASE_IMPORT=TRUE"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --status"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --force --release-locks"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_CPP_49/CPP_SUITE -e ENV_COVER --build-execute --incremental --output GNU_CPP_49_CPP_SUITE_ENV_COVER_rebuild.html" > unstashed_build.log
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNAT/ADA_SUITE -e ENV_MONITORED_ADA --build-execute --incremental --output GNAT_ADA_SUITE_ENV_MONITORED_ADA_rebuild.html" >> unstashed_build.log
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"  --level GNU_C_49/C_SUITE -e ENV_MIGRATED_C --build-execute --incremental --output GNU_C_49_C_SUITE_ENV_MIGRATED_C_rebuild.html" >> unstashed_build.log
vpython vc_scripts/generate-results.py  %WORKING_DIR%\Project.vcm --wait_time 30 --wait_loops 1 --junit --buildlog unstashed_build.log 
vpython vc_scripts/parallel_full_reports.py  %WORKING_DIR%\Project.vcm --jobs max
vpython vc_scripts/incremental_build_report_aggregator.py Project --rptfmt HTML
vpython vc_scripts/full_report_no_toc.py "%WORKING_DIR%\Project.vcm"
vpython vc_scripts/managewait.py --wait_time 30 --wait_loops 1 --command_line "--project "%WORKING_DIR%\Project.vcm"   --create-report=aggregate   --output=Project_aggregate_report.html"
vpython vc_scripts/copy_build_dir.py %WORKING_DIR%\Project.vcm --level GNU_C_49/C_SUITE --basename Project_vcast_pipeline_GNU_C_49_C_SUITE_ENV_MIGRATED_C --environment ENV_MIGRATED_C

dir management\*.html

mkdir xml_data_orig

copy xml_data\* xml_data_orig

copy /Y source_a.orig source_a.c
copy /Y source_b.orig source_b.c

vpython vc_scripts/vcast_exec.py %WORKING_DIR%\Project.vcm --cobertura_extended --lcov --sonarqube

popd
set path=%orig_path%
set VECTORCAST_DIR=%orig_vcd%

echo --level campaign_jenkins_plugin/test_pipeline_jobs/suite_cbt_legacy/test_cbt_2019
