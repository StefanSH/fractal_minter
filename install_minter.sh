#!/bin/bash

# Update package list
sudo apt update
echo "Node install..."

# Install npm
sudo apt-get install npm -y

# Install Node.js using 'n' and switch to the stable version
sudo npm install -g n
sudo n stable

# Install Yarn globally
sudo npm i -g yarn

echo "Cloning cat-token-box..."

# Clone the cat-token-box repository
git clone https://github.com/CATProtocol/cat-token-box
cd cat-token-box

# Install dependencies and build the project
sudo yarn install
sudo yarn build

# Create the config.json with the provided IP address
CONFIG_JSON='{
  "network":"fractal-mainnet",
  "tracker":"http://%s:3000",
  "dataDir":".",
  "maxFeeRate":3,
  "rpc":{
    "url":"http://%s:8332",
    "username":"bitcoin",
    "password":"opcatAwesome"
  }
}'

# Populate the config.json with the argument passed to the script
printf "$CONFIG_JSON" "$1" "$1" > ~/cat-token-box/packages/cli/config.json

# Navigate to the CLI directory
cd ~/cat-token-box/packages/cli/

echo "Creating wallet..."

# Run the wallet creation command
yarn cli wallet create
