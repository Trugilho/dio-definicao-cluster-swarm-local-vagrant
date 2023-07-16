#!/bin/bash
sudo docker volume create meusite

echo "Instalando o UNZIP"
sudo apt-get install unzip -y

echo "Baixando aplicação no GitHub"
cd /tmp
sudo wget -c https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

echo "extraindo arquivos com UNZIP"
sudo unzip main.zip

echo "Copiando arquivos para diretório APACHE"
cd linux-site-dio-main
sudo cp -R * /var/lib/docker/volumes/meusite/_data/
sudo docker service create --name meu-site --replicas 15 -dt -p 80:80 --mount type=volume,src=meusite,dst=/usr/local/apache2/htdocs/ httpd 

echo "Configurando consistência de dados"
sudo apt install nfs-server -y
cd /etc
sudo chmod 777 exports

sudo echo '/var/lib/docker/volumes/meusite/_data/ *(rw,sync,subtree_check)' >> exports
exportfs -ar

echo "Finalizado!"