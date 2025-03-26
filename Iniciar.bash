#!/bin/bash

# Salvando o path anterior
path_old_current_dir="$(pwd)"

# Instalando os programas necessários
sudo dnf install --assumeyes unzip

# Baixando o arquivo zip do repositório
url_file="https://github.com/Henriquemcc/Fedora/archive/refs/heads/main.zip"
path_download_file="/tmp/Fedora_main.zip"
curl -L "$url_file" > "$path_download_file"

# Extraíndo arquivo zip
unzip -o "$path_download_file" -d "/tmp"

# Entrando dentro da pasta
cd "/tmp/Fedora-main" || exit 1

# Executando script
bash ./Executar.bash

# Voltando ao caminho anterior
cd "$path_old_current_dir" || exit 1