#!/bin/bash

# Importing functions run_as_root, get_os_type and install_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Exiting if the operating system is not Red Hat or CentoOS
if [ "$(get_os_type)" != "rhel" ] && [ "$(get_os_type)" != "centos" ] && [ "$(get_os_type)" != "almalinux" ]&& [ "$(get_os_type)" != "ol" ]; then
  echo "This script is only for Red Hat, CentOS, Almalinux or Oracle Linux."
  exit 1
fi

# Running as root
run_as_root

# Installing Fedora Epel
install_rpm_package --nogpgcheck "https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(rpm -E %rhel).noarch.rpm"
