#define
 $date = Get-Date -Format yyyMMdd_HH:mm
 $logfile = "C:\JOBS\DB01_BAK.txt"
 $roboSource="\\10.15.149.61\D$\DB_BAK\"
 $roboDestination ="D:\`DB_Backup$"

#Email
 $smtp = "smtp.acbdtek.com"
 $from = "QHTJYDEXP01@acbdtek.com"
 $to = "it_DBA@acbdtek.com"
 #$to = "DEAN_ZHONG@acbdtek.com"
 #$body = 
    #Get-Content .\DB01_BAK.txt -RAW
    #Get-Content .\DB01_BAK.txt| ConvertFrom-Csv
 $subject = "DB01_BAK_robocopy on $date"
 
#robocopy
#/MT:1表示同時只使用1Thread執行，減少IO負載
  robocopy $roboSource $roboDestination /E /B /copyall /xo /R:1 /W:0 /V /TEE /ETA /MOV /MT:1  "/unilog:$logfile"
            
#data life
#刪除roboDestination下，[建立日期]大於[$DataLifeTime]天的*.bak檔案
#(gt)是運算子[大於]
$DeletePath = $roboDestination
$today = get-date;
$DataLifeTime = 10
ls $DeletePath | where-object {($today – $_.CreationTime).Days -gt $DataLifeTime} | rm -include *.bak -Recurse -Verbose 4>&1 | Add-Content "C:\JOBS\Delete_BAK.txt"
#-verbose顯示刪除的詳細結果，使用Add-content寫到txt
#streams 輸出參考資料[https://devblogs.microsoft.com/scripting/understanding-streams-redirection-and-write-host-in-powershell/]

#ls "D:\$DB_Backup" -Recurse  | where-object  {($today -eq $_.CreationTime).Days}| Out-File C:\JOBS\showLS.txt -Append 

#列出今天的檔案存到showLS.txt
$today2 = Get-date -UFormat "%Y/%m/%d"
get-childitem -path D:\DB_Backup$\ -Recurse |  where-object{ (Get-Date($_.LastWriteTime) -UFormat "%Y/%m/%d") -eq $today2 } | Out-File C:\JOBS\showLS.txt 
  #showLS.txt輸入到body變數
  $inbody = Get-Content C:\JOBS\showLS.txt

#Send Email

            send-MailMessage -SmtpServer $smtp -From $from -To $to -Subject $subject -Body ($inbody | Out-String) -Attachments $logfile    -Encoding ([System.Text.Encoding]::unicode)
