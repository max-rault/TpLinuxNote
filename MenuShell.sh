#!bin/bash
#by Maxime Rault.

OPTION=$(whiptail --title "Menu Box" --menu "Choisissez votre distriubtion linux" 15 60 4 \
"1" "Installer Docker et Docker-Compose" \
"2" "Desinstaller Docker et Docker-Compose" \
"3" "Montage des Disques (Raid+lvm)" \
"4" "Demontage des disques (Raid+lvm)"  3>&1 1>&2 2>&3)
 
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
	esac
else
    echo "vous avez annulé"
fi
