$Servers = get-content C:\jobs\ServerList.txt

Get-Service -Name Spooler -ComputerName $servers | Set-Service -Status Stopped
