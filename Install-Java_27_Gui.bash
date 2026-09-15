#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_27_Headless.bash

# Installing Java 27 JRE and JDK
dnf install --assumeyes java-latest-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 27"
  echo "GenericName=Java 27"
  echo "Icon=java-27-openjdk"
  echo "Exec=java27 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 27; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java27.desktop"
