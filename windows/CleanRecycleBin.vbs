Set WshShell = WScript.CreateObject("WScript.Shell")
WshShell.Run "powershell.exe" & " -command Clear-RecycleBin -Force", 0, 0
Set WshShell = Nothing