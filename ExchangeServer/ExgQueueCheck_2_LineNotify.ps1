# LineNotify
###定義line權杖與訊息內容
$token="ASDASDASDASDU8ilF6FTWIcQdQDTfjsgksndgASDASDASDASD"
$msg="主節點Queue Mail大於80，請參考Line群記事本指令進行排查。"

###發訊副程式
function LINEnotify
{
    $api="https://notify-api.line.me/api/notify"
    $header=@{Authorization = "Bearer $token"}
    $postdata=@{message = $msg 
    ;stickerPackageId = '11537';stickerId = '52002749'}
    Invoke-RestMethod -Uri $api -Method POST -Headers $header -Body $postdata
    
    #清除復歸警告狀態 
    Remove-Item -path "C:\Exg_QueueMonitor\queuealarm.txt" -Force -Verbose 4>&1 
}
if(Test-path "C:\Exg_QueueMonitor\queuealarm.txt" )
{   
     LINEnotify
}
Exit
