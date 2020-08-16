#  Nom du Script  Export Users to CSV
#  Créer le    22/01/2020
#  Auteur : Freijanes Christophe
#  Version : 1.0
#  Action du script : Permet de faire un listage de vos utilisateurs au format CSV
#  Prerequis : Powershell

# Script fait et tester sous Powershell 3.0

#Path root
$pathScriptRoot          = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition

##Variable
$sUserName;
$dLastLogonDate;
$sSamAccountName;
$aMemberof;
$sPrimaryGroup;
$dCreatedDate;

#Get-Credential
$userID = "Votre ID"
$userPWD = "Votre mot de passe"
$tmpUserName = "NOMDEVOTREDOMAINE\" + $userID 
$tmpPassWord = ConvertTo-SecureString $userPWD -AsPlainText -Force
$credentialUserID  = New-Object System.Management.Automation.PSCredential -ArgumentList ($tmpUserName, $tmpPassWord)

#Query 
import-module activedirectory
$listAdUsers = Get-ADUser -Server "HOSTNAME" -Filter '*' -SearchBase "OU=NAMECLIENT,DC=NOMDEVOTREDOMAINE,DC=GROUP,DC=COM" -Credential $credentialUserID -Properties Name,SamAccountName,Created,LastLogonDate,PrimaryGroup,MemberOF;

New-Item "$pathScriptRoot\exportUser.csv" -ItemType File -Force

add-content "$pathScriptRoot\exportUser.csv" "USERNAME;IDCONNECT;PRIMARYGROUP;MEMBEROF;LASTLOGON;CREATEDDATE"


foreach($user in $listAdUsers){

$sUserName = $user.Name;
$dLastLogonDate = $user.LastLogonDate;
$sSamAccountName = $user.SamAccountName;
$aMemberof = $user.MemberOF;
$sPrimaryGroup = $user.PrimaryGroup;
$dCreatedDate = $user.Created;

add-content "$pathScriptRoot\exportUserCCV.csv" $($sUserName + ";" + $sSamAccountName + ";" + $sPrimaryGroup + ";" + $aMemberof + ";" + $dLastLogonDate + ";" + $dCreatedDate)

};
#END