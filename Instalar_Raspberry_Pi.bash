#!/bin/bash

# Executa instalação como root
function run_as_root() {

  function instalar_pacotes_dnf() {

      # Habilitando RPM Fusion
      bash ./Enable-RpmFusion.bash

      # Instalando os Sistemas de arquivos não nativos do linux
      dnf install --assumeyes ntfs-3g
      dnf install --assumeyes exfat-utils
      dnf install --assumeyes fuse
      dnf install --assumeyes fuse-exfat

      # Instalando o comando para acordar computadores pela rede
      dnf install --assumeyes wol

      # Instalando o comando para completar comandos no terminal
      dnf install --assumeyes bash-completion
    }

  # Carregando dados do arquivo .env
  source .env

  # Configurando o sshd_config
  bash ./ConfigurarSshdConfig.bash

  # Configurando DNF
  bash ./ConfigurarDnfPackageManager.bash

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Alterando o nome do computador
  hostnamectl set-hostname --static "$hostname_raspberry_pi"

  # Habilitando o RPM Fusion
  bash ./Enable-RpmFusion.bash

  # Configurando o NTP
  bash ./ConfigurarNtp.bash

  # Configurando DNF Automatic
  bash ./ConfigurarAtualizacoesAutomaticasDnfAutomaticRaspiberryPi.bash

  # Instalando pacotes dnf
  instalar_pacotes_dnf

  # Instalando o Flatpak
  bash ./Install-Flatpak.bash

  # Instalando o gerenciador de pacotes Snap
  bash ./Install-Snapd.bash

  # Instalando Java
  bash ./Install-Java_8_Headless.bash
  bash ./Install-Java_21_Headless.bash

  # Instalando o Wireguard
  bash ./Wireguard/Install-Wireguard.bash

  # Instalando o Dynamic DNS Update Client
  bash ./Install-Dynamic_Dns_Update_Client.bash

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash
}

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi
