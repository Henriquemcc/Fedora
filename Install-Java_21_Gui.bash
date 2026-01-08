#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_21_Headless.bash

# Installing Java 21 JRE and JDK
install_rpm_package java-21-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 21"
  echo "GenericName=Java 21"
  echo "Icon=java-21-openjdk"
  echo "Exec=java21 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 21; jre"
  echo "StartupNotify=true"
} | tee "/usr/share/applications/java21.desktop"
