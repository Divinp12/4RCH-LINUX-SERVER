sudo pacman -S docker docker-compose

sudo systemctl start docker
sudo systemctl enable docker

mkdir ~/pihole
cd ~/pihole

docker network create --subnet=172.18.0.0/16 pihole_network

Crie um arquivo docker-compose.yml

version: '3'

services:
  pihole:
    image: pihole/pihole
    container_name: pihole
    restart: unless-stopped
    environment:
      - WEBPASSWORD=your_password_here
      - DNS1=1.1.1.1
      - DNS2=1.0.0.1
      - PIHOLE_DNS_=8.8.8.8;8.8.4.4
      - DHCP_ACTIVE=true
      - DHCP_START=192.168.1.100
      - DHCP_END=192.168.1.200
      - DHCP_ROUTER=192.168.1.1
      - DHCP_LEASETIME=24h
    volumes:
      - './etc-pihole/:/etc/pihole/'
      - './etc-dnsmasq.d/:/etc/dnsmasq.d/'
    ports:
      - "80:80"
      - "443:443"
      - "53:53/tcp"
      - "53:53/udp"
    cap_add:
      - NET_ADMIN

mkdir -p etc-pihole etc-dnsmasq.d

sudo docker-compose up -d

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pihole

docker network inspect bridge
