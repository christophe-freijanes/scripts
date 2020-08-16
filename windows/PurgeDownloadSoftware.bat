@echo off
echo ::: Etape 1 - Stop du service WindowsUpdate
net stop wuauserv
echo ::: Etape 2 - Renommage du dossier \SoftwareDistribution en *.bak
rename "%windir%\SoftwareDistribution" "softwaredistribution.old"
echo ::: Etape 3 - Start du service WindowsUpdate
net start wuauserv
echo ::: Etape 4 - REM Effacement de l'ancien repertoire
RD /S /Q "%windir%\SoftwareDistribution.old"
Pause