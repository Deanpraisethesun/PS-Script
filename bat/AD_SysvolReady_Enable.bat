:SR01

reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Netlogon\Parameters" /v "SysvolReady" /d "1" /t REG_DWORD /f

reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Netlogon\Parameters" /v "SysvolReady"

timeout 30
goto SR01
