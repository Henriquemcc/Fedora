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

    # Instalando o driver da Nvidia
    bash ./Install-NvidiaDriverRpmFusion.bash

    # Trocando o pacote ffmpeg-free por ffmpeg
    dnf swap --assumeyes --allowerasing ffmpeg-free ffmpeg

    # Array de pacotes RPM
    pacotes_rpm_a_serem_instalados=()
    pacotes_rpm_a_serem_removidos=()

    # Instalando o KeepassXC
    pacotes_rpm_a_serem_instalados+=("keepassxc")

    # Instalando o Libreoffice
    pacotes_rpm_a_serem_instalados+=("libreoffice-writer")
    pacotes_rpm_a_serem_instalados+=("libreoffice-calc")
    pacotes_rpm_a_serem_instalados+=("libreoffice-impress")
    pacotes_rpm_a_serem_instalados+=("libreoffice-math")
    pacotes_rpm_a_serem_instalados+=("libreoffice-draw")
    pacotes_rpm_a_serem_instalados+=("libreoffice-langpack-pt-BR")
    pacotes_rpm_a_serem_instalados+=("libreoffice-langpack-en")
    pacotes_rpm_a_serem_instalados+=("unoconv")

    # Instalando o Gnome Epiphany
    pacotes_rpm_a_serem_instalados+=("epiphany")

    # Instalando o File Roller
    pacotes_rpm_a_serem_instalados+=("file-roller")
    pacotes_rpm_a_serem_instalados+=("file-roller-nautilus")

    # Instalando a Impressora HP
    pacotes_rpm_a_serem_instalados+=("hplip")

    # Instalando o Suporte a arquivos 7zip
    pacotes_rpm_a_serem_instalados+=("p7zip-plugins")
    pacotes_rpm_a_serem_instalados+=("p7zip")

    # Instalando o KVM
    pacotes_rpm_a_serem_instalados+=("qemu-kvm")
    pacotes_rpm_a_serem_instalados+=("libvirt")

    # Instalando os Sistemas de arquivos não nativos do linux
    # pacotes_rpm_a_serem_instalados+=("ntfs-3g") # Usando Enable-Ntfs no lugar
    # pacotes_rpm_a_serem_instalados+=("exfat-utils")
    pacotes_rpm_a_serem_instalados+=("fuse")
    # pacotes_rpm_a_serem_instalados+=("fuse-exfat") # Usando Enable-ExFat no lugar

    # Instalando as Ferramentas de desenvolvimento
    pacotes_rpm_a_serem_instalados+=("golang")
    pacotes_rpm_a_serem_instalados+=("gcc")
    pacotes_rpm_a_serem_instalados+=("gcc-c++")
    pacotes_rpm_a_serem_instalados+=("dotnet-sdk-5.0")
    pacotes_rpm_a_serem_instalados+=("aspnetcore-runtime-5.0")
    pacotes_rpm_a_serem_instalados+=("dotnet-runtime-5.0")
    pacotes_rpm_a_serem_instalados+=("git")
    pacotes_rpm_a_serem_instalados+=("git-lfs")
    pacotes_rpm_a_serem_instalados+=("android-tools")
    pacotes_rpm_a_serem_instalados+=("libstdc++-devel")
    pacotes_rpm_a_serem_instalados+=("perf")
    pacotes_rpm_a_serem_instalados+=("python3-pip")

    # Instalando outros programas
    pacotes_rpm_a_serem_instalados+=("stacer")
    pacotes_rpm_a_serem_instalados+=("qt5-qtcharts")
    pacotes_rpm_a_serem_instalados+=("vlc")
    pacotes_rpm_a_serem_instalados+=("libdvdcss") # Não disponível no CentOS ou RHEL
    pacotes_rpm_a_serem_instalados+=("qt5-qtsvg")
    pacotes_rpm_a_serem_instalados+=("youtube-dl")
    pacotes_rpm_a_serem_instalados+=("yt-dlp")
    pacotes_rpm_a_serem_instalados+=("snapd")
    pacotes_rpm_a_serem_instalados+=("flatpak")
    pacotes_rpm_a_serem_instalados+=("qbittorrent")
    pacotes_rpm_a_serem_instalados+=("ffmpeg")
    pacotes_rpm_a_serem_instalados+=("steam")
    pacotes_rpm_a_serem_instalados+=("mokutil")
    pacotes_rpm_a_serem_instalados+=("fdupes")
    pacotes_rpm_a_serem_instalados+=("dconf-editor")
    pacotes_rpm_a_serem_instalados+=("gimp")
    pacotes_rpm_a_serem_instalados+=("gedit")
    pacotes_rpm_a_serem_instalados+=("ImageMagick")
    pacotes_rpm_a_serem_instalados+=("pdftk-java")
    pacotes_rpm_a_serem_instalados+=("wol")
    pacotes_rpm_a_serem_instalados+=("brasero")
    pacotes_rpm_a_serem_instalados+=("nmap")
    pacotes_rpm_a_serem_instalados+=("rclone")
    pacotes_rpm_a_serem_instalados+=("wireshark")

    # Instalando leitores de epub
    pacotes_rpm_a_serem_instalados+=("calibre")
    pacotes_rpm_a_serem_instalados+=("okular")

    # Instalando pacotes para reportar erro automaticamente
    pacotes_rpm_a_serem_instalados+=("abrt-desktop")
    pacotes_rpm_a_serem_instalados+=("abrt-java-connector")

    # Instalando ferramentas de segurança
    pacotes_rpm_a_serem_instalados+=("chkrootkit")
    pacotes_rpm_a_serem_instalados+=("lynis")

    # Instalando xorg
    pacotes_rpm_a_serem_instalados+=("xorg-x11-server-Xorg")
    pacotes_rpm_a_serem_instalados+=("xorg-x11-xauth")

    # Instalando o Draw.io
    pacotes_rpm_a_serem_instalados+=("https://github.com/jgraph/drawio-desktop/releases/download/v26.2.15/drawio-x86_64-26.2.15.rpm")

    # Desinstalando pacotes inúteis
    ## Extensões Gnome Shell
    pacotes_rpm_a_serem_removidos+=("gnome-shell-extension-background-logo")
    pacotes_rpm_a_serem_removidos+=("gnome-shell-extension-window-list")

    # Realizando instalações
    install_rpm_packages pacotes_rpm_a_serem_instalados

    # Realizando desinstalações
    uninstall_rpm_packages pacotes_rpm_a_serem_removidos
  }

  # Instala pacotes snap
  function instalar_pacotes_snap() {

    # Obtendo funções install_snap_packages e uninstall_snap_packages
    source SnapPackageManager.bash

    # Instalando snapd
    bash ./Install-Snapd.bash

    # Array de pacotes snap
    pacotes_snap_a_serem_instalados=()

    # Instalando pacotes snap
    pacotes_snap_a_serem_instalados+=("spotify")
    pacotes_snap_a_serem_instalados+=("intellij-idea-community --classic")
    pacotes_snap_a_serem_instalados+=("pycharm-community --classic")
    pacotes_snap_a_serem_instalados+=("clion --classic")
    pacotes_snap_a_serem_instalados+=("flutter --classic")
    pacotes_snap_a_serem_instalados+=("kotlin --classic")
    pacotes_snap_a_serem_instalados+=("postman")
    pacotes_snap_a_serem_instalados+=("webstorm --classic")

    # Instalando pacotes snap
    install_snap_packages pacotes_snap_a_serem_instalados
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

  # Adicionando suporte ao NTFS e ao Ex-Fat (de preferência por módulo do Kernel)
  bash ./Enable-Ntfs.bash
  bash ./Enable-ExFat.bash

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
  sudo bash -c "$(declare -f run_as_root); run_as_root"
fi
