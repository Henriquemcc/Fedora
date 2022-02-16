#!/bin/bash

#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 23 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Docker Engine"
    echo "2 - Driver Nvidia"
    echo "3 - FlatHub"
    echo "4 - Flatpak"
    echo "5 - GitHub Cli"
    echo "6 - Git Repo"
    echo "7 - Google Chrome Stable"
    echo "8 - Google Chrome Beta"
    echo "9 - Google Earth"
    echo "10 - Gradle"
    echo "11 - Java 8"
    echo "12 - Microsoft Teams"
    echo "13 - MySQL WorkBench"
    echo "14 - Peazip"
    echo "15 - Proton VPN"
    echo "16 - Python 3 Pip"
    echo "17 - R Studio"
    echo "18 - Rust Programming Language"
    echo "19 - SDK Man"
    echo "20 - Snapd"
    echo "21 - Speed Test Cli"
    echo "22 - VirtualBox"
    echo "23 - Visual Studio Code"

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
    bash ./Install-Docker.sh
  elif [ "$opcao_selecionada" -eq 2 ]; then
    sudo pwsh ./Install-NvidiaDriver.ps1 -SignLinuxKernelModules
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Install-Flathub.sh
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./Install-Flatpak.sh
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./Install-GithubCli.sh
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./Install-GitRepo.sh
  elif [ "$opcao_selecionada" -eq 7 ]; then
    bash ./Install-GoogleChromeStable.sh
  elif [ "$opcao_selecionada" -eq 8 ]; then
    bash ./Install-GoogleChromeBeta.sh
  elif [ "$opcao_selecionada" -eq 9 ]; then
    bash ./Install-GoogleEarth.sh
  elif [ "$opcao_selecionada" -eq 10 ]; then
    bash ./Install-Gradle.sh
  elif [ "$opcao_selecionada" -eq 11 ]; then
    bash ./Install-Java8.sh
  elif [ "$opcao_selecionada" -eq 12 ]; then
    bash ./Install-MicrosoftTeams.sh
  elif [ "$opcao_selecionada" -eq 13 ]; then
    bash ./Install-MySqlWorkBench.sh
  elif [ "$opcao_selecionada" -eq 14 ]; then
    bash ./Install-Peazip.sh
  elif [ "$opcao_selecionada" -eq 15 ]; then
    bash ./Install-ProtonVPN.sh
  elif [ "$opcao_selecionada" -eq 16 ]; then
    bash ./Install-Python3Pip.sh
  elif [ "$opcao_selecionada" -eq 17 ]; then
    bash ./Install-RStudio.sh
  elif [ "$opcao_selecionada" -eq 18 ]; then
    bash ./Install-RustLang.sh
  elif [ "$opcao_selecionada" -eq 19 ]; then
    bash ./Install-SdkMan.sh
  elif [ "$opcao_selecionada" -eq 20 ]; then
    bash ./Install-Snapd.sh
  elif [ "$opcao_selecionada" -eq 21 ]; then
    bash ./Install-SpeedTestCli.sh
  elif [ "$opcao_selecionada" -eq 22 ]; then
    bash ./Install-VirtualBox.sh
  elif [ "$opcao_selecionada" -eq 23 ]; then
    bash ./Install-VisualStudioCode.sh
  fi
done
