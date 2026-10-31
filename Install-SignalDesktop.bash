#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Instalando o FlatHub
bash ./Install-Flathub.bash

# Instalando o Signal
flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.signal.Signal.flatpakref

# Configurando o Signal para utilizar o Gnome Libsecret
flatpak override --env=SIGNAL_PASSWORD_STORE=gnome-libsecret org.signal.Signal