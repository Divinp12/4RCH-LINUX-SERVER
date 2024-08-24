#!/bin/bash

apt update ;

apt upgrade -y ;

apt install curl openssh-server sshpass -y ;

systemctl start ssh ;

systemctl enable ssh ;

sshpass -p DEBIVER ssh DEBIVER@DEBIVER ;

curl -sSL https://install.pi-hole.net | bash ;

pihole -a -p DEBIVER ;
