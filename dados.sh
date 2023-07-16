#!/bin/bash

apt install nfs-common -y
sudo mount 10.10.10.100:/var/lib/docker/volumes/meusite/_data /var/lib/docker/volumes/meusite/_data/

