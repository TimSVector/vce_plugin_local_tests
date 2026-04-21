@echo off
del commands.tmp
echo options COMPILATION_SYSTEM GNAT >> commands.tmp
echo options TARGET_VARIANT HOST >> commands.tmp
echo environment build ENV_MONITORED_ADA.env >> commands.tmp
echo /E:ENV_MONITORED_ADA tools script run ENV_MONITORED_ADA.tst >> commands.tmp
echo /E:ENV_MONITORED_ADA execute batch >> commands.tmp
echo /E:ENV_MONITORED_ADA reports custom management ENV_MONITORED_ADA_management_report.html >> commands.tmp
setlocal
set PATH=%PATH%;%VECTORCAST_DIR%
WHERE clicast
IF %ERRORLEVEL% NEQ 0 ECHO Error: clicast was not found on System PATH. Add the VectorCAST installation directory to System PATH or set the environment variable VECTORCAST_DIR to the VectorCAST installation directory. && exit /b 1
"%VECTORCAST_DIR%\CLICAST"  /X:HOST /L:ADA tools execute commands.tmp true
IF %ERRORLEVEL% NEQ 0 exit /b %ERRORLEVEL%
endlocal
