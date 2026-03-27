#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing ClamUI
flatpak install -y https://dl.flathub.org/repo/appstream/io.github.linx_systems.ClamUI.flatpakref

# Installing Clamav
install_rpm_package clamav clamd

# Backing up configuration file
cp /etc/clamd.d/scan.conf /etc/clamd.d/scan.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")

# Configuring Clamav
{
    echo "LocalSocket /run/clamd.scan/clamd.sock"
    echo "LocalSocketGroup virusgroup"
    echo "LocalSocketMode 660"
} > "/etc/clamd.d/scan.conf"

# Creating usergroup virusgroup
gpasswd -a "$SUDO_USER" virusgroup

# Enabling Clamav
systemctl enable clamd@scan
systemctl start clamd@scan