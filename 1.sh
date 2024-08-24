#!/bin/bash

apt update ;
apt upgrade -y ;
apt install curl openssh-server -y ;
curl -sSL https://install.pi-hole.net | bash ;
pihole -a -p DEBIVER ;
