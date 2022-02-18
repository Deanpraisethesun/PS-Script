# EXG檢查

   

### 啟動EXG2016 PS模組

. "C:\Program Files\Microsoft\Exchange Server\V15\bin\RemoteExchange.ps1"

Connect-ExchangeServer -auto

### Get Database Size

Get-TransportService EXG* | Get-MailboxDatabase -Status | Select Name,@{Name='DatabaseSize (GB)';Expression={$_.DatabaseSize.ToGb()}} |out-file -filepath C:\JOBS\GetDBSize_Service\DBsize.txt -encoding UTF8

### ExgServer Health

Get-ExchangeServer EXG* | Test-ServiceHealth | Select Role,RequiredServicesRunning |Sort-Object -Descending RequiredServicesRunning | out-file -filepath C:\JOBS\GetDBSize_Service\EXGhealth.txt -encoding UTF8

### Replication Health

Get-TransportService QHT* | Test-ReplicationHealth | out-file -filepath C:\JOBS\GetDBSize_Service\DAGReplication.txt -encoding UTF8

### Node1 Disk Freespace

Get-CimInstance -ComputerName EXG01 -Class Win32_logicaldisk -Filter "DriveType = '3'" | Select-Object -Property DeviceID, @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}} | out-file -filepath C:\JOBS\GetDBSize_Service\node1Disk.txt -encoding UTF8

### Node2 Disk Freespace

Get-CimInstance -ComputerName EXG02 -Class Win32_logicaldisk -Filter "DriveType = '3'" | Select-Object -Property DeviceID, @{L='FreeSpaceGB';E={"{0:N2}" -f ($_.FreeSpace /1GB)}} | out-file -filepath C:\JOBS\GetDBSize_Service\node2Disk.txt -encoding UTF8

#$a=Get-ExchangeServer EXG* | Test-ServiceHealth | ft name, Role, RequiredServicesRunning -auto

### powershell暫停

Start-Sleep –s 30

$ExgHealth = Get-ExchangeServer EXG* | Test-ReplicationHealth |Out-String

 ### Smtp setup

$smtp = "smtp.gmail.com"

$from = (hostname) + "_EXGCheck@gmail.com"

$to = "Dean_zhong@gmail.com"

$CC = "Dean_zhong2@gmail.com"

$date = Get-Date -Format yyyMMdd_HH:mm

$subject = "EXGCheck $date "

$encoding = [System.Text.Encoding]::UTF8

 ### 附件陣列

 $atcm1="C:\JOBS\GetDBSize_Service\DBsize.txt"

 $atcm2="C:\JOBS\GetDBSize_Service\EXGhealth.txt"

 $atcm3="C:\JOBS\GetDBSize_Service\DAGReplication.txt"

 $atcm4="C:\JOBS\GetDBSize_Service\node1Disk.txt"

 $atcm5="C:\JOBS\GetDBSize_Service\node2Disk.txt"

 $atcm_all = $atcm1, $atcm2, $atcm3, $atcm4, $atcm5

#### Send Email

 send-MailMessage -SmtpServer $smtp -From $from -To $to -Cc $cc -Subject $subject -Attachments $atcm_all -Encoding $encoding -Body $ExgHealth
 
