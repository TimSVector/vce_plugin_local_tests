del commands.tmp
echo options COMPILATION_SYSTEM GNAT >> commands.tmp
echo options C_COMPILER_CFG_SOURCE CONFIG_FILE_63 >> commands.tmp
echo options TARGET_VARIANT HOST >> commands.tmp
echo options VCAST_DISPLAY_UNINST_EXPR FALSE >> commands.tmp
echo options VCAST_ENABLE_FUNCTION_CALL_COVERAGE FALSE >> commands.tmp
echo environment build ENV_MONITORED_ADA.env >> commands.tmp
echo /E:ENV_MONITORED_ADA tools script run ENV_MONITORED_ADA.tst >> commands.tmp
echo /E:ENV_MONITORED_ADA execute batch >> commands.tmp
echo /E:ENV_MONITORED_ADA reports custom management ENV_MONITORED_ADA_management_report.html >> commands.tmp
"%VECTORCAST_DIR%\CLICAST"  /X:HOST /L:ADA tools execute commands.tmp false
