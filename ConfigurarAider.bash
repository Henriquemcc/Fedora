#!/bin/bash

# Installing Ollama
bash ./Install-Ollama.bash

# Instalando Aider
bash ./Install-Aider.bash

# Definindo a API base do Ollama no .bashrc
echo 'export OLLAMA_API_BASE=http://127.0.0.1:11434' >> ~/.bashrc

# Adicionando modelo no arquivo de configuração do Aider
echo 'model: ollama_chat/qwen3:8b' > "$HOME/.aider.conf.yml"

# Aumentando o contexto
{
echo '- name: ollama_chat/qwen3:8b'
echo '  extra_params:'
echo '   num_ctx: 16384'
}  >> "$HOME/.aider.model.settings.yml"

# Baixando modelos
ollama pull qwen3:8b