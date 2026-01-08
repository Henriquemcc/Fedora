#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Instalando requisitos
install_rpm_package "cargo"

# Instalando programa que remapeia teclado
cargo install xremap --features gnome

# Configurando o remapeamento do teclado
keyboard_mapper_file="/etc/xremap/keyboard.yml"
mkdir -p "$(dirname $keyboard_mapper_file)"
if ! [ -f "$keyboard_mapper_file" ]; then
  {
    echo "modmap:"
    echo "  - name: Left Key replacement"
    echo "    remap:"
    echo "      KEY_RIGHTALT: KEY_LEFT"
  } > "$keyboard_mapper_file"
fi

# Criando serviço no Systemd
executable_file_path="/root/.cargo/bin/xremap"
service_name="remapear-teclado.service"
service_file_path="/etc/systemd/system/${service_name}"
{
  echo "[Unit]"
  echo "Description=Remapeamento do teclado utilizando o xremap"
  echo ""
  echo "[Service]"
  echo "Type=simple"
  echo "ExecStart=${executable_file_path} ${keyboard_mapper_file}"
  echo "Restart=on-failure"
  echo "[Install]"
} > "$service_file_path"

# Recarregando systemd para reconhecer o novo serviço
systemctl daemon-reload