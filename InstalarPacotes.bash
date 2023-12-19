#!/bin/bash

#!/bin/bash

function_return_variable=

function obter_opcao() {
  _opcao_selecionada=-1
  re='^[0-9]+$'
  while ! [[ $_opcao_selecionada =~ $re ]] || [ $_opcao_selecionada -lt 0 ] || [ $_opcao_selecionada -gt 43 ]; do
    echo "O que deseja fazer?"
    echo "0 - Sair"
    echo "1 - Compilador de Java 8"
    echo "2 - Compilador de Java 11"
    echo "3 - Compilador de Java 17"
    echo "4 - Compilador de Java 20"
    echo "5 - Docker Engine"
    echo "6 - Docker Desktop"
    echo "7 - Driver Nvidia"
    echo "8 - Dynamic DNS Update Client (Duck DNS)"
    echo "9 - FlatHub"
    echo "10 - Flatpak"
    echo "11 - GitHub Cli"
    echo "12 - Git Repo"
    echo "13 - Google Chrome Stable"
    echo "14 - Google Chrome Beta"
    echo "15 - Google Earth"
    echo "16 - Gradle"
    echo "17 - Java 8 (com interface gráfica)"
    echo "18 - Java 11 (com interface gráfica)"
    echo "19 - Java 17 (com interface gráfica)"
    echo "20 - Java 20 (com interface gráfica)"
    echo "21 - Java 8 (sem interface gráfica)"
    echo "22 - Java 11 (sem interface gráfica)"
    echo "23 - Java 17 (sem interface gráfica)"
    echo "24 - Java 20 (sem interface gráfica)"
    echo "25 - Mega Sync"
    echo "26 - Microsoft Teams"
    echo "27 - Mozilla Firefox"
    echo "28 - MySQL WorkBench"
    echo "29 - Nvidia Cuda Toolkit"
    echo "30 - Orange Data Mining"
    echo "31 - Peazip"
    echo "32 - Proton VPN"
    echo "33 - Python 3 Pip"
    echo "34 - R Studio"
    echo "35 - Rust Programming Language"
    echo "36 - SDK Man"
    echo "37 - Snapd"
    echo "38 - Speed Test Cli"
    echo "39 - Technic Launcher"
    echo "40 - VirtualBox (Repositório RPM Fusion)"
    echo "41 - VirtualBox (Repositório da Oracle)"
    echo "42 - Visual Studio Code"
    echo "43 - Weka (Waikato Environment for Knowledge Analysis)"

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
    bash ./Install-Java_8_Devel.bash
  elif [ "$opcao_selecionada" -eq 2 ]; then
    bash ./Install-Java_11_Devel.bash
  elif [ "$opcao_selecionada" -eq 3 ]; then
    bash ./Install-Java_17_Devel.bash
  elif [ "$opcao_selecionada" -eq 4 ]; then
    bash ./Install-Java_21_Devel.bash
  elif [ "$opcao_selecionada" -eq 5 ]; then
    bash ./Install-DockerEngine.bash
  elif [ "$opcao_selecionada" -eq 6 ]; then
    bash ./Install-DockerDesktop.bash
  elif [ "$opcao_selecionada" -eq 7 ]; then
    bash ./Install-NvidiaDriver.bash
  elif [ "$opcao_selecionada" -eq 8 ]; then
    bash ./Install-Dynamic_Dns_Update_Client.bash
  elif [ "$opcao_selecionada" -eq 9 ]; then
    bash ./Install-Flathub.bash
  elif [ "$opcao_selecionada" -eq 10 ]; then
    bash ./Install-Flatpak.bash
  elif [ "$opcao_selecionada" -eq 11 ]; then
    bash ./Install-GithubCli.bash
  elif [ "$opcao_selecionada" -eq 12 ]; then
    bash ./Install-GitRepo.bash
  elif [ "$opcao_selecionada" -eq 13 ]; then
    bash ./Install-GoogleChromeStable.bash
  elif [ "$opcao_selecionada" -eq 14 ]; then
    bash ./Install-GoogleChromeBeta.bash
  elif [ "$opcao_selecionada" -eq 15 ]; then
    bash ./Install-GoogleEarth.bash
  elif [ "$opcao_selecionada" -eq 16 ]; then
    bash ./Install-Gradle.bash
  elif [ "$opcao_selecionada" -eq 17 ]; then
    bash ./Install-Java_8_Gui.bash
  elif [ "$opcao_selecionada" -eq 18 ]; then
    bash ./Install-Java_11_Gui.bash
  elif [ "$opcao_selecionada" -eq 19 ]; then
    bash ./Install-Java_17_Gui.bash
  elif [ "$opcao_selecionada" -eq 20 ]; then
    bash ./Install-Java_21_Gui.bash
  elif [ "$opcao_selecionada" -eq 21 ]; then
    bash ./Install-Java_8_Headless.bash
  elif [ "$opcao_selecionada" -eq 22 ]; then
    bash ./Install-Java_11_Headless.bash
  elif [ "$opcao_selecionada" -eq 23 ]; then
    bash ./Install-Java_17_Headless.bash
  elif [ "$opcao_selecionada" -eq 24 ]; then
    bash ./Install-Java_21_Headless.bash
  elif [ "$opcao_selecionada" -eq 25 ]; then
    bash ./Install-MegaSync.bash
  elif [ "$opcao_selecionada" -eq 26 ]; then
    bash ./Install-MicrosoftTeams.bash
  elif [ "$opcao_selecionada" -eq 27 ]; then
    bash ./Install-Firefox.bash
  elif [ "$opcao_selecionada" -eq 28 ]; then
    bash ./Install-MySqlWorkBench.bash
  elif [ "$opcao_selecionada" -eq 29 ]; then
    bash ./Install-NvidiaCudaToolkit.bash
  elif [ "$opcao_selecionada" -eq 30 ]; then
    bash ./Install-OrangeDataMining.bash
  elif [ "$opcao_selecionada" -eq 31 ]; then
    bash ./Install-Peazip.bash
  elif [ "$opcao_selecionada" -eq 32 ]; then
    bash ./Install-ProtonVPN.bash
  elif [ "$opcao_selecionada" -eq 33 ]; then
    bash ./Install-Python3Pip.bash
  elif [ "$opcao_selecionada" -eq 34 ]; then
    bash ./Install-RStudio.bash
  elif [ "$opcao_selecionada" -eq 35 ]; then
    bash ./Install-RustLang.bash
  elif [ "$opcao_selecionada" -eq 36 ]; then
    bash ./Install-SdkMan.bash
  elif [ "$opcao_selecionada" -eq 37 ]; then
    bash ./Install-Snapd.bash
  elif [ "$opcao_selecionada" -eq 38 ]; then
    bash ./Install-SpeedTestCli.bash
  elif [ "$opcao_selecionada" -eq 39 ]; then
    bash ./Install-TechnicLauncher.bash
  elif [ "$opcao_selecionada" -eq 40 ]; then
    bash ./Install-VirtualBox.bash
  elif [ "$opcao_selecionada" -eq 41 ]; then
    bash ./Install-OracleVirtualBox.bash
  elif [ "$opcao_selecionada" -eq 42 ]; then
    bash ./Install-VisualStudioCode.bash
  elif [ "$opcao_selecionada" -eq 43 ]; then
    bash ./Install-Weka.bash
  fi
done
