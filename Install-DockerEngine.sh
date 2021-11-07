#!/bin/bash
curl -fsSL https://get.docker.com -o Get-Docker.sh
sudo sh Get-Docker.sh
sudo groupadd docker
sudo usermod -aG docker $USER
# newgrp docker
docker run hello-world
sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "$HOME/.docker" -R
sudo systemctl enable docker.service
sudo systemctl enable docker.socket
sudo systemctl enable containerd.service
sudo systemctl start docker.service
sudo systemctl start docker.socket
sudo systemctl start containerd.service
dockerd-rootless-setuptool.sh install
systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
docker context use rootless