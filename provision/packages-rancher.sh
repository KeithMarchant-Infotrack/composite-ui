# Setup rancher cli
wget -q https://releases.rancher.com/cli/v0.6.9/rancher-linux-amd64-v0.6.9.tar.gz
tar -xvzf rancher-linux-amd64-v0.6.9.tar.gz
cd rancher-v0.6.9
mv ./rancher /bin
chmod +x /bin/rancher

# Setup rancher comspose
wget -q https://releases.rancher.com/compose/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz
tar -xvzf rancher-compose-linux-amd64-v0.12.5.tar.gz
cd rancher-compose-v0.12.5
mv ./rancher-compose /bin
chmod +x /bin/rancher-compose
