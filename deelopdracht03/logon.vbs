Dim objSysInfo, objUser
Set objSysInfo = CreateObject("ADSystemInfo")

Set objUser = GetObject("LDAP://" & objSysInfo.UserName)

WScript.Echo "Welkom op het domein Project3, " & objUser.GivenName & objUser.sn & "!"