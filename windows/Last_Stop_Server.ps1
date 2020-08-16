#  Nom du Script  LastStopServer
#  Créer le    23/01/2020
#  Auteur : Freijanes Christophe
#  Version : 1.0
#  Action du script : Permet l'historique de l'arrêt du serveur et quels processus la exécuté
#  Prerequis : Powershell

# Script fait et tester sous Powershell 3.0

Get-EventLog System | Where-Object {$_.EventID -eq "1074" -or $_.EventID -eq "6008" -or $_.EventID -eq "1076"} | ft Machinename, TimeWritten, UserName, EventID, Message -AutoSize -Wrap
