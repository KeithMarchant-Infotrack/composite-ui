# Set url
MASTER_IP=$(ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
MASTER_URL="http://$MASTER_IP:8080"

# Get project ID
PROJECT_ID=$(curl -s $MASTER_URL/v1/projects | jq -r ".data[0].id")

# Create registration token
RESP=`curl -s -X POST $MASTER_URL/v1/registrationtokens?projectId=$PROJECT_ID`

# Get registration token
echo "Getting the registration command:"
while [[ -z $(curl -s $MASTER_URL/v1/registrationtokens?projectId=$PROJECT_ID | jq -re '.data[0].command // empty') ]]; do
    echo "Waiting for host registration command to became availiable...";
    sleep 5;
done

# Run command
$(curl -s $MASTER_URL/v1/registrationtokens?projectId=$PROJECT_ID | jq -r '.data[0].command')
