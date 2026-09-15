#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_25_Headless.bash

# Installing Java 25 JRE and JDK
dnf install --assumeyes java-25-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 25"
  echo "GenericName=Java 25"
  echo "Icon=java-25-openjdk"
  echo "Exec=java25 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 25; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java25.desktop"
