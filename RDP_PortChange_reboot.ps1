#變更RDP Port避免被掃描或是滲透測試

#設定key值，並將對應的rule 加入firewall
$NewPortNum = 13579
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "PortNumber" -Value $NewPortNum
New-NetFirewallRule -DisplayName 'RDP_PORT_TCPIn' -Profile any -Direction Inbound -Action Allow -Protocol TCP -LocalPort $NewPortNum
New-NetFirewallRule -DisplayName 'RDP_PORT_UDPIn' -Profile any -Direction Inbound -Action Allow -Protocol UDP -LocalPort $NewPortNum

#重啟套用變更
Restart-Computer -Force


