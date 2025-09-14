#!/bin/bash

minecraft_file_url="https://launcher.mojang.com/download/Minecraft.tar.gz"
temporary_directory="/tmp"
installation_directory="${HOME}/.bin"
minecraft_binary_file_name="minecraft-launcher"
applications_folder="${HOME}/.local/share/applications"
minecraft_picture_url="https://imagepng.org/wp-content/uploads/2017/08/minecraft-icone-icon.png"
icons_directory="${HOME}/.local/share/icons/hicolor/303x303/apps"
user_agent="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.51 Safari/537.36"

# Creating directories
mkdir -p "$temporary_directory"
mkdir -p "$applications_folder"
mkdir -p "$icons_directory"
mkdir -p "$installation_directory"

# Downloads a file from the internet.
# @param $1 File url
# @return Downloaded file path
function download_file {
  # Defining file name
  file_name="$(basename "$1")"

  # Defining destination path
  file_path="${temporary_directory}/${file_name}"

  # Erasing file if it exists
  if [ -f "$file_path" ]; then
    rm "$file_path"
  fi

  # Downloading file
  curl -L "$1" --output "$file_path"

  # Returning file path
  echo "$file_path"
}

# Creates a shortcut.
# @param $1 Executable path
# @param $2 Icon path
# @param $3 Shortcut path
function create_shortcut {
  {
    echo "[Desktop Entry]"
    echo "Version=1.5"
    echo "Name=Minecraft"
    echo "Type=Application"
    echo "Exec=$1"
    echo "Icon=$2"
    echo "StartupNotify=true"
    echo "Categories=Game;"
  } >"$3"

}

# Installing requirements
bash ./Install-Curl.bash
bash ./Install-Tar.bash
bash ./Install-Xrandr.bash
bash ./Install-Java_21_Gui.bash

if ! [ -f "${installation_directory}/${minecraft_binary_file_name}" ]; then

  # Downloading file
  downloaded_tar_gz_file="$(download_file $minecraft_file_url)"

  # Extracting Minecraft binary
  tar -C "$temporary_directory" -xzvf "$downloaded_tar_gz_file"

  # Moving binary file to ~/.bin
  extracted_minecraft_binary_path="${temporary_directory}/minecraft-launcher/${minecraft_binary_file_name}"
  minecraft_binary_path="${installation_directory}/minecraft-launcher"
  mv "$extracted_minecraft_binary_path" "$minecraft_binary_path"

  # Creating icon directory if it does not exist
  mkdir -p "$icons_directory"

  # Defining Minecraft icon path
  minecraft_icon_path="${icons_directory}/minecraft.png"

  # Downloading icon
  curl -L --user-agent "Mozilla/5.0 (X11; Fedora; Linux x86_64; rv:95.0) Gecko/20100101 Firefox/95.0" "$minecraft_picture_url" >"$minecraft_icon_path"

  # Defining Minecraft shortcut file path
  minecraft_shortcut_path="${applications_folder}/Minecraft.desktop"

  # Creating shortcut
  create_shortcut "$minecraft_binary_path" "$minecraft_icon_path" "$minecraft_shortcut_path"
fi
