#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_21_Headless.bash

# Checking if Java compiler 21 is installed
if [ "$(command -v javac21)" ]; then
    exit 0
fi

# Installing Java 21 JDK
install_rpm_package java-21-openjdk-devel

# Creating command javac20
ln --symbolic "/usr/lib/jvm/java-21/bin/javac" "/bin/javac21"
