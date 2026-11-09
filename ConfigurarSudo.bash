#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Instalando sudo-rs
install_rpm_package sudo-rs

# Definindo o caminho dos executáveis
sudo_ws="/usr/bin/sudo.ws"
sudo_rs="/usr/bin/sudo-rs"
sudo="/usr/bin/sudo"

# Movendo o executável do sudo para sudo.ws
if ! [ -f $sudo_ws ]; then
  mv "$sudo" "$sudo_ws"
fi

# Fazendo do sudo-rs o sudo padrão
if ! [ -f "$sudo" ]; then
  ln --symbolic "$sudo_rs" "$sudo"
fi