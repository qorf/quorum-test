@echo off
rem Runs the compiled Quorum tests outside Quorum Studio. Build QuorumTest in
rem Quorum Studio first, so Run\Default.jar exists. Any flags are passed on.
rem It uses the JDK the tests download into Tools\ (the release in Tools.json)
rem if it is there, and java from the PATH before the first run.

rem run from the QuorumTest folder, wherever this file is called from
cd /d "%~dp0"

if not exist "Run\Default.jar" (
    echo Run\Default.jar is missing. Build QuorumTest in Quorum Studio first.
    exit /b 1
)

set "JAVA=java"
for /d %%f in (Tools\jdk-*) do if exist "%%f\bin\java.exe" set "JAVA=%%f\bin\java.exe"

"%JAVA%" -jar Run\Default.jar %*
