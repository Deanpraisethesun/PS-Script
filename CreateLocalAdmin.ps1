#帳戶名稱Deanpraisethesun, 密碼Aa123456789
net user Deanpraisethesun Aa123456789 /add

#注意引號，設定密碼不被原則政策過期
WMIC USERACCOUNT WHERE "Name='Deanpraisethesun'" SET PasswordExpires=FALSE

#納入admin群組
net localgroup administrators Deanpraisethesun /add
