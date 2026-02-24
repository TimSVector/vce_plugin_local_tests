@echo off

setlocal EnableDelayedExpansion

if defined VCAST_SHARED_DIR (
  set "SHARED_DIR=!VCAST_SHARED_DIR:~12!"
  set "SHARED_DIR=!SHARED_DIR:/=\%!"
  echo cleaning !SHARED_DIR!
  rmdir /S /Q !SHARED_DIR! > nul 2>&1
  mkdir !SHARED_DIR!
)
endlocal