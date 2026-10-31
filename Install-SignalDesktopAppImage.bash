#!/bin/bash

# Variables
appimage_download_url="https://updates.signal.org/desktop/signal-desktop.AppImage"
signing_key_url="https://updates.signal.org/static/desktop/appimage.asc"
gpg_key_url="https://updates.signal.org/desktop/signal-desktop.AppImage.gpg"
icon_url="https://signal.org/brand/bundles/Signal%20Logo.zip"
work_directory="/tmp/Signal_Desktop"
installation_directory="$HOME/.bin"

# Creating work directory
mkdir -p "$work_directory"

# Downloading AppImage file if it does not exist
appimage_filename="${appimage_download_url##*/}"
appimage_download_path="$work_directory/$appimage_filename"
if ! [ -f "$appimage_download_path" ]; then
    curl -L "$appimage_download_url" --output "$appimage_download_path"
fi

# Downloading signing key if it does not exist
signing_key_filename="${signing_key_url##*/}"
signing_key_download_path="$work_directory/$signing_key_filename"
if ! [ -f "$signing_key_download_path" ]; then
    curl -L "$signing_key_url" --output "$signing_key_download_path"
fi

# Downloading GPG key if it does not exist
gpg_key_filename="${gpg_key_url##*/}"
gpg_key_download_path="$work_directory/$gpg_key_filename"
if ! [ -f "$gpg_key_download_path" ]; then
    curl -L "$gpg_key_url" --output "$gpg_key_download_path"
fi

# Checking AppImage file signature
gpg --import "$signing_key_download_path" || exit 1
gpg --verify "$gpg_key_download_path" "$appimage_download_path" || exit 1

# Copying AppImage to installation directory
mkdir -p "$installation_directory"
cp "$appimage_download_path" "$installation_directory/signal-desktop.AppImage"

# Setting executable permission for AppImage
chmod +x "$installation_directory/signal-desktop.AppImage"

# Downloading icon if it does not exist
icon_filename="${icon_url##*/}"
icon_download_path="$work_directory/$icon_filename"
if ! [ -f "$icon_download_path" ]; then
    curl -L "$icon_url" --output "$icon_download_path"
fi

# Extracting icon
icon_extraction_dir_path="$work_directory/extracted_icon"
mkdir -p "$icon_extraction_dir_path"
unzip -o "$icon_download_path" -d "$icon_extraction_dir_path"

# Copying icon to local share icons directory
icon_destination_dir="$HOME/.local/share/icons/hicolor/2160x2160/apps"
mkdir -p "$icon_destination_dir"
cp "$icon_extraction_dir_path/Logo on Background/PNG/Signal-Logo-Ultramarine_on_White.png" "$icon_destination_dir/Signal-Logo.png"

# Creating .desktop file
desktop_file="$HOME/.local/share/applications/SignalDesktop.desktop"
if ! [ -f "$desktop_file" ]; then
    {
        echo "[Desktop Entry]"
        echo "Name=Signal Desktop"
        echo "Type=Application"
        echo "Categories=Network;InstantMessaging;"
        echo "Exec=\"$installation_directory/signal-desktop.AppImage\" %U"
        echo "Icon=$icon_destination_dir/Signal-Logo.png"
        echo "Terminal=false"
        echo "StartupNotify=true"
    } > "$desktop_file"
fi