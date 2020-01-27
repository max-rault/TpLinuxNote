#!bin/bash
#by Maxime Rault.

if [ -f /usr/bin/docker ]; then
echo  "Docker est déja installé"
else
apt-get install docker.io
fi
