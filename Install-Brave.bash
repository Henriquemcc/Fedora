#!/bin/bash

# Installs Brave uising DNF Package Manager
function dnf_installation_brave() {
  # Installing requirements
  dnf --assumeyes install dnf-plugins-core

  # Installing Brave Browser
  if [ "$(command -v dnf4)" ]; then
    dnf4 --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  else
    dnf --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  fi

  rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
  dnf --assumeyes install brave-browser
}

# Importing function run_as_root
source RunAsRoot.bash

if [ "$(command -v dnf)" ]; then
  # Running as root
  run_as_root

  # Installing Brave
  dnf_installation_brave
elif [ "$(command -v toolbox)" ]; then
  toolbox create --distro fedora -c Brave
  toolbox run -c Brave sudo bash -c "$(declare -f dnf_installation_brave); dnf_installation_brave"
  toolbox run -c Brave cp /usr/share/applications/brave-browser.desktop ~/.local/share/applications/brave-browser.desktop
  sed -i 's|^Exec=|Exec=toolbox run -c Brave |g' ~/.local/share/applications/brave-browser.desktop
  mkdir -p ~/.local/share/icons
  toolbox run -c Brave find /usr/share/icons -name "brave-browser.png" -exec cp {} ~/.local/share/icons/ \;
  sed -i "s|^Icon=.*|Icon=$HOME/.local/share/icons/brave-browser.png|g" ~/.local/share/applications/brave-browser.desktop
fi