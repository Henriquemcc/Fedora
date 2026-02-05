#!/bin/bash

# Importando funções de suporte (necessário estarem no mesmo diretório)
source RunAsRoot.bash

function sign_nvidia_modules() {
  # Verifica se o Secure Boot está ativo
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Caminhos definidos nos seus scripts anteriores [cite: 8]
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Localização do binário de assinatura do kernel no Fedora
    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"

    # Busca o diretório onde os módulos nvidia foram instalados
    # No Fedora com akmod, eles geralmente ficam em /lib/modules/$(uname -r)/extra/nvidia/
    nvidia_module_path=$(dirname "$(modinfo -n nvidia 2>/dev/null)")

    if [ -z "$nvidia_module_path" ]; then
        echo "Erro: Módulos Nvidia não encontrados. Certifique-se de que o akmod-nvidia terminou a compilação."
        return 1
    fi

    echo "Assinando módulos em: $nvidia_module_path"

    # Itera sobre os módulos (nvidia, nvidia-modeset, nvidia-uvm, nvidia-drm)
    for module in "$nvidia_module_path"/*.ko*; do

      # Lógica para arquivos compactados (.xz), similar ao seu script do VirtualBox
      if [[ "$module" == *.xz ]]; then
        echo "Descompactando e assinando: $module"
        xz --decompress --keep "$module"
        module_decompressed="${module::-3}"

        command_to_sign="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$module_decompressed\""
        eval "$command_to_sign" [cite: 4, 5]

        # Opcional: Recompactar ou remover o .xz antigo para o kernel carregar o .ko assinado
        rm "$module"
        xz "$module_decompressed"

      # Lógica para arquivos .ko diretos [cite: 5]
      elif [[ "$module" == *.ko ]]; then
        echo "Assinando: $module"
        command_to_sign="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$module\""
        eval "$command_to_sign" [cite: 5]
      fi
    done

    echo "Assinatura concluída. Carregando módulos..."
    modprobe nvidia
  fi
}

# Garante execução como root [cite: 12]
run_as_root

# Executa a função de assinatura
sign_nvidia_modules

# Rebuild opcional para garantir que o akmods reconheça as mudanças
akmods --force