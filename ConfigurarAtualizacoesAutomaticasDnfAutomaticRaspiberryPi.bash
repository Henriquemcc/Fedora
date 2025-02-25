#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Dnf Automatic
dnf install --assumeyes dnf-automatic

# Backing up configuration file
cp "/etc/dnf/automatic.conf" "/etc/dnf/automatic.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Generating Dnf Automatic Configuration File
{
  echo "[commands]"
  echo "upgrade_type = default"
  echo "random_sleep = 0"
  echo "network_online_timeout = 60"
  echo "download_updates = yes"
  echo "reboot = when-changed"
  echo "apply_updates = yes"
  echo "[emitters]"
  echo "emit_via = stdio"
  echo "[email]"
  echo "email_from = root@example.com"
  echo "email_to = root"
  echo "email_host = localhost"
  echo "[command]"
  echo "[command_email]"
  echo "email_from = root@example.com"
  echo "email_to = root"
  echo "[base]"
  echo "debuglevel = 1"
} > "/etc/dnf/automatic.conf"

# Enabling Dnf Automatic services
systemctl enable --now dnf-automatic.timer
systemctl enable --now dnf-automatic-install.timer
systemctl enable --now dnf-automatic-download.timer
