#!/bin/bash

if [ "$(command -v pwsh)" ] && { [ -z "$1" ] || [ "$1" != "--upgrade" ]; }; then
  exit 0
fi

# Defining Urls
url_arm64_tar_gz="https://github.com/PowerShell/PowerShell/releases/download/v7.2.4/powershell-7.2.4-linux-arm64.tar.gz"
url_arm32_tar_gz="https://github.com/PowerShell/PowerShell/releases/download/v7.2.4/powershell-7.2.4-linux-arm32.tar.gz"

# Downloads a file from a url
# @param $1 File url
# @return Downloaded file path
function Download_File
{
  # Defining temporary directory
  temp_dir="/tmp"

  # Creating temporary directory if it does not exist and setting its permission
  if ! [ -d $temp_dir ]; then
      sudo mkdir -p $temp_dir
      sudo chmod 776 $temp_dir
      sudo chmod +t $temp_dir
  fi

  # Defining file name
  file_name="$(basename "$1")"

  # Defining file path
  file_path="${temp_dir}/${file_name}"

  # Downloading file
  curl -L "$1" --output "$file_path"

  # Returning file path
  echo "$file_path"
}

function InstallPowerShell_On_Fedora_x86_64
{
  # Register the Microsoft signature key
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  
  # Getting version ID
  VERSION_ID="$(awk -F= '$1=="VERSION_ID" { print $2 ;}' /etc/os-release)"

  # Register the Microsoft RedHat repository
  curl "https://packages.microsoft.com/config/fedora/${VERSION_ID}/prod.repo" | sudo tee /etc/yum.repos.d/microsoft.repo

  # Update the list of products
  sudo dnf check-update

  # Install a system component
  sudo dnf install --assumeyes compat-openssl10

  # Install PowerShell
  sudo dnf install --assumeyes powershell-lts
}

function InstallPowerShell_On_Fedora_arm
{
  # Downloading file
  downloaded_file="$(Download_File "$1")"

  # Defining installation directory
  installation_directory="/usr/share/powershell"

  # Creating installation directory if it does not exist
  if ! [ -d $installation_directory ]; then
      sudo mkdir -p $installation_directory
  fi

  # Extracting downloaded file into installation directory
  sudo tar -xvf "$downloaded_file" --directory $installation_directory

  # Creating symbolic link
  sudo ln --symbolic "${installation_directory}/pwsh" /bin/pwsh

  # Changing file permission
  sudo chmod 777 /bin/pwsh
}

function InstallPowerShell_On_Fedora_arm32
{
    InstallPowerShell_On_Fedora_arm $url_arm32_tar_gz
}

function InstallPowerShell_On_Fedora_arm64
{
    InstallPowerShell_On_Fedora_arm $url_arm64_tar_gz
}

# x86_64
if [ "$(uname -m)" == "x86_64" ]; then
  InstallPowerShell_On_Fedora_x86_64

# Arm
elif [[ "$(uname -m)" == "aarch"* ]] || [[ "$(uname -m)" == "arm"* ]] ; then

    # 64 bits
    if [ "$(uname -m)" == "aarch64" ] || [ "$(uname -m)" == "arm64" ] || { [ "$(command -v getconf)" ] && [ "$(getconf LONG_BIT)" == 64 ]; } ; then
      InstallPowerShell_On_Fedora_arm64
    # 32 bits
    else
      InstallPowerShell_On_Fedora_arm32
    fi
fi
