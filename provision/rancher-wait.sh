# Set url
MASTER_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
MASTER_URL="http://$MASTER_IP:8080"

# Wait for rancher to became avaliable
while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' $MASTER_URL)" != "200" ]]; do 
    echo "Warming up rancher server..."; 
    sleep 5; 
done