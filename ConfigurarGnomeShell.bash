#!/bin/bash

# Verificando se o Gnome Shell está instalado
if ! [ "$(command -v gnome-shell)" ]; then
  exit 0
fi

# Instalando extensões e apps
source ./RpmPackageManager.bash
pacotes_a_serem_instalados=()
pacotes_a_serem_instalados+=("gnome-extensions-app")
pacotes_a_serem_instalados+=("chrome-gnome-shell")
pacotes_a_serem_instalados+=("gnome-tweaks")
pacotes_a_serem_instalados+=("gnome-shell-extension-dash-to-dock")
pacotes_a_serem_instalados+=("gnome-shell-extension-top-icons")
pacotes_a_serem_instalados+=("gnome-shell-extension-caffeine")
install_rpm_packages pacotes_a_serem_instalados

# Desabilitando hot corners
gsettings set org.gnome.desktop.interface enable-hot-corners false

# Mostrar segundos
gsettings set org.gnome.desktop.interface clock-show-seconds true

# Mostrar dia da semana
gsettings set org.gnome.desktop.interface clock-show-weekday true

# Mostrar porcentagem da bateria
gsettings set org.gnome.desktop.interface show-battery-percentage true

# Habilitar atualização de fuso horário
gsettings set org.gnome.desktop.datetime automatic-timezone true

# Desabilitar autorun
gsettings set org.gnome.desktop.media-handling autorun-never true

# Habilitando botões minimizar e maximizar
gsettings set org.gnome.desktop.wm.preferences button-layout "appmenu:minimize,maximize,close"

# Habilitando icones na área de trabalho
gsettings set org.gnome.desktop.background show-desktop-icons true

# Habilitando localização automatica gnome shell weather
gsettings set org.gnome.shell.weather automatic-location true

# Habilitando o Fractional scaling
gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"

# Instalando e Habilitando Dash to Dock
gnome-extensions install dash-to-dock@micxgx.gmail.com
gnome-extensions enable dash-to-dock@micxgx.gmail.com

# Instalando e Habilitando o Bing Wallpaper
gnome-extensions install BingWallpaper@ineffable-gmail.com
gnome-extensions enable BingWallpaper@ineffable-gmail.com

# Instalando e Habilitando o gnome-shell-extension-appindicator
gnome-extensions install top-icons@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable top-icons@gnome-shell-extensions.gcampax.github.com

# Instalando e Habilitando o gnome-shell-extension-caffeine
gnome-extensions install caffeine@patapon.info
gnome-extensions enable caffeine@patapon.info
