#!bin/bash
#by Maxime Rault.

OPTION=$(whiptail --title "Menu" --menu "Choisissez la partie de l'instlation que vous voulez éffectuer" 15 60 4 \
"1" "Installer Docker et Docker-Compose" \
"2" "Desinstaller Docker et Docker-Compose" \
"3" "Montage des Disques (Raid+lvm)" \
"4" "Demontage des disques (Raid+lvm)" \
"5" "lancer l'ensemble de l'instalation" \
"6" "Demo"  3>&1 1>&2 2>&3)
 
exitstatus=$?
if [ $exitstatus = 0 ]; then
	case $OPTION in
	1) echo "lancement du script InstallDocker.sh ..."
	   sudo bash InstallDocker.sh;;
	2) echo "lancement du script UninstallDocker.sh ..."
	   sudo bash UninstallDocker.sh;;
	3) echo "lancement du script Disks_mount.sh ..."
           sudo bash Disks_mount.sh;;
	4) echo "lancement du script Disks_umount.sh ..."
	   echo "hello world ";;
	5) echo "lancement de l'instalation ..."
	   sudo bash InstallDocker.sh
	   sudo bash Disks_mount.sh;;
	6) echo "lancement du script InstallDocker.sh"
	   sudo bash InstallDocker.sh
	   echo "demonstration des verification de l'instalation de docker"
	   sudo bash InstallDocker.sh
	   echo "lancement de UninstallDocker.sh"
	   sudo bash UninstallDocker.sh
	   echo "demonstration des verification de la désinstalation de docker"
	   sudo bash UninstallDocker.sh
	   echo "lancement du script Disks_mount.sh"
	   sudo bash Disks_mount.sh
	   echo "désolée je ne peut pas vous montrer le démontage des diks ... il est en cours de construction"
	   echo "au revoir et bonne journée !";;
	esac
else
    echo "vous avez annulé"
fi
