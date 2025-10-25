#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Fazendo backup do arquivo anterior
cp "/etc/docker/daemon.json" "/etc/docker/daemon.json.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

# Criando novo arquivo
{
  echo "{"
  echo "\"ipv6\": true"
  echo "}"
} > "/etc/docker/daemon.json"