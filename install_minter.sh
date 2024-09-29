#/bin/bash
sudo apt update
echo "Node install..."

sudo apt-get install npm -y
sudo npm install n -g
sudo n stable
sudo npm i -g yarn

echo "Cloning cat-token-box..."

git clone https://github.com/CATProtocol/cat-token-box
cd cat-token-box
sudo yarn install
sudo yarn build

CONFIG_JSON = '{"network":"fractal-mainnet","tracker":"http://%s:3000","dataDir":".","maxFeeRate":3,"rpc":{"url":"http://%s:8332","username":"bitcoin","password":"opcatAwesome"}}'
printf "$CONFIG_JSON" "$1" "$1" > ~/cat-token-box/packages/cli/config.json

cd ~/cat-token-box/packages/cli/
echo "Creating wallet..."
yarn cli wallet create
