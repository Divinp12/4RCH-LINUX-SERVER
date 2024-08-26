sudo pacman -S docker docker-compose

sudo systemctl start docker
sudo systemctl enable docker

sudo mkdir ~/pihole
sudo cd ~/pihole

sudo docker network create --subnet=172.18.0.0/16 pihole_network

sudo mkdir docker-compose.yml

sudo mkdir -p etc-pihole etc-dnsmasq.d

sudo docker-compose up -d

sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' pihole

docker network inspect bridge
