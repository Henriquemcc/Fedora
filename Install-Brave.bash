#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing requirements
install_rpm_package dnf-plugins-core

# Applying update on Fedora Silverblue
if [ "$(command -v rpm-ostree)" ]; then
  rpm-ostree apply-live
fi

# Installing Brave Browser
if [ "$(command -v dnf4)" ]; then
  dnf4 --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
elif [ "$(command -v dnf)" ]; then
  dnf --assumeyes config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
else
  curl -o /etc/yum.repos.d/brave-browser.repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
fi

rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
install_rpm_package install brave-browser
