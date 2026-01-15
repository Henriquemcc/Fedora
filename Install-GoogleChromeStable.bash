#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Installing on Fedora, RHEL, CentOS, AlmaLinux or OracleLinux
if [ "$(command -v dnf)" ]; then
    # Running as root
    run_as_root

    # Installing Google Chrome Stable
    dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

# Installing on Fedora SilverBlue
elif [ "$(command -v toolbox)" ]; then
    toolbox create --distro fedora -c Google
    toolbox run -c Google sudo dnf install --assumeyes https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    toolbox run -c Google cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/google-chrome.desktop
    sed -i 's|^Exec=|Exec=toolbox run -c Google |g' ~/.local/share/applications/google-chrome.desktop
    mkdir -p ~/.local/share/icons
    toolbox run -c Google find /usr/share/icons -name "google-chrome.png" -exec cp {} ~/.local/share/icons/ \;
    sed -i "s|^Icon=.*|Icon=$HOME/.local/share/icons/google-chrome.png|g" ~/.local/share/applications/google-chrome.desktop
fi