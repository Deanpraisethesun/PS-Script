# 清除LOG
### Log保留天數，記得參考標準文件所記錄的保留天數要求......
### 節省維護作業的時間&硬碟空間
$days = 30

### 路徑定義
```
$IISPath1 = "C:\inetpub\logs\LogFiles\"
$LoggingPath1 = "C:\Program Files\Microsoft\Exchange Server\V15\Logging\"
$LogPath1 = "C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\ETLTraces\"
$LogPath2 = "C:\Program Files\Microsoft\Exchange Server\V15\Bin\Search\Ceres\Diagnostics\Logs\"
```

### Clean the logs
Function DelLogFiles($TargetFolder) {
    Write-Host -Debug -ForegroundColor Yellow -BackgroundColor Cyan $TargetFolder

    if (Test-Path $TargetFolder) {
        $Now = Get-Date
        $LastWrite = $Now.AddDays(-$days)
        $Files = Get-ChildItem $TargetFolder -Recurse | Where-Object { $_.Name -like "*.log" -or $_.Name -like "*.blg" -or $_.Name -like "*.etl" } | Where-Object { $_.lastWriteTime -le "$lastwrite" } | Select-Object FullName
        foreach ($File in $Files) {
            $FullFileName = $File.FullName  
            Write-Host "Deleting file $FullFileName" -ForegroundColor "DarkGreen"; 
            Remove-Item $FullFileName -ErrorAction SilentlyContinue | out-null
        }
    }
    Else {
        Write-Host "The folder $TargetFolder doesn't exist! Check the folder path!" -ForegroundColor "Cyan"
    }
}
DelLogFiles($IISPath1)
DelLogFiles($LoggingPath1)
DelLogFiles($LogPath1)
DelLogFiles($LogPath2)
