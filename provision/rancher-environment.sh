echo "Generating API keys..."

# Register API keys for rancher cli
RESP=$(curl -X POST "http://localhost:8080/v2-beta/apikeys")

export RANCHER_URL=http://localhost:8080
export RANCHER_ACCESS_KEY=$(echo $RESP | jq -r ".publicValue")
export RANCHER_SECRET_KEY=$(echo $RESP | jq -r ".secretValue")

echo "export RANCHER_URL=\"$RANCHER_URL\"" >> /etc/profile.d/hostvars.sh
echo "export RANCHER_ACCESS_KEY=\"$RANCHER_ACCESS_KEY\"" >> /etc/profile.d/hostvars.sh
echo "export RANCHER_SECRET_KEY=\"$RANCHER_SECRET_KEY\"" >> /etc/profile.d/hostvars.sh