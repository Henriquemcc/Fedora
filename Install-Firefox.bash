#!/bin/bash

# Importing functions run_as_root and uninstall_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Flatpak if it is not installed
if ! [ "$(command -v flatpak)" ]; then
    bash ./Install-Flatpak.bash
fi

# Installing firefox from flatpak
flatpak install --assumeyes https://dl.flathub.org/repo/appstream/org.mozilla.firefox.flatpakref

# Removing firefox from RPM
uninstall_rpm_package_system firefox

# Creating a script to link the old executable to the new executable
link_path="/bin/firefox"
{
  echo "#!/bin/bash"
  echo "flatpak run org.mozilla.firefox \$@"
} > "$link_path"
chmod +x "$link_path"