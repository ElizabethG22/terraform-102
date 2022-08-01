#!/bin/bash

cd $HOME

sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo usermod -aG docker ec2-user

sudo docker run -d -p 80:3000 grafana/grafana
