#!bin/bash
#by Maxime Rault.

if (whiptail --title "Désinstaller Docker et Docker-compose" --yesno "Voulez vous désinstaller docker et docker-compose ?" 10 60) then
	if [ -f /usr/bin/docker ]; then
		dpkg -l | grep -i docker
		apt-get purge -y docker-engine docker docker.io docker-ce docker-compose
		apt-get autoremove -y --purge docker-engine docker docker.io docker-ce docker-compose
		rm -rf /var/lib/docker /etc/docker
		rm /etc/apparmor.d/docker
		groupdel docker
		rm -rf /var/run/docker.sock
	else
		echo "Docker n'est pas installé"
	fi
else 
echo "au revoir"
exit 0

fi
