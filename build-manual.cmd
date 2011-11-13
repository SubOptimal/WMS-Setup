@echo off

: clean
echo.
echo cleanup:
call :CLEAN_UP .\build
call :CLEAN_UP .\dist

: prepare
echo.
echo prepare:
call :MAKE_DIR .\build
call :MAKE_DIR .\dist

: compile
echo.
echo compile:
echo     [javac] compile sources from '.\src\' ...
set JAVAC_ARGS=-Xlint:deprecation
javac %JAVAC_ARGS% -d .\build .\src\sub\optimal\wms\*.java

: createExecutable
echo.
echo createExecutable:
echo Main-Class: sub.optimal.wms.MainFrame> manifest.mf
echo     [jar] build jar '.\dist\WMS-Setup.jar' ...
jar cfm .\dist\WMS-Setup.jar manifest.mf -C .\build . 
del manifest.mf
goto :EOF

:CLEAN_UP
if exist "%1" (
  echo     [rmdir] remove directory '%1' ...
  rmdir /S /Q "%1"
)
goto :EOF

:MAKE_DIR
echo     [mkdir] create directory '%1' ...
mkdir "%1"
goto :EOF
