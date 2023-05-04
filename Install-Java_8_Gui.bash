#!/bin/bash

bash ./Install-Java_8_Headless.bash

# Installing Java 8 JRE and JDK
sudo dnf install --assumeyes java-1.8.0-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 8"
  echo "GenericName=Java 8"
  echo "Icon=java-1.8.0-openjdk"
  echo "Exec=java8 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 8; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java8.desktop"
