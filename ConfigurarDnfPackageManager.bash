#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Verificando se o comando dnf existe
if ! [ "$(command -v dnf)" ]; then
    exit 1
fi

# Backing up configuration file
cp "/etc/dnf/dnf.conf" "/etc/dnf/dnf.conf.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

{
  echo "[main]"
  echo "gpgcheck=1"
  echo "installonly_limit=3"
  echo "clean_requirements_on_remove=True"
  echo "best=False"
  echo "skip_if_unavailable=True"

  # Keeping cached packages
  #echo "keepcache=True"

  # Using the fastest mirror
  echo "fastestmirror=True"
} > "/etc/dnf/dnf.conf"