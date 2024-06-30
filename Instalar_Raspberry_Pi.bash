#!/bin/bash

# Executa instalação como root
function run_as_root() {

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Alterando o nome do computador
  hostnamectl set-hostname --static rpi
  
  # Configurando o sshd_config
  bash ./ConfigurarSshdConfig.bash

  # Configurando DNF
  bash ./ConfigurarDnfPackageManager.bash
  
  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Configurando DNF Automatic
  bash ./ConfigurarAtualizacoesAutomaticasDnfAutomatic.bash

  # Instalando o Wireguard
  bash ./Wireguard/Install-Wireguard.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash
  
  # Desabilitando o Cockpit
  systemctl disable cockpit.socket
}

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi