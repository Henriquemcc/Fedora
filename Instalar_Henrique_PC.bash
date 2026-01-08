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

    # Trocando o pacote ffmpeg-free por ffmpeg
    dnf swap --assumeyes --allowerasing ffmpeg-free ffmpeg

    # Array de pacotes RPM
    pacotes_a_serem_instalados=()
    pacotes_a_serem_removidos=()

    # Instalando o KeepassXC
    pacotes_a_serem_instalados+=("keepassxc")

    # Instalando o Libreoffice
    pacotes_a_serem_instalados+=("libreoffice-writer")
    pacotes_a_serem_instalados+=("libreoffice-calc")
    pacotes_a_serem_instalados+=("libreoffice-impress")
    pacotes_a_serem_instalados+=("libreoffice-math")
    pacotes_a_serem_instalados+=("libreoffice-draw")
    pacotes_a_serem_instalados+=("libreoffice-langpack-pt-BR")
    pacotes_a_serem_instalados+=("libreoffice-langpack-en")
    pacotes_a_serem_instalados+=("libreoffice-langpack-fr")
    pacotes_a_serem_instalados+=("unoconv")

    # Instalando o File Roller
    pacotes_a_serem_instalados+=("file-roller")
    pacotes_a_serem_instalados+=("file-roller-nautilus")

    # Instalando a Impressora HP
    pacotes_a_serem_instalados+=("hplip")

    # Instalando o Suporte a arquivos 7zip
    pacotes_a_serem_instalados+=("p7zip-plugins")
    pacotes_a_serem_instalados+=("p7zip")

    # Instalando o KVM
    pacotes_a_serem_instalados+=("qemu-kvm")
    pacotes_a_serem_instalados+=("libvirt")

    # Instalando os Sistemas de arquivos não nativos do linux
    # pacotes_a_serem_instalados+=("ntfs-3g") # Usando Enable-Ntfs no lugar
    # pacotes_a_serem_instalados+=("exfat-utils")
    pacotes_a_serem_instalados+=("fuse")
    # pacotes_a_serem_instalados+=("fuse-exfat") # Usando Enable-ExFat no lugar

    # Instalando as Ferramentas de desenvolvimento
    pacotes_a_serem_instalados+=("golang")
    pacotes_a_serem_instalados+=("gcc")
    pacotes_a_serem_instalados+=("gcc-c++")
    pacotes_a_serem_instalados+=("dotnet-sdk-5.0")
    pacotes_a_serem_instalados+=("aspnetcore-runtime-5.0")
    pacotes_a_serem_instalados+=("dotnet-runtime-5.0")
    pacotes_a_serem_instalados+=("git")
    pacotes_a_serem_instalados+=("git-lfs")
    pacotes_a_serem_instalados+=("android-tools")
    pacotes_a_serem_instalados+=("libstdc++-devel")
    pacotes_a_serem_instalados+=("perf")
    pacotes_a_serem_instalados+=("python3-pip")
    pacotes_a_serem_instalados+=("python3-devel")

    # Instalando outros programas
    pacotes_a_serem_instalados+=("stacer")
    pacotes_a_serem_instalados+=("qt5-qtcharts")
    pacotes_a_serem_instalados+=("vlc")
    pacotes_a_serem_instalados+=("libdvdcss") # Não disponível no CentOS ou RHEL
    pacotes_a_serem_instalados+=("qt5-qtsvg")
    pacotes_a_serem_instalados+=("youtube-dl")
    pacotes_a_serem_instalados+=("yt-dlp")
    pacotes_a_serem_instalados+=("snapd")
    pacotes_a_serem_instalados+=("flatpak")
    pacotes_a_serem_instalados+=("qbittorrent")
    pacotes_a_serem_instalados+=("ffmpeg")
    pacotes_a_serem_instalados+=("steam")
    pacotes_a_serem_instalados+=("mokutil")
    pacotes_a_serem_instalados+=("fdupes")
    pacotes_a_serem_instalados+=("dconf-editor")
    pacotes_a_serem_instalados+=("gimp")
    pacotes_a_serem_instalados+=("gedit")
    pacotes_a_serem_instalados+=("ImageMagick")
    pacotes_a_serem_instalados+=("pdftk-java")
    pacotes_a_serem_instalados+=("wol")
    pacotes_a_serem_instalados+=("brasero")
    pacotes_a_serem_instalados+=("rclone")
    pacotes_a_serem_instalados+=("wireshark")
    pacotes_a_serem_instalados+=("sudo-rs")

    # Instalando leitores de epub
    pacotes_a_serem_instalados+=("calibre")
    pacotes_a_serem_instalados+=("okular")

    # Instalando ferramentas de segurança
    pacotes_a_serem_instalados+=("chkrootkit")
    pacotes_a_serem_instalados+=("lynis")

    # Instalando xorg
    pacotes_a_serem_instalados+=("xorg-x11-server-Xorg")
    pacotes_a_serem_instalados+=("xorg-x11-xauth")

    # Instalando o Draw.io
    pacotes_a_serem_instalados+=("https://github.com/jgraph/drawio-desktop/releases/download/v26.2.15/drawio-x86_64-26.2.15.rpm")

    # Desinstalando pacotes inúteis
    ## Extensões Gnome Shell
    pacotes_a_serem_removidos+=("gnome-shell-extension-background-logo")
    pacotes_a_serem_removidos+=("gnome-shell-extension-window-list")

    # Realizando instalações
    install_rpm_packages pacotes_a_serem_instalados

    # Realizando desinstalações
    uninstall_rpm_packages pacotes_a_serem_removidos
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
      snap install flutter --classic && break
    done

    while true; do
      snap install kotlin --classic && break
    done
    
    while true; do
      snap install postman && break
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

    # Instalando o OnlyOffice
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.onlyoffice.desktopeditors.flatpakref

    # Instalando o Calibre
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/com.calibre_ebook.calibre.flatpakref

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

    # Instalando o Packet (Quick-Share)
    flatpak install --assumeyes https://dl.flathub.org/repo/appstream/io.github.nozwock.Packet.flatpakref
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
