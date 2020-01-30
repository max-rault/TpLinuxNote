#!bin/bash

if [ -f /dev/md0 ];then
	echo "md0 présent ..."
	if [ -f /dev/md1 ];then
		echo "md1 présent ..."
		echo "tout les volumes raid sont présent."
		exit 0
	else
		echo "veuiller supprimer md0 et relancer le script "
		exit 1
	fi
else
	if [ -f /usr/bin/mdadm ]; then
		echo "mdadm existe"
	else 
		apt-get install mdadm
	fi

	echo "verification des disque présents"

	if [-f /dev/sdb ]; then
		echo "le disque sdb existe ...."
			if[ -f /dev/sdc ];then
				echo "le disque sdc existe ...."
			 	if[ -f /dev/sdd ];then
					echo "le disque sdd existe ....."
				 	if[ -f /dev/sde ];then
						echo "le disque sde existe ."
						echo "tout les disques sont présent verification des différentes partition ...."
					else
						echo "nombre de disques insufisant ."
						exit 1
					fi
				else
					echo "nombre de disques insufisant"
				fi
			else
				echo "nombre de disques insufisant"
				exit 1
			fi
	else
		echo "nombre de disques insufisant"
	exit 1
	fi

	if [-f /dev/sdb1 ]; then
		echo "sdb1 existe ..."
		if [-f /dev/sdc1 ]; then
			echo "sdc1 existe ..."
			if [-f /dev/sdd1 ]; then
				echo "sdd1 existe ..."
				if [-f /dev/sde1 ]; then
					echo "sde1 existe ..."
					echo "tout les disques sont configurés création du volume md0 puis md1."
				else
					echo "veuillez configurer le disque sde et relancer le script."
					exit 1
				fi
			else
				echo "veuiillez configurer le disque sdd et relancer le script."
				exit 1
			fi
		else
			echo "veuillez configurer le disque sdc et relancer le script."
			exit 1
		fi
	else
		echo "configurer le disque sdb et relancer le script."
		exit 1
	fi
	mdadm --create /dev/md0 --level5 --raid-devices=2 /dev/sdb1 /dev/sdc1
	mdadm --daemonise /dev/md0
	mkfs.ext4 /dev/md0
	if [ -f /dev/md0 ];then
		if [ -d /data ];then 
			echo "répertoire data existant"
			echo "/dev/md0	/data	ext4	defaults	0	1">>/etc/fstab
			echo "création et montage de md0 effectué ... création de md1"
		else
			mkdir /data
			echo "répertoire data créer"
			echo "/dev/md0  /data   ext4    defaults        0       1">>/etc/fstab
			echo "création et montage de md0 effectué ... création de md1"
		fi
	else
		echo "une erreur est survenue ... md0 non présent dans /dev !"
		echo "veuillez corriger l'erreur et relancer le script."
		exit 1
	fi
	mdadm --create /dev/md1 --level5 --raid-devices=2 /dev/sdd1 /dev/sde1
        mdadm --daemonise /dev/md1
        mkfs.ext4 /dev/md1
        if [ -f /dev/md1 ];then
                if [ -d /data-backup ];then 
                        echo "répertoire data-backup existant"
                        echo "/dev/md1  /data-backup   ext4    defaults        0       1">>/etc/fstab
                        echo "md0 et md1 créer et monté."
			exit 0
                else
                        mkdir /data-backup
                        echo "répertoire data-backup créer"
                        echo "/dev/md1  /data-backup   ext4    defaults        0       1">>/etc/fstab
                        echo "md0 et md1 créer et monté."
			exit 0
                fi
        else
                echo "une erreur est survenue ... md1 non présent dans /dev !"
                echo "veuillez corriger l'erreur et relancer le script."
                exit 1
        fi
	if [ -d /dev/mvg ];then
		echo "mvg existe déja ..."
		exit 0
	else
		echo "création du volume lvm ..."
		pvcreate /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
		vgcreate mvg /dev/sdb1 /dev/sdc1 /dev/sdd1 /dev/sde1
		lvcreate -n vol1 -L 1G mvg
		lvcreate -n vol2 -L 1G mvg
		lvcreate -n vol3 -L 1G mvg
		lvcreate -n vol4 -L 1G mvg
		echo "renomage de vol3 en media"
		echo "renomage de vol4 en media2"
		lvrename vol3 media
		lvrename vol4 media2
		mkfs.ext4 /dev/mvg/vol1
		mkfs.ext4 /dev/mvg/vol2
		mkfs.ext4 /dev/mvg/media
		mkfs.ext4 /dev/mvg/vol4
		echo "verification de l'existance des différents dossier de montage ..."
		if [ -d /mnt/share/ ];then
			echo "/mnt/share/ existe ..."
		else
			echo "creation du dossier /mnt/share/"
			mkdir /mnt/share/
		fi

		if [ -d /mnt/backup ];then
			echo "/mnt/backup"
		else
			echo "creation du dosiier /mnt/backup"
			mkdir /mnt/backup
		fi
		
		if [ -d /mnt/media ];then
			echo "/mnt/media existe ..."
		else
			echo "creation du dossier /mnt/media ..."
			mkdir /mnt/media
		fi
		echo "ecriture dans /etc/fstab ..."
		echo "/dev/mvg/vol1  /mnt/share/   ext4    defaults        0       2">>/etc/fstab
		echo "/dev/mvg/vol2  /mnt/backup   ext4    defaults        0       2">>/etc/fstab
		echo "/dev/mvg/media  /mnt/media   ext4    defaults        0       2">>/etc/fstab
		echo "/dev/mvg/media2  /mnt/media   ext4    defaults        0       2">>/etc/fstab
	fi
fi
exit 0

