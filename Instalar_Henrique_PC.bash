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

    # Obtendo funções install_rpm_packages e uninstall_rpm_packages
    source ./RpmPackageManager.bash

    # Configurando gerenciador de pacotes DNF
    bash ./ConfigurarDnfPackageManagerHenrique-PC.bash

    # Habilitando atualizações automáticas
    bash ./ConfigurarAtualizacoesAutomaticasDnfAutomatic.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.bash

    # Habilitando RPM Fusion
    bash ./Enable-RpmFusion.bash

    # Instalando a Impressora HP
    install_rpm_package hplip

    # Instalando o KVM
    install_rpm_package qemu-kvm
    install_rpm_package libvirt

    # Instalando os Sistemas de arquivos não nativos do linux
    install_rpm_package fuse

    # Instalando outros programas
    install_rpm_package sudo-rs

    # Instalando ferramentas de segurança
    install_rpm_package chkrootkit
    install_rpm_package lynis

    # Instalando outros programas
    install_rpm_packages mokutil

    # Instalando o File Roller
    dnf install --assumeyes file-roller
    dnf install --assumeyes file-roller-nautilus

    # Trocando o pacote ffmpeg-free por ffmpeg
    dnf swap --assumeyes --allowerasing ffmpeg-free ffmpeg

    # Instalando o Suporte a arquivos 7zip
    dnf install --assumeyes p7zip-plugins
    dnf install --assumeyes p7zip

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
    dnf install --assumeyes python3-pip
    dnf install --assumeyes python3-devel

    # Instalando outros programas
    dnf install --assumeyes vlc
    dnf install --assumeyes stacer
    dnf install --assumeyes qt5-qtcharts
    dnf install --assumeyes libdvdcss # Não disponível no CentOS ou RHEL
    dnf install --assumeyes qt5-qtsvg
    dnf install --assumeyes youtube-dl
    dnf install --assumeyes yt-dlp
    dnf install --assumeyes ffmpeg
    dnf install --assumeyes fdupes
    dnf install --assumeyes ImageMagick
    dnf install --assumeyes pdftk-java
    dnf install --assumeyes wol
    dnf install --assumeyes brasero
    dnf install --assumeyes rclone
    dnf install --assumeyes wireshark

    # Instalando o Draw.io
    dnf install --assumeyes "https://github.com/jgraph/drawio-desktop/releases/download/v26.2.15/drawio-x86_64-26.2.15.rpm"
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

    # Instalando o BitWarden
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.bitwarden.desktop.flatpakref

    # Instalando o KeepassXC
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.keepassxc.KeePassXC.flatpakref

    # Instalando o OnlyOffice
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.onlyoffice.desktopeditors.flatpakref

    # Instalando o LibreOffice
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.libreoffice.LibreOffice.flatpakref

    # Instalando o Gimp
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gimp.GIMP.flatpakref

    # Instalando o Gedit
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gnome.gedit.flatpakref

    # Instalando o Calibre
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.calibre_ebook.calibre.flatpakref

    # Instalando o Okular
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.kde.okular.flatpakref

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

    # Instalando o Dconf Editor
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/ca.desrt.dconf-editor.flatpakref
    
    # Instalando o Stremio
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.stremio.Stremio.flatpakref
    
    # Instalando Gnome Clock
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.gnome.clocks.flatpakref

    # Instalando o Packet (Quick-Share)
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/io.github.nozwock.Packet.flatpakref

    # Instalando o Steam
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.valvesoftware.Steam.flatpakref

    # Instalando o qbittorrent
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.qbittorrent.qBittorrent.flatpakref
  }

  # Adicionando suporte ao NTFS e ao Ex-Fat (de preferência por módulo do Kernel)
  bash ./Enable-Ntfs.bash
  bash ./Enable-ExFat.bash

  # Configurando Systemd-Resolved
  bash ./ConfigurarSystemdResolved.bash

  # Configurando Firewalld
  bash ./ConfigurarFirewalld.bash

  # Desabilitando o Cockpit
  bash ./Disable-Cockpit.bash

  # Desabilitando o sshd
  bash ./Disable-Sshd.bash

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

  # Instalando o Balena Etcher
  bash ./Install-BalenaEtcher.bash

  # Instalando o Unity Hub
  bash ./Install-UnityHub.bash

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
  bash ./ConfigurarVirtualbox.bash

  # Instalando o Peazip
  bash ./Install-Peazip.bash

  # Instalando o script Update-All.bash
  instalar_script_update_all

  # Instalando o script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown

  # Instalando GitHub Cli
  bash ./Install-GithubCli.bash

  # Configurando o remapeamento do teclado
  bash ./ConfigurarRemapeamentoTeclado.bash
}

# Configurando o Gnome Shell
bash ./ConfigurarGnomeShell.bash

# Configurando o Git
bash ./ConfigurarGit.bash

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.bash

# Instalando o Ffmpeg
bash ./Install-Ffmpeg.bash

# Instalando programas como root
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  if [ "$(command -v sudo-rs)" ]; then
    sudo-rs bash -c "$(declare -f run_as_root); run_as_root"
  else
    sudo bash -c "$(declare -f run_as_root); run_as_root"
  fi
fi
