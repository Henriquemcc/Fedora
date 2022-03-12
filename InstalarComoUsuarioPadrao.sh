#!/bin/bash

function configurar_gnome_shell() {
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
}

# Configurando o Gnome Shell
configurar_gnome_shell

# Instalando o Minecraft
bash ./Install-Minecraft.sh

# Instalando o TechnicLauncher
bash ./Install-TechnicLauncher.sh

# Instalando o Weka
bash ./Install-Weka.sh

# Instalando o Orange
bash ./Install-OrangeDataMining.sh