# Set url
MASTER='http://192.168.0.100:8080'

# Register register in registry of registers
REGISTRY_ID=`curl -X POST \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
            "name": "InfoTrack Registry", 
            "serverAddress": 
            "docker.infotrack.com.au:5000"
        }' \
    $MASTER/v1/projects/1a5/registries | jq -re '.id'`

# Set credentials for the registry
BODY=$(echo '{"registryId": "$REGISTRY_ID", "publicValue": "oleksii.udovychenko", "secretValue": "Ku!Chatlanen1!"}' | sed -e "s/\$REGISTRY_ID/$REGISTRY_ID/g" )

curl -X POST \
    -H 'Accept: application/json' \
    -H 'Content-Type: application/json' \
    -d "$BODY" \
    $MASTER/v2-beta/projects/1a5/registryCredentials

docker login -u "oleksii.udovychenko" -p 'Ku!Chatlanen1!' docker.infotrack.com.au:5000