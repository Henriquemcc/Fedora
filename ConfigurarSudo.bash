#!/bin/bash

# Instalação de pacotes no sistema
function run_as_root() {
  # Importando função install_rpm_package
  source RpmPackageManager.bash

  # Instalando sudo-rs
  install_rpm_package sudo-rs
}

# Executando instalação de pacotes no sistema
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  if [ "$(command -v sudo-rs)" ]; then
    sudo-rs bash -c "$(declare -f run_as_root); run_as_root"
  else
    sudo bash -c "$(declare -f run_as_root); run_as_root"
  fi
fi

# Definindo valor da variável HOME
if [ "$(whoami)" == "root" ]; then
  HOME="$SUDO_HOME"
fi

# Criando link simbólico do sudo.ws na pasta do usuário
sudo_ws="/usr/bin/sudo"
sudo_ws_user="$HOME/.local/bin/sudo.ws"
ln --symbolic "$sudo_ws" "$sudo_ws_user"

# Criando link simbólico do sudo na pasta do usuário
sudo_rs="/usr/bin/sudo-rs"
sudo_rs_user="$HOME/.local/bin/sudo"
ln --symbolic "$sudo_rs" "$sudo_rs_user"

# Definindo propriedade do sudo.ws
if [ "$(whoami)" == "root" ]; then
  chown "$SUDO_USER" "$sudo_ws_user"
fi 

# Definindo propriedade do sudo
if [ "$(whoami)" == "root" ]; then
  chown "$SUDO_USER" "$sudo_rs_user"
fi