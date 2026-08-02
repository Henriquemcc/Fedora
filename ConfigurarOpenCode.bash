#!/bin/bash

# Instalação de pacotes no sistema
function run_as_root() {

  # Instalando Docker
  if ! [ "$(command -v docker)" ]; then
    bash ./Install-DockerEngine.bash
  fi

  # Instalando Nvidia Container
  bash ./Install-NvidiaContainer.bash

  # Instalando Ollama
  curl -fsSL https://ollama.com/install.sh | sh
}

# Executando instalação de pacotes no sistema
if [ "$(whoami)" == "root" ]; then
   bash -c "$(declare -f run_as_root); run_as_root"
else
  if [ "$(command -v sudo-rs)" ]; then
    sudo-rs bash -c "$(declare -f run_as_root); run_as_root"
  else
    sudo bash -c "$(declare -f run_as_root); run_as_root"
  fi
fi

# Instalando Open Code
curl -fsSL https://opencode.ai/install | bash

# Baixando modelos no Ollama
ollama serve &
ollama pull qwen3.5:latest
ollama pull deepseek-r1:latest
ollama pull mistral:latest
ollama pull gpt-oss:latest

# Garantindo que o diretório de config existe
mkdir -p "$HOME/.config/opencode"

# Configurando integração entre Ollama e Open Code
cat > "$HOME/.config/opencode/opencode.json" << 'EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama",
      "options": {
        "baseURL": "http://localhost:11434/v1"
      },
      "models": {
        "qwen3.5": {
          "name": "qwen3.5"
        },
        "glm-5.2": {
          "name": "glm-5.2"
        },
        "deepseek-r1": {
          "name": "deepseek-r1"
        },
        "mistral": {
          "name": "mistral"
        },
        "gpt-oss": {
          "name": "gpt-oss"
        }
      }
    }
  }
}
EOF

