#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 3 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Adicionar módulos do driver da NVIDIA (Repositório Oficial) ao Kernel Linux"
    echo "2 - Adicionar módulos do driver da NVIDIA (RPM Fusion) ao Kernel Linux"
    echo "3 - Adicionar módulos do VirtualBox ao Kernel Linux"
    read -r _opcao_selecionada
  done

  function_return_variable="$_opcao_selecionada"
}

opcao_selecionada=-1
while [ $opcao_selecionada -ne 0 ]; do

  # Obtendo opção selecionada pelo usuário
  obter_opcao
  opcao_selecionada="$function_return_variable"

  if [ "$opcao_selecionada" -eq 1 ]; then
    bash ./Install-NvidiaDriver.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Sign-Nvidia.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Sign-VirtualBox.bash
  fi
done


