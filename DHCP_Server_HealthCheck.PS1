#取值轉字串放入變數
$QH_DHCP_Service = get-service DHCPServer | Out-String
$QH_DHCP_Status = Get-DhcpServerv4ScopeStatistics -ComputerName dhcp02.unimicron.com | Out-String
#合併兩變數內的string
$StringMerge01 = $QH_DHCP_Service + $QH_DHCP_Status
$SubjectService = get-service DHCPServer |select Status 
 ### Smtp setup

$smtp = "smtp.gmail.com"
$from = (hostname) + "_DHCPStatus@gmail.com"
$to = "Dean_zhong@gmail.com"
$CC = "Dean_zhong@gmail.com"
$date = Get-Date -Format yyyMMdd_HH:mm
$subject = "DHCP  $SubjectService "
$encoding = [System.Text.Encoding]::UTF8

 ### dhcp設定檔備份附件
 #$atcm1= "C:\JOBS\DHCP_backup\DhcpCfg"
  

#### Send Email

 send-MailMessage -SmtpServer $smtp -From $from -To $to -Cc $cc -Subject $subject  -Encoding $encoding -Body  $StringMerge01 #-Attachments $atcm1
