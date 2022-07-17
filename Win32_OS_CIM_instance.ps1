#查Win32_OS CIM instance
Get-CimInstance -ClassName win32_operatingsystem -ComputerName qhtjyfs02,qhtjyfs03|`
Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion |`

#匯出
Export-Csv C:\temp\CIM_instance_info.txt -NoTypeInformation -Encoding UTF8 -Verbose
