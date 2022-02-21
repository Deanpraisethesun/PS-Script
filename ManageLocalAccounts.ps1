#新增一帳戶，名稱Deanpraisethesun, 密碼Aa123456789
$Password = Aa123456789
New-LocalUser -Name Deanpraisethesun -Description “Deanpraisethesun” -Password $Password
#或者
#net user Deanpraisethesun Aa123456789 /add

#設定密碼不被原則政策過期，注意引號
WMIC USERACCOUNT WHERE "Name='Deanpraisethesun'" SET PasswordExpires=FALSE

#納入admin群組
Add-LocalGroupMember -Group “Administrators” -Member “Deanpraisethesun”
#或者
#net localgroup administrators Deanpraisethesun /add

#移除admin群組中的
Remove-LocalGroupMember -Group “Administrators” -Member Deanpraisethesun
