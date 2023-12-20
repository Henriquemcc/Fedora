#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 9 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Configurar módulos do kernel"
    echo "2 - Instalar configuração padrão ao gerenciador de pacotes DNF"
    echo "3 - Instalar configuração padrão ao DNF Automatic"
    echo "4 - Configurar Wireguard"
    echo "5 - Configurar Systemd Resolved"
    echo "6 - Configurar sshd_config"
    echo "7 - Configurar Grub"
    echo "8 - Configurar NTP"
    echo "9 - Configurar Gnome Shell"
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
    bash ./ConfigurarModulosKernelLinux.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./ConfigurarDnfPackageManager.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./ConfigurarAtualizacoesAutomaticasDnfAutomatic.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    cd ./Wireguard || exit
    bash ./Wireguard.bash
    cd .. || exit
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./ConfigurarSystemdResolved.bash
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./ConfigurarSshdConfig.bash
  elif [ "$opcao_selecionada" -eq 7 ]; then
    bash ./ConfigurarGrub.bash
  elif [ "$opcao_selecionada" -eq 8 ]; then
    bash ./ConfigurarNtp.bash
  elif [ "$opcao_selecionada" -eq 9 ]; then
    bash ./ConfigurarGnomeShell.bash
  fi


done
