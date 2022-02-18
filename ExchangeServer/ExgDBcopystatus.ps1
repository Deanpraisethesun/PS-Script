
$smtpServer="smtp.ABCD.com"
$from = (hostname) + "_DBcopyStatus@ABCD.com"
$emailaddress =(hostname) + "_DBcopyStatus@ABCD.com"
$subject = ”DB copy status”
$Attachments = “C:\JOBS\Check_MailboxDatabaseCopyStatus\MailboxDatabase.txt”

Send-Mailmessage -smtpServer $smtpServer -from $from -to $emailaddress -subject $subject -Attachments $Attachments -priority High -Encoding ([System.Text.Encoding]::UTF8)
