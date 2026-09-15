#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_25_Headless.bash

# Checking if Java compiler 25 is installed
if [ "$(command -v javac25)" ]; then
    exit 0
fi

# Installing Java 25 JDK
dnf install --assumeyes java-25-openjdk-devel

# Creating command javac25
ln --symbolic "/usr/lib/jvm/java-25/bin/javac" "/bin/javac25"
