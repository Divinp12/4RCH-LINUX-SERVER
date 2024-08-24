#!/bin/bash

apt update ;

apt upgrade -y ;

apt install curl openssh-server sshpass -y ;

systemctl start ssh ;

systemctl enable ssh ;

sshpass -p DEBIVER ssh DEBIVER@DEBIVER ;

curl -sSL https://install.pi-hole.net | bash ;

pihole -a -p DEBIVER ;

PIHOLE_INTERFACE=enp2s0f2
PIHOLE_DNS_1=8.8.8.8
PIHOLE_DNS_2=8.8.4.4
QUERY_LOGGING=true
INSTALL_WEB_SERVER=true
INSTALL_WEB_INTERFACE=true
LIGHTTPD_ENABLED=true
CACHE_SIZE=10000
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSMASQ_LISTENING=local
WEBPASSWORD=DEBIVER
BLOCKING_ENABLED=true
