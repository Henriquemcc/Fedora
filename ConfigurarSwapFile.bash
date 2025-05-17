#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# https://linuxize.com/post/create-a-linux-swap-file/
# Criando arquivo
fallocate -l 32G /swapfile

# Alterando permissões
chmod 600 /swapfile

# Configurando swap
mkswap /swapfile

# Habilitando swapfile
swapon /swapfile

# Adicionando swapfile ao arquivo fstab
echo "/swapfile swap swap defaults 0 0" >> /etc/fstab