cd /vagrant
docker-compose build
rancher --file docker-compose.yml --rancher-file rancher-compose.yml up