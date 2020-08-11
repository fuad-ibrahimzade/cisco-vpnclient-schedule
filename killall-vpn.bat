set "vbs1=hidden-schedule.vbs"
for /f "usebackq tokens=3" %%s in (
    `WMIC process where "name='wscript.exe'" get commandline^,processid ^| findstr /i /c:"%%vbs1%%"`
) do (
    taskkill /f /fi "pid eq %%s"
)

call getCmdPID
set "current_pid=%errorlevel%"

for /f "skip=3 tokens=2 delims= " %%a in ('tasklist /fi "imagename eq cmd.exe"') do (
    if "%%a" neq "%current_pid%" (
        TASKKILL /PID %%a /f >nul 2>nul
    )
)
call "C:/Program Files (x86)/Cisco Systems/VPN Client/vpnclient.exe" disconnect