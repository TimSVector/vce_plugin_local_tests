

echo. >> %~dp0working_dir\unit.c
echo void cbt_change(void) {} >> %~dp0working_dir\unit.c


echo -- Test Case: cbt_change.001 >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
echo TEST.UNIT:unit               >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
echo TEST.SUBPROGRAM:cbt_change   >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
echo TEST.NEW                     >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
echo TEST.NAME:cbt_change.001     >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
echo TEST.END                     >> %~dp0working_dir\Project\environment\ENV_MIGRATED_C\ENV_MIGRATED_C.tst
