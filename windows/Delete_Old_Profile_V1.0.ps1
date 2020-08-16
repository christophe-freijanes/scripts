#  Nom du Script  Suppression_Profile_Utilisateur
#  Créer le    29-08-2019
#  Auteur : FREIJANES Christophe
#  Version : 1.0
#  Action du script : Permet de supprimer proprement des profils utilisateur
#  Prerequis :
# - Nom du serveur 
# - année à renseigner 

# Script fait et tester sous Powershell 3.0
   

# Nom du serveur
$Serveur = hostname
# Lettre Source où sont loger les profiles utilisateur (C ou D...)

# Fonction qui permet de choisir de supprimer les profils non utiliser depuis tant d'années
$dateAnnee = Read-Host "Combien d'années pour les profils Windows souhaitez-vous garder?"


# Chemin où on va loger le ou les fichiers temporaires (qui seront supprimés par la suite)
$CheminLogTemp = "c:\temp" 
$VoirDossier = test-path -path $CheminLogTemp
If ($VoirDossier = $False) {New-Item -Name "Temp" -Path "c:\" -ItemType directory}
 
# On parcour tout les profile de la racine "\\$Serveur\$CheminProfiles$\users" (sans prendre en compte les profiles cité ci-dessous) dont la date de modification = au moi et année entré dans le XML, on selectionne que les nom pour les mettre dans un fichier txt
# Attention bien exclure vos profil Admin Application etc... | Fonction -Eclure "Profil_A_Ne_Pas_Supprimer" 
 Get-ChildItem  -Directory "C:\Users"  -Exclude "Public", "Administrator", "Default", "All Users", "Default Users", "Administrateur"  | Where {$_.LastWriteTime -lt (get-date).AddYears(-$dateAnnee)} | select name  | out-file $CheminLogTemp\ProfilASuppr_$Serveur.txt  
 
# On enleve les premiere ligne 1et 2  qui ne correspondaient pas à des profiles en enlevant les lignes blanches
 $a = get-content $CheminLogTemp\ProfilASuppr_$Serveur.txt |  select -Skip 1 | select -Skip 2 | where {$_ -ne ""}

# On écrase le fichier txt par le resultat de la commande ci dessus
 $a | out-file $CheminLogTemp\ProfilASuppr_$Serveur.txt

 write-host "Voici la liste des profiles utilisateurs qui vont être supprimé sur le serveur $Serveur :"
 Write-host "================================================================"
 get-content  $CheminLogTemp\ProfilASuppr_$Serveur.txt 
 Write-host "================================================================"

 $TraitementSuppressionProfiles = read-host "Souhaitez-vous procéder a la suppression de ces profiles? o/n"


    While ($TraitementSuppressionProfiles -ne "o" -and $TraitementSuppressionProfiles -ne "n")
   {
        write-host "Veuillez saisir une réponse correct: o ou n"
        $TraitementSuppressionProfiles = read-host "Souhaitez-vous procéder a la suppression de ces profiles? saisir o ou n"
   }
 
      # Si l'utilisateur souhaite procéder au nettoyage
      if ($TraitementSuppressionProfiles -eq "o")
     {


$i = 0
$j = 0

 
# $i prend la valeur du nombre de ligne du fichier txt
 get-content $CheminLogTemp\ProfilASuppr_$Serveur.txt | foreach {$i++}

 $ListeProfileASupprimer = get-content $CheminLogTemp\ProfilASuppr_$Serveur.txt


    foreach ($Profile in $ListeProfileASupprimer)
            {      
                    # La ligne prend pour valeur la ligne sans les caractere blanc qui était présent derriere
                    $Profile = $Profile.Trim()
                    $j++
                    Write-Progress "Compte $Profile en cours de Suppression $j sur $i"
                    
                    # on supprime les profiles
                    (Get-WmiObject win32_UserProfile -ComputerName $Serveur | where {$_.LocalPath -like "*\$Profile"}).Delete()
                    Write-host "Compte $Profile Supprimé"
                        
            }
 

      }
# On supprime le fichier temporaire
 remove-item $CheminLogTemp\ProfilASuppr_$Serveur.txt

  
 Write-host "Au revoir"   

pause 
