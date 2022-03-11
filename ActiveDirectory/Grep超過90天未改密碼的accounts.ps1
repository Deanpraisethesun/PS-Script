$Tday = Get-Date
$Ago = $Tday.AddDays(-90)
Get-aduser -filter "enabled -eq 'True' -and passwordlasteset -lt '$Ago'"
