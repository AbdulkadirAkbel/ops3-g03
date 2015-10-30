Dim objSysInfo, objUser
Set objSysInfo = CreateObject("ADSystemInfo")

Set objUser = GetObject("LDAP://" & objSysInfo.UserName)

WScript.Echo "Welkom op het domein Projecten2, " & objUser.GivenName & objUser.sn & "!"