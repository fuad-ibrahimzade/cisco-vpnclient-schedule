@echo off
REM before kill all other batchs cmds
call getCmdPID
set "current_pid=%errorlevel%"

for /f "skip=3 tokens=2 delims= " %%a in ('tasklist /fi "imagename eq cmd.exe"') do (
    if "%%a" neq "%current_pid%" (
        TASKKILL /PID %%a /f >nul 2>nul
    )
)
echo "other cmds killed"
SET noConnectionString="No connection exists."
SET noConnectionStringOutput="No"
SET vpnCMD="vpnconnect"
call %vpnCMD% 
:start
SET statCMD='"C:/Program Files (x86)/Cisco Systems/VPN Client/vpnclient.exe" stat'
for /f %%i in (%statCMD%) do set statCMDOutput=%%i
echo %statCMDOutput%

echo %statCMDOutput% | findstr /i /c:%noConnectionStringOutput%
if %errorlevel%==0 (
	echo No Connection Exist!
	call %vpnCMD%
) else (
	echo Some Connection Exist!
)
echo %date% %time%
REM every 1 min redo
timeout /t 60 /nobreak >nul 2>&1
goto :start
pause