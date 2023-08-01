#!/bin/bash

version="v0.0.1"
jar_url="https://github.com/Henriquemcc/Dynamic_DNS_Update_Client/releases/download/${version}/app.jar"
jar_download_destination="/usr/bin/Dynamic_Dns_Update_Client.jar"
service_name="dynamic-dns-update-client.service"
service_file_path="/etc/systemd/system/${service_name}"

# Runs this script as root if it is not root.
function run_as_root() {
  if [ "$(whoami)" != "root" ]; then
    echo "This script is not running as root"
    echo "Elevating privileges..."
    if [ "$(command -v sudo)" ]; then
      sudo bash "$0"
      exit $?
    else
      echo "Sudo is not installed"
      exit 1
    fi
  fi
}

# Running as root
run_as_root

# Installing requirements
if ! [ "$(command -v java)" ]; then
    bash ./Install-Java_20_Headless.bash
fi

# Downloading JAR File
curl -L "$jar_url" -o "$jar_download_destination"

# Changing permission for the downloaded file
chmod +x "$jar_download_destination"

# Creating system service
{
  echo "[Unit]"
  echo "Description=Dynamic dns update client service"
  echo "After=network.target"
  echo "StartLimitIntervalSec=0"
  echo ""
  echo "[Service]"
  echo "Type=simple"
  echo "Restart=always"
  echo "RestartSec=1"
  echo "User=root"
  echo "ExecStart=/usr/bin/java -jar ${jar_download_destination} perform-ip-update -i"
  echo "[Install]"
  echo "WantedBy=multi-user.target"
} > "$service_file_path"

# Enabling System Service
systemctl enable --now "$service_name"

