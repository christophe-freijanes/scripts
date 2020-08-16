

import-module RemoteDesktop
$Disconnect = Get-RDUserSession | Where-Object {$_.DisconnectTime -ne $null}
$Date = [datetime]::ParseExact("{0:dd/MM/yyyy HH:mm:ss}" -f (get-date), "dd/MM/yyyy HH:mm:ss", $null)
$DisconnectTime = 15
if (@($Disconnect).Count -ne 0)
{
foreach ($DisconnectUser in $Disconnect)
{
if ($Date -gt $DisconnectUser.disconnecttime.AddMinutes($DisconnectTime))
{
$DisconnectUser | Invoke-RDUserLogoff -Force
}
}
}