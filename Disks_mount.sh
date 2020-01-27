#!bin/bash

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
					echo "nombre de disque insufisant ."
					exit 1
				fi
			else
				echo "nombre de disque insufisant"
			fi
		else
			echo "nombre de disques insufisant"
			exit 1
		fi
else
	echo "nombre de disque insufisant"
	exit 1
fi

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
                                        echo "nombre de disque insufisant ."
                                        exit 1
                                fi
                        else
                                echo "nombre de disque insufisant"
                        fi
                else
                        echo "nombre de disques insufisant"
                        exit 1
                fi
else
        echo "nombre de disque insufisant"
        exit 1
fi

