#讀取servers.txt
$ServerList = Get-Content C:\Jobs\servers.txt

#使用Invoke-Command 要注意帳戶身分、Windows權限、防火牆、PS遠端權限
#遠端盤點伺服器上所存在的帳戶管理政策
Invoke-Command   -computername $ServerList  -ScriptBlock {net accounts | Out-File -FilePath "\\10.15.149.111\NetaccountsCheck.txt" }

