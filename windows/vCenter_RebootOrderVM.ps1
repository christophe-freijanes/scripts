#  Nom du Script  RebootOrderVM
#  Créer le    22/01/2020
#  Auteur : Freijanes Christophe
#  Version : 1.0
#  Action du script : Permet de faire un redémarrage dans l'ordre de VMs hébergés dans votre vCenter
#  Prerequis : Powershell

# Script fait et tester sous Powershell 3.0


# Déclaration des Variables
$vcenter_cible = "urlvCenter"
$vcenter_user ="user_scheduler"
$vcenter_password = "motdepasse"
$serverlist1 = "SRV02","SRVIIS01","SRVAPP01","SRVBDD01"
$serverlist2 = "SRVBDD01","SRVAPP01","SRVIIS01","SRVIIS01"
$date = Get-Date -format dd-MM-yyyy

Start-Transcript -Path C:\scripts\ND\Logs\log_$date.txt

# Import des modules PowerCLI
Get-Module -Name VMware* -ListAvailable | Import-Module

# Connexion au vCenter
Connect-VIServer -Server $vcenter_cible -User $vcenter_user -Password $vcenter_password -Force

# Extinction des VMs
foreach($vmName1 in $serverlist1){

    # Lister les VMs
    $MyVM1 = Get-VM -Name $vmName1

    if ($MyVM1.PowerState -eq "PoweredOn") {
        Write-Host "Shutting Down" $MyVM1
        Shutdown-VMGuest -VM $MyVM1 -confirm:$false
                           
        # Attente de l'extinction des VMs
        do {
            
            # Attente de 30 secondes
            Start-Sleep -s 30
            
            # Check de l'état de la VM
            $MyVM1 = Get-VM -Name $vmName1
            $status2 = $MyVM1.PowerState
            Write-Host $MyVM1 "still" $status2
            }until($status2 -eq "PoweredOff")
    }
    
    else {
        Write-Host $MyVM1 "already down"
    }
}

Start-Sleep -s 60

# Démarrage des VMs
foreach($vmName2 in $serverlist2){

    # Lister les VMs
    $MyVM2 = Get-VM -Name $vmName2
    
    if ($MyVM2.PowerState -eq "PoweredOff") {
        Write-Host "Starting" $MyVM2
        Start-VM -VM $MyVM2
                           
        # Attente du démarrage des VMs
        do {

            # Attente de 30 secondes
            Start-Sleep -s 30

            # Check de l'état de la VM
            $MyVM2 = Get-VM -Name $vmName2
            $status2 = $MyVM2.PowerState
            Write-Host $MyVM2 "still" $status2
            }until($status2 -eq "PoweredOn")
    }
    
    else {
        Write-Host $MyVM2 "already up"
    }
}

Write-Host "deconnexion du vcenter $vcenter_cible du site cible"
Disconnect-VIServer $vcenter_cible -confirm:$false
Start-Sleep -Seconds 5

Stop-Transcript