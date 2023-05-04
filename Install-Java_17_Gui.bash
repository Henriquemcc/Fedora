#!/bin/bash

bash ./Install-Java_17_Headless.bash

# Installing Java 17 JRE and JDK
sudo dnf install --assumeyes java-17-openjdk

# Creating shortcuts
{
  echo "[Desktop Entry]"
  echo "Type=Application"
  echo "Name=Java Runtime Environment 17"
  echo "GenericName=Java 17"
  echo "Icon=java-17-openjdk"
  echo "Exec=java17 -jar %f"
  echo "Terminal=false"
  echo "MimeType=application/x-java-archive"
  echo "Keywords=java; runtime; environment; 17; jre"
  echo "StartupNotify=true"
} | sudo tee "/usr/share/applications/java17.desktop"
