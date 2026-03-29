#!/bin/bash

# Variables
deb_download_url="https://archive.org/download/packettracer900/CiscoPacketTracer_900_Ubuntu_64bit.deb"
checksum="5a92952435fd4829eb9f84602e21328dcd47b9dc59265d7f84a4162d85f270c9628c800197464a07f79bdf9fe6b728721d91d87fe3255a07e19d7fe4d2069865"
work_directory="/tmp/Cisco_Packet_Tracer"
installation_directory="$HOME/.bin"

# Creating work directory
mkdir -p "$work_directory"

# Downloading .deb file if it does not exist
deb_filename="${deb_download_url##*/}"
deb_download_path="$work_directory/$deb_filename"
if ! [ -f "$deb_download_path" ]; then
  curl -L "$deb_download_url" --output "$deb_download_path"
fi

# Checking .deb file checksum
echo "$checksum $deb_download_path" | sha512sum -c || exit 1

# Creating extraction directory
deb_extraction_dir_path="$work_directory/extracted"
mkdir -p "$deb_extraction_dir_path"

# Extracting .deb file
previous_path=$(pwd)
cd "$deb_extraction_dir_path" || exit 1
ar x "$deb_download_path"
cd "$previous_path" || exit 1

# Creating data extraction dir
data_extraction_dir_path="$work_directory/extracted/data"
mkdir -p "$data_extraction_dir_path"

# Extracting .deb data
tar -xvf "$deb_extraction_dir_path/data.tar.xz" -C "$data_extraction_dir_path"

# Creating installation directory
mkdir -p "$installation_directory"

# Copying AppImage
cp "$data_extraction_dir_path/opt/pt/packettracer.AppImage" "$installation_directory/packettracer.AppImage"

# Creating .desktop files
{
  echo "[Desktop Entry]"
  echo "Name=Cisco Packet Tracer 9.0.0"
  echo "Type=Application"
  echo "Categories=Education"
  echo "Exec=\"$HOME/.bin/packettracer.AppImage\" %f"
  echo "Icon=Cisco_Packet_Tracer_9.0.0"
  echo "Terminal=true"
  echo "StartupNotify=true"
  echo "MimeType=application/x-pkt;application/x-pka;application/x-pkz;application/x-pks;application/x-pksz;"
} > "$HOME/.local/share/applications/CiscoPacketTracer-9.0.0.desktop"

{
  echo "[Desktop Entry]"
  echo "Name=Cisco Packet Tracer 9.0.0 (PTSA)"
  echo "Type=Application"
  echo "Categories=Education;"
  echo "Exec=\"$HOME/.bin/packettracer.AppImage\" -uri=%u"
  echo "Icon=Cisco_Packet_Tracer_9.0.0"
  echo "Terminal=true"
  echo "StartupNotify=true"
  echo "MimeType=x-scheme-handler/pttp;"
} > "$HOME/.local/share/applications/CiscoPacketTracerPtsa-9.0.0.desktop"
