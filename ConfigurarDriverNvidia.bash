#!/bin/bash

# Importando função run_as_root
source RunAsRoot.bash

# Executando como root
run_as_root

# Habilitando serviços Nvidia
systemctl enable nvidia-suspend.service
systemctl enable nvidia-hibernate.service
systemctl enable nvidia-resume.service

# Configurando a preservação de memória
if ! grep -q "options nvidia NVreg_PreserveVideoMemoryAllocations=1" "/etc/modprobe.d/nvidia-power-management.conf"; then
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> "/etc/modprobe.d/nvidia-power-management.conf"
fi

# Configurando o Grub
GRUB_FILE="/etc/default/grub"
PARAM="nvidia.NVreg_PreserveVideoMemoryAllocations=1"
if ! grep -q "$PARAM" "$GRUB_FILE"; then
  # Realizando backup do Grub
  cp "$GRUB_FILE" "$GRUB_FILE.backup.$(date "+%d-%m-%Y_%H:%M:%S")"

  # Adicionando parâmetro
  sed -i "/^GRUB_CMDLINE_LINUX=/ s/\"$/ $PARAM\"/" "$GRUB_FILE"
fi

# Gerando grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg

