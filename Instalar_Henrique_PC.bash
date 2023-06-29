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

  #  Instala script Update-All.bash
  function instalar_script_update_all() {
    sudo cp ./Update-All.bash /bin/Update-All.bash
    sudo chmod +x /bin/Update-All.bash
  }

  # Instala pacotes dnf
  function instalar_pacotes_dnf() {

    # Configurando gerenciador de pacotes DNF
    bash ./Configure-DnfPackageManager.bash

    # Habilitando atualizações automáticas
    bash ./Enable-AutomaticUpdatesWithDnfAutomatic.bash

    # Atualizando todos os pacotes instalados
    bash ./Update-All.bash

    # Habilitando RPM Fusion
    bash ./Enable-RpmFusion.bash

    # Instalando o KeepassXC
    sudo dnf install --assumeyes keepassxc

    # Instalando o Libreoffice
    sudo dnf install --assumeyes libreoffice-writer
    sudo dnf install --assumeyes libreoffice-calc
    sudo dnf install --assumeyes libreoffice-impress
    sudo dnf install --assumeyes libreoffice-math
    sudo dnf install --assumeyes libreoffice-draw
    sudo dnf install --assumeyes libreoffice-langpack-pt-BR
    sudo dnf install --assumeyes libreoffice-langpack-en
    sudo dnf install --assumeyes unoconv

    # Instalando o File Roller
    sudo dnf install --assumeyes file-roller
    sudo dnf install --assumeyes file-roller-nautilus

    # Instalando a Impressora HP
    sudo dnf install --assumeyes hplip

    # Instalando o Suporte a arquivos 7zip
    sudo dnf install --assumeyes p7zip-plugins
    sudo dnf install --assumeyes p7zip

    # Instalando o KVM
    sudo dnf install --assumeyes qemu-kvm
    sudo dnf install --assumeyes libvirt

    # Instalando os Sistemas de arquivos não nativos do linux
    sudo dnf install --assumeyes ntfs-3g
    sudo dnf install --assumeyes exfat-utils
    sudo dnf install --assumeyes fuse
    sudo dnf install --assumeyes fuse-exfat

    # Instalando as Ferramentas de desenvolvimento
    sudo dnf install --assumeyes golang
    sudo dnf install --assumeyes gcc
    sudo dnf install --assumeyes gcc-c++
    sudo dnf install --assumeyes dotnet-sdk-5.0
    sudo dnf install --assumeyes aspnetcore-runtime-5.0
    sudo dnf install --assumeyes dotnet-runtime-5.0
    sudo dnf install --assumeyes git
    sudo dnf install --assumeyes git-lfs
    sudo dnf install --assumeyes android-tools
    sudo dnf install --assumeyes libstdc++-devel

    # Instalando outros programas
    sudo dnf install --assumeyes stacer
    sudo dnf install --assumeyes qt5-qtcharts
    sudo dnf install --assumeyes vlc
    sudo dnf install --assumeyes qt5-qtsvg
    sudo dnf install --assumeyes youtube-dl
    sudo dnf install --assumeyes snapd
    sudo dnf install --assumeyes flatpak
    sudo dnf install --assumeyes transmission
    sudo dnf install --assumeyes ffmpeg
    sudo dnf install --assumeyes steam
    sudo dnf install --assumeyes mokutil
    sudo dnf install --assumeyes fdupes
    sudo dnf install --assumeyes dconf-editor
    sudo dnf install --assumeyes gimp
    sudo dnf install --assumeyes gedit
    sudo dnf install --assumeyes ImageMagick
    sudo dnf install --assumeyes wine.i686
    sudo dnf install --assumeyes pdftk-java
    sudo dnf install --assumeyes wol
    sudo dnf install --assumeyes brasero
    sudo dnf install --assumeyes nmap

    # Instalando leitores de epub
    sudo dnf install --assumeyes calibre
    sudo dnf install --assumeyes okular

    # Instalando pacotes para reportar erro automaticamente
    sudo dnf install --assumeyes abrt-desktop
    sudo dnf install --assumeyes abrt-java-connector

    # Desinstalando pacotes inúteis
    ## Extensões Gnome Shel
    sudo dnf autoremove --assumeyes gnome-shell-extension-background-logo
    sudo dnf autoremove --assumeyes gnome-shell-extension-window-list

    ## Configuração do Fedora para o Chrome
    sudo dnf autoremove --assumeyes fedora-chromium-config

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
      snap install skype --classic && break
    done
  }

  # Instala pacotes flatpak
  function instalar_pacotes_flatpak() {
    # Instalando o Flatpak
    bash ./Install-Flatpak.bash

    # Instalando o FlatHub
    bash ./Install-Flathub.bash

    # Instalando o Android Studio
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.google.AndroidStudio.flatpakref

    # Instalando o Audacity
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.audacityteam.Audacity.flatpakref

    # Instalando o RetroArch
    flatpak install --assumeyes https://flathub.org/repo/appstream/org.libretro.RetroArch.flatpakref

    # Instalando o Signal
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref
  }

  # Alterando o nome do computador
  hostnamectl set-hostname --static henrique-pc
  hostnamectl set-hostname --pretty HENRIQUE-PC

  # Instalando o Google Chrome
  bash ./Install-GoogleChromeStable.bash

  # Instalando o Visual Studio Code
  bash ./Install-VisualStudioCode.bash

  # Instalando o PowerShell
  bash ./Install-PowerShell.bash

  # Instalando pacotes dnf
  instalar_pacotes_dnf

  # Instalando Java
  bash ./Install-Java_8_Gui.bash
  bash ./Install-Java_20_Gui.bash
  bash ./Install-Java_20_Devel.bash

  # Instalando pacotes snap
  instalar_pacotes_snap

  # Instalando pacotes flatpak
  instalar_pacotes_flatpak

  # Atualizando todos os pacotes instalados
  bash ./Update-All.bash

  # Instalando o Docker
  bash ./Install-DockerDesktop.bash

  # Instalando o VirtualBox
  bash ./Install-VirtualBox.bash

  # Instalando o Peazip
  bash ./Install-Peazip.bash

  # Instalando script Update-All.bash
  instalar_script_update_all

  # Instalando script Wait-ForPidToShutdown.bash
  instalar_script_wait_for_pid_to_shutdown

  # Instalando GitHub Cli
  bash ./Install-GithubCli.bash
}

# Configurando o Gnome Shell
bash ./Configurar-GnomeShell.bash

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.bash

# Instalando programas como root
sudo bash -c "$(declare -f run_as_root); run_as_root"
