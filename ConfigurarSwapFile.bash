#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# https://linuxize.com/post/create-a-linux-swap-file/
# Criando arquivo
fallocate -l 32G /swapfile || exit 1

# Alterando permissões
chmod 600 /swapfile || exit 1

# Configurando swap
mkswap /swapfile || exit 1

# Habilitando swapfile
swapon /swapfile || exit 1

# Adicionando swapfile ao arquivo fstab
swapfile_fstab_string="/swapfile swap swap defaults 0 0"
fstab_file_path="/etc/fstab"
if ! grep -q "$swapfile_fstab_string" "$fstab_file_path"; then
  echo "$swapfile_fstab_string" >> "$fstab_file_path"
fi