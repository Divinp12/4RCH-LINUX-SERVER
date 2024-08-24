#!/bin/bash

apt update ;

apt upgrade -y ;

apt install curl openssh-server -y ;

systemctl start ssh ;

systemctl enable ssh ;

ssh DEBIVER@DEBIVER ;

curl -sSL https://install.pi-hole.net | bash ;

pihole -a -p DEBIVER ;
