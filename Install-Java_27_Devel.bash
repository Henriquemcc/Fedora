#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_27_Headless.bash

# Checking if Java compiler 27 is installed
if [ "$(command -v javac27)" ]; then
    exit 0
fi

# Installing Java 27 JDK
dnf install --assumeyes java-27-openjdk-devel

# Creating command javac27
ln --symbolic "/usr/lib/jvm/java-27/bin/javac" "/bin/javac27"
