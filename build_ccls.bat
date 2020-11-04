@echo off

SET ccls_dir=%1
IF "%1"=="" (SET ccls_dir=build\ccls)

rem ninja %2 -C %ccls_dir%\Release
cmake --build %ccls_dir%\Release --config Release
