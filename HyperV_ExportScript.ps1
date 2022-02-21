#定義執行原則
$ExecutionPolicy = Get-ExecutionPolicy
if ($ExecutionPolicy -ne "RemoteSigned") {
    Set-ExecutionPolicy RemoteSigned -Force
}

#define
 $date = Get-Date -Format yyyMMdd_HH:mm

#建立日期資料夾
New-Item -ItemType Directory -Path "D:\export\SQLDB01\$((Get-Date).ToString('yyyyMMdd'))"

#匯出本伺服器上的VM，名子用-name指定，將log存到
Export-VM -Name SQLDB01 -Path "D:\export\SQLDB01\$((Get-Date).ToString('yyyyMMdd'))" -Verbose 4>&1 | Out-File C:\JOBS\SQLDB01ExportLog.txt -force


#smtp setup
 $smtp = "10.15.149.200"
 $from = (hostname) + "@ABCD.com"
 #$to = "it_SA@ABCD.com"
 $to = "Dean_zhong@ABCD.com"
 $subject = "SQLDB01_Export on $date"
 
 #Send Email 記得要用unicode...
            send-MailMessage -SmtpServer $smtp -From $from -To $to -Subject $subject -Encoding ([System.Text.Encoding]::unicode)

       

#遷移到Truenas 當複本
robocopy  "D:\export\SQLDB01\$((Get-Date).ToString('yyyyMMdd'))" "\\10.15.100.100\bakdata$\hvbk01" /J /B /E /R:1 /move
