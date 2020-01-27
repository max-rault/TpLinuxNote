#!bin/bash
#by Maxime Rault.

if [ -f /usr/bin/docker ]; then
echo  "Docker est déja installé"
dpkg -l | grep -i docker
apt-get purge -y docker-engine docker docker.io docker-ce
apt-get autoremove -y --purge docker-engine docker docker.io docker-ce
rm -rf /var/lib/docker /etc/docker
rm /etc/apparmor.d/docker
groupdel docker
rm -rf /var/run/docker.sock
else
echo "Docker n'est pas installé"
fi

