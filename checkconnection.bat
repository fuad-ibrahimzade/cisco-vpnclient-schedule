@echo off
SET noConnectionStringOutput="No"
:start
SET statCMD='"C:/Program Files (x86)/Cisco Systems/VPN Client/vpnclient.exe" stat'
for /f %%i in (%statCMD%) do set statCMDOutput=%%i
echo %statCMDOutput%

echo %statCMDOutput% | findstr /i /c:%noConnectionStringOutput%
if %errorlevel%==0 (
	echo No Connection Exist!
) else (
	echo Some Connection Exist!
	call "C:/Program Files (x86)/Cisco Systems/VPN Client/vpnclient.exe" stat
	timeout /t 5 /nobreak >nul 2>&1
	EXIT
)
echo %date% %time%
REM every 1 min redo
timeout /t 2 /nobreak >nul 2>&1
goto :start
REM pause