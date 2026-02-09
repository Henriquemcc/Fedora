#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Instalando requisitos
dnf install --assumeyes cargo

# Instalando programa que remapeia teclado
cargo install xremap --features gnome

# Copiando o binário para a pasta /usr/local/bin/
executable_file_path="/usr/local/bin/xremap"
cp /root/.cargo/bin/xremap "$executable_file_path"

# Configurando o remapeamento do teclado
keyboard_mapper_file="/etc/xremap/keyboard.yml"
mkdir -p "$(dirname $keyboard_mapper_file)"
if ! [ -f "$keyboard_mapper_file" ]; then
  {
    echo "modmap:"
    echo "  - name: Left Key replacement"
    echo "    remap:"
    echo "      KEY_RIGHTALT: KEY_LEFT"
  } > "$keyboard_mapper_file"
fi

# Criando serviço no Systemd
service_name="remapear-teclado.service"
service_file_path="/etc/systemd/system/${service_name}"
{
  echo "[Unit]"
  echo "Description=Remapeamento do teclado utilizando o xremap"
  echo ""
  echo "[Service]"
  echo "Type=simple"
  echo "ExecStart=${executable_file_path} ${keyboard_mapper_file}"
  echo "Restart=on-failure"
  echo "[Install]"
} > "$service_file_path"

# Recarregando systemd para reconhecer o novo serviço
systemctl daemon-reload

# Criando uma política no SELinux
policy_directory="/tmp/selinux/xremap"
mkdir -p "$policy_directory"
{
  echo
  echo "module xremap_policy 1.0;"
  echo
  echo "require {"
  echo "	type admin_home_t;"
  echo "	type init_t;"
  echo "	type event_device_t;"
  echo "	class file { execute execute_no_trans map open read };"
  echo "	class chr_file open;"
  echo "}"
  echo
  echo "  #============= init_t =============="
  echo "allow init_t admin_home_t:file { execute execute_no_trans open read };"
  echo
  echo "#!!!! This avc can be allowed using the boolean 'domain_can_mmap_files'"
  echo "allow init_t admin_home_t:file map;"
  echo "allow init_t event_device_t:chr_file open;"
} > "$policy_directory/xremap_policy.te"

# Compilando a política SELinux
cd "$policy_directory" || exit 1
make -f /usr/share/selinux/devel/Makefile xremap_policy.pp

# Instalando política SELinux
semodule -i xremap_policy.pp