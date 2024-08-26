sudo pacman -S docker docker-compose

sudo systemctl start docker
sudo systemctl enable docker

sudo mkdir ~/pihole
sudo cd ~/pihole

sudo docker network create --subnet=172.18.0.0/16 pihole_network

sudo mkdir docker-compose.yml

sudo echo "version: '3'

services:
  pihole:
    image: pihole/pihole:latest
    container_name: pihole
    environment:
      - TZ=America/Sao_Paulo  # Ajuste o fuso horário conforme necessário
      - WEBPASSWORD=suasenha  # Defina uma senha para o painel web do Pi-hole
      - DNS1=8.8.8.8  # DNS primário
      - DNS2=8.8.4.4  # DNS secundário
      - DHCP_ACTIVE=true  # Habilita o DHCP
      - DHCP_IPv4=true
      - DHCP_ROUTER=172.18.0.1  # Endereço do roteador na rede Docker
      - DHCP_LEASETIME=24h  # Tempo de concessão do DHCP
      - PIHOLE_DNS_=8.8.8.8;8.8.4.4  # DNS do Pi-hole
    ports:
      - "8080:80"  # Porta para o painel web do Pi-hole
      - "8443:443"  # Porta para HTTPS (se necessário)
      - "53:53/tcp"  # Porta para DNS
      - "53:53/udp"  # Porta para DNS
    volumes:
      - "./etc-pihole:/etc/pihole"
      - "./etc-dnsmasq.d:/etc/dnsmasq.d"
    restart: unless-stopped
    networks:
      pihole_network:
        ipv4_address: 172.18.0.2  # Endereço IP fixo para o Pi-hole

networks:
  pihole_network:
    driver: bridge
    ipam:
      config:
        - subnet: 172.18.0.0/16  # Sub-rede para a rede do Pi-hole" > docker-compose.yml

sudo mkdir -p etc-pihole etc-dnsmasq.d

sudo docker-compose up -d

sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pihole

docker network inspect bridge
