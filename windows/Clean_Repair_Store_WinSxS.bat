@echo off
color 2
echo Scan du regedit
sfc /scannow
pause
color 3
echo Scan de la sante de votre dossier WinSxS
DISM /Online /Cleanup-image /Scanhealth
pause
color 4
echo Analyse du store
DISM /Online /Cleanup-Image /AnalyzeComponentStore
pause
color 5
echo Commencer le nettoyage des anciennes versions des composants remplaces
DISM /Online /Cleanup-Image /StartComponentCleanup
pause
color 6
echo Le commutateur /ResetBase permet de retirer la base des composants obsoletes
DISM /Online /Cleanup-Image /StartComponentCleanup /ResetBase
pause
color 7
echo La commande provoque la reparation du magasin de packages
DISM /Online /Cleanup-Image /RestoreHealth
pause
color 8
echo Finir par le nettoyage des differents service packs installes sur le systeme.
DISM /Online /Cleanup-Image /SPSuperseded
pause
