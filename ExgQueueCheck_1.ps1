# QueueCheck
### 啟動EXG2016 PS模組

. "C:\Program Files\Microsoft\Exchange Server\V15\bin\RemoteExchange.ps1"

Connect-ExchangeServer -auto


### 檢查模組
function check_mail_queue
{
$queue = Get-TransportService EXG* | Get-Queue | Measure-Object MessageCount -Max
$service = Get-service -Name "Microsoft Exchange Transport"
$status = $service.status
}

### 寄送模組
###### 注意悖論，EXG失效時，實務上是無法寄信的
function Send_smtp
{
param ($queue, $service)
$emailfrom = (hostname) + "_Queue@ABCD.com"
$to = "Dean_zhong@ABCD.com"
$subject = "Mail Queue Size gt 80"
$body = "The message queue has grown to approximately $queue which is higher than it should be under normal circumstances.Please investigate immediately. Transport Service was $status ." 
$smtpserver = "smtp.ABCD.com"
$smtp = new-object net.mail.smtpclient($smtpserver)
$smtp.send($emailfrom, $to, $subject, $body)
}


### 執行檢查模組
check_mail_queue

#重啟服務模組
#比較值為 50發mail，80 發LINE


if ($queue.maximum -gt 80)
{
### 產生檔案觸發使Line發訊
#force帶強制覆蓋，避免運作錯誤
New-Item -Path "\\abcd05\C$\Exg_QueueMonitor\queuealarm.txt" -ItemType File -force

### 重啟 TransportService
#stop-service "Microsoft Exchange Transport"
#Start-Service "Microsoft Exchange Transport"

#remote solution
#Get-Service -Name "Microsoft Exchange Transport" -ComputerName exg02 | Set-Service -Status Stopped
#Get-Service -Name "Microsoft Exchange Transport" -ComputerName exg02 | Set-Service -Status Running
}
elseif ($queue.maximum -gt 50)
{
 ### 寄信
Send_smtp $queue.maximum $service $status
}


EXIT

   

