#!bin/bash
#by Maxime Rault.

if [ -f /usr/bin/docker ]; then
	
	echo  "Docker est déja installé"
	if [ -f /usr/bin/docker ]; then
		echo "docker-compose est déja installé"
		echo "au revoir"
	else
                if (whiptail --title "instalation de docker-compose" --yesno "docker.io (docker) est déja installé voulez vous installer docker-compose ?" 10 60) then
                        apt-get install docker-compose
                else
                        echo "au revoir"
                fi

	fi

else
	if (whiptail --title "instalation de docker" --yesno "voulez vous installer docker ?" 10 60) then
		apt-get install docker.io
		if [ -f /usr/bin/docker-compose ];then
			echo "docker compose est déja installée"
		else 
			if (whiptail --title "installation de docker-compose" --yesno "voulez vous installer docker-compose ?" 10 60) then
				apt-get docker compose
			else
				echo "au revoir !!"
				exit 0
			fi
		fi
	else
		echo "au revoir"
		exit 0
	fi
fi

