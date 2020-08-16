#  Nom du Script  Backup_File_to_GoogleDrive
#  Créer le    22/01/2020
#  Auteur : Freijanes Christophe
#  Version : 1.0
#  Action du script : Sauvegarde de la Base MultiPutty dans Google Drive
#  Prerequis : Powershell

# Script fait et tester sous Powershell 3.0

####PREAMBULE################################################################################################# 

#Ce script permet une sauvegarde du fichier bdd.dat du logiciel MultiPutty du disque local D vers le 
#dossier de synchronisation Google Drive 

####Fonction renommage fichier avec date######################################################################
Function RenameFile ($location, $filename, $extension)
{
	$d = Get-Date -Format "ddMMyyyy"
	$old = $location + $filename + $extension 
	$new = $filename + "_" + $d + $extension
	
	Rename-Item $old $new
}

RenameFile -location "D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\SAUVEGARDE\" -filename "bdd" -extension ".dat"

####Extension#################################################################################################
$FileExtension = [io.path]::GetExtension($SourceFilePath)

####Récupération du nom du fichier#############################################################################
$FileName = [io.path]::GetFileNameWithoutExtension($SourceFilePath)

####Dossier source############################################################################################
$SourceFilePath = "D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\bdd.dat"
 
####Dossier Destination#######################################################################################
$DestinationFile = "D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\SAUVEGARDE\"

####ETAPES###################################################################################################

####CrÃ©ation du dossier \SAUVEGARDE\######################################################################### 
New-Item -Path 'D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\SAUVEGARDE\' -ItemType "directory" 

####CrÃ©ation du dossier \SAUVEGARDE\log\#####################################################################
#New-Item -Path 'D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\log\' -ItemType "directory" 

####Copie du fichier à sauvegarder############################################################################
Copy-Item $SourceFilePath $DestinationFile

####Supprimer les fichiers plus anciens que 3 jours###########################################################
Get-ChildItem $DestinationFile -Recurse -Force -ea 0 |
? {!$_.PsIsContainer -and $_.LastWriteTime -lt (Get-Date).AddDays(-3)} |
ForEach-Object {
$_ | del -Force
$_.FullName | Out-File D:\Google Drive\Documents_\Pro\xxx\xxx\MultiPutty\log\deletedbackups.txt -Append
}
####FIN########################################################################################################
                                                                                                              #
###############################################################################################################
