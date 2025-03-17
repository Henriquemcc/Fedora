#!/bin/bash

# Executa instalação como root
function run_as_root() {

  # Instala o script Wait-ForPidToShutdown.bash
  function instalar_script_wait_for_pid_to_shutdown() {
      file_name="Wait-ForPidToShutdown.bash"
      destination="/bin/$file_name"
      cp "./$file_name" "$destination"
      chmod +x "$destination"
  }

  #  Instala o script Update-All.bash
  function instalar_script_update_all() {
    file_name="Update-All.bash"
    destination="/bin/$file_name"
    cp "./$file_name" "$destination"
    chmod +x "$destination"
  }

  # Instala pacotes dnf
  function instalar_pacotes_dnf() {

    # Configurando gerenciador de pacotes DNF
    bash ./ConfigurarDnfPackageManagerHenrique-PC.bash

    # Habilitando atualizações automáticas
    bash ./ConfigurarAtualizacoesAutomaticasDnfAutomatic.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.bash

    # Habilitando RPM Fusion
    bash ./Enable-RpmFusion.bash

    # Instalando o driver da Nvidia
    dnf install --assumeyes akmod-nvidia

    # Trocando o pacote ffmpeg-free por ffmpeg
    dnf swap --assumeyes --allowerasing ffmpeg-free ffmpeg

    # Instalando o KeepassXC
    dnf install --assumeyes keepassxc

    # Instalando o Libreoffice
    dnf install --assumeyes libreoffice-writer
    dnf install --assumeyes libreoffice-calc
    dnf install --assumeyes libreoffice-impress
    dnf install --assumeyes libreoffice-math
    dnf install --assumeyes libreoffice-draw
    dnf install --assumeyes libreoffice-langpack-pt-BR
    dnf install --assumeyes libreoffice-langpack-en
    dnf install --assumeyes unoconv

    # Instalando o Gnome Epiphany
    dnf install --assumeyes epiphany

    # Instalando o File Roller
    dnf install --assumeyes file-roller
    dnf install --assumeyes file-roller-nautilus

    # Instalando a Impressora HP
    dnf install --assumeyes hplip

    # Instalando o Suporte a arquivos 7zip
    dnf install --assumeyes p7zip-plugins
    dnf install --assumeyes p7zip

    # Instalando o KVM
    dnf install --assumeyes qemu-kvm
    dnf install --assumeyes libvirt

    # Instalando os Sistemas de arquivos não nativos do linux
    dnf install --assumeyes ntfs-3g
    dnf install --assumeyes exfat-utils
    dnf install --assumeyes fuse
    dnf install --assumeyes fuse-exfat

    # Instalando as Ferramentas de desenvolvimento
    dnf install --assumeyes golang
    dnf install --assumeyes gcc
    dnf install --assumeyes gcc-c++
    dnf install --assumeyes dotnet-sdk-5.0
    dnf install --assumeyes aspnetcore-runtime-5.0
    dnf install --assumeyes dotnet-runtime-5.0
    dnf install --assumeyes git
    dnf install --assumeyes git-lfs
    dnf install --assumeyes android-tools
    dnf install --assumeyes libstdc++-devel
    dnf install --assumeyes perf

    # Instalando outros programas
    dnf install --assumeyes stacer
    dnf install --assumeyes qt5-qtcharts
    dnf install --assumeyes vlc
    dnf install --assumeyes libdvdcss # Não disponível no CentOS ou RHEL
    dnf install --assumeyes qt5-qtsvg
    dnf install --assumeyes youtube-dl
    dnf install --assumeyes yt-dlp
    dnf install --assumeyes snapd
    dnf install --assumeyes flatpak
    dnf install --assumeyes qbittorrent
    dnf install --assumeyes ffmpeg
    dnf install --assumeyes steam
    dnf install --assumeyes mokutil
    dnf install --assumeyes fdupes
    dnf install --assumeyes dconf-editor
    dnf install --assumeyes gimp
    dnf install --assumeyes gedit
    dnf install --assumeyes ImageMagick
    dnf install --assumeyes wine.i686 # Não disponível no CentOS ou RHEL
    dnf install --assumeyes pdftk-java
    dnf install --assumeyes wol
    dnf install --assumeyes brasero
    dnf install --assumeyes nmap
    dnf install --assumeyes rclone
    dnf install --assumeyes wireshark

    # Instalando leitores de epub
    dnf install --assumeyes calibre
    dnf install --assumeyes okular

    # Instalando pacotes para reportar erro automaticamente
    dnf install --assumeyes abrt-desktop
    dnf install --assumeyes abrt-java-connector

    # Instalando ferramentas de segurança
    dnf install --assumeyes chkrootkit
    dnf install --assumeyes lynis

    # Instalando o Draw.io
    dnf install --assumeyes https://github.com/jgraph/drawio-desktop/releases/download/v24.1.0/drawio-x86_64-24.1.0.rpm

    # Desinstalando pacotes inúteis
    ## Extensões Gnome Shell
    dnf autoremove --assumeyes gnome-shell-extension-background-logo
    dnf autoremove --assumeyes gnome-shell-extension-window-list
  }

  # Instala pacotes snap
  function instalar_pacotes_snap() {

    # Instalando snapd
    bash ./Install-Snapd.bash

    # Instalando pacotes snap
    while true; do
      snap install spotify && break
    done

    while true; do
      snap install intellij-idea-community --classic && break
    done

    while true; do
      snap install pycharm-community --classic && break
    done

    while true; do
      snap install clion --classic && break
    done

    while true; do
      snap install flutter --classic && break
    done

    while true; do
      snap install kotlin --classic && break
    done
    
    while true; do
      snap install postman && break
    done
    
    while true; do
      snap install webstorm --classic && break
    done

  }

  # Instala pacotes flatpak
  function instalar_pacotes_flatpak() {
    # Instalando o Flatpak
    bash ./Install-Flatpak.bash

    # Instalando o FlatHub
    bash ./Install-Flathub.bash

    # Instalando o Audacity
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref

    # Instalando o RetroArch
    flatpak install --assumeyes https://flathub.org/repo/appstream/org.libretro.RetroArch.flatpakref

    # Instalando o Signal
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref

    # Instalando o Free File Sync
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.freefilesync.FreeFileSync.flatpakref

    # Instalando o Discord
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.discordapp.Discord.flatpakref
    
    # Instalando o Stremio
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.stremio.Stremio.flatpakref
    
    # Instalando Gnome Clock
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gnome.clocks.flatpakref
  }

  # Configurando Firewalld
  bash ./ConfigurarFirewalld.bash

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Desabilitando o sshd
  bash ./Disable-Sshd.bash

  # Alterando o nome do computador
  hostnamectl set-hostname --static henrique-pc
  hostnamectl set-hostname --pretty HENRIQUE-PC

  # Configurando o Grub
  bash ./ConfigurarGrub.bash

  # Configurando o NTP
  bash ./ConfigurarNtp.bash

  # Instalando o Google Chrome
  bash ./Install-GoogleChromeStable.bash

  # Instalando o Visual Studio Code
  bash ./Install-VisualStudioCode.bash

  # Instalando o PowerShell
  bash ./Install-PowerShell.bash

  # Instalando o Secure Delete
  bash ./Install-Srm.bash

  # Instalando pacotes dnf
  instalar_pacotes_dnf

  # Instalando Java
  bash ./Install-Java_8_Gui.bash
  bash ./Install-Java_21_Gui.bash
  bash ./Install-Java_21_Devel.bash

  # Instalando o Wireguard
  bash ./Wireguard/Install-Wireguard.bash

  # Instalando pacotes snap
  instalar_pacotes_snap

  # Instalando pacotes flatpak
  instalar_pacotes_flatpak

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o Docker
  bash ./Install-DockerDesktop.bash

  # Configurando o Docker
  bash ./ConfigurarDocker.bash

  # Instalando o VirtualBox
  bash ./Install-OracleVirtualBox.bash
  bash ./Sign-VirtualBox.bash

  # Instalando o Peazip
  bash ./Install-Peazip.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown

  # Instalando GitHub Cli
  bash ./Install-GithubCli.bash
}

# Configurando o Gnome Shell
bash ./ConfigurarGnomeShell.bash

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.bash

# Instalando o Ffmpeg
bash ./Install-Ffmpeg.bash

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi
