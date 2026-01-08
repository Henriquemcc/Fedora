#!/bin/bash

# Importing function run_as_root, get_os_type and install_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Enabling Fedora Epel
bash Enable-FedoraEpel.bash

# Installing RPM Fusion
if [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "almalinux" ] || [ "$(get_os_type)" == "ol" ]; then
  dnf install --assumeyes --nogpgcheck "https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-$(rpm -E %rhel).noarch.rpm"
  dnf install --assumeyes --nogpgcheck "https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-$(rpm -E %rhel).noarch.rpm"
elif [ "$(get_os_type)" == "fedora" ]; then
  install_rpm_package "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
  install_rpm_package "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
fi
install_rpm_package rpmfusion-free-release-tainted
install_rpm_package rpmfusion-nonfree-release-tainted

# Using openh264 library
if [ "$(get_os_type)" == "fedora" ]; then
  if [ "$(command -v dnf4)" ]; then
    dnf4 config-manager --enable --assumeyes fedora-cisco-openh264
  elif [ "$(command -v dnf)" ]; then
    dnf config-manager --enable --assumeyes fedora-cisco-openh264
  else
    sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/fedora-cisco-openh264.repo
  fi
fi

# Applying update on Fedora Silverblue
if [ "$(command -v rpm-ostree)" ]; then
  rpm-ostree apply-live
fi