#!/bin/bash

set -e

echo "Updating system packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing Git..."
sudo apt install git -y

echo "Installing Maven..."
sudo apt install maven -y

echo "Installing Docker..."
sudo apt install docker.io -y

echo "Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "Installing Java 21..."
sudo apt install openjdk-21-jdk -y

echo "Creating keyrings directory..."
sudo mkdir -p /etc/apt/keyrings

echo "Adding Jenkins repository key..."
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "Adding Jenkins repository..."
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package list..."
sudo apt update

echo "Installing Jenkins..."
sudo apt install jenkins -y

echo "Enabling Jenkins service..."
sudo systemctl enable jenkins

echo "Adding Jenkins user to Docker group..."
sudo usermod -aG docker jenkins

echo "Restarting Docker..."
sudo systemctl restart docker

echo "Starting Jenkins service..."
sudo systemctl start jenkins

echo "Checking Jenkins service status..."
sudo systemctl status jenkins --no-pager

echo ""
echo "========================================="
echo "Jenkins Initial Admin Password:"
echo "========================================="
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
echo ""
