#!/bin/bash

# Variáveis
container_name="open-webui"

# Definindo imagem do container
if lspci | grep -i nvidia; then
  container_image="ghcr.io/open-webui/open-webui:cuda"
else
  container_image="ghcr.io/open-webui/open-webui:main"
fi

# Iniciando o ollama
ollama serve &

# Baixando imagem do container
docker pull "$container_image"

# Criando o container caso ele não exista
if ! [ "$(docker ps -a | grep -wc "$container_name")" -gt 0 ]; then
  docker run -d -p 3000:8080 \
          --gpus all --add-host=host.docker.internal:host-gateway \
          -v open-webui:/app/backend/data \
          --name open-webui --restart unless-stopped \
          "$container_image"
fi

# Iniciando container caso ele não esteja em execução
if ! [ "$(docker ps | grep -wc "$container_name")" -gt 0 ]; then
  docker start "$container_name"
fi

# Abrindo o navegador web padrão na página do Open-WebUI
xdg-open "http://localhost:3000"