# Get Tyk up and running in test mode
cd /vagrant/stacks/tyk
rancher up -d

# Tyk dashboard settings
TYK_DASHBOARD_USERNAME="tyk@infotrack.com.au"
TYK_DASHBOARD_PASSWORD="tyk123"

# Tyk portal settings
TYK_DASH_DOMAIN="tyk.local"
TYK_PORTAL_DOMAIN="portal.tyk.local"
TYK_PORTAL_PATH="/portal/"

DOCKER_IP="localhost"

echo "Creating Organisation"
ORG_DATA=$(curl --silent --header "admin-auth: 12345" --header "Content-Type:application/json" --data '{"owner_name": "InfoTrack Pty Ltd.","owner_slug": "InfoTrack Pty Ltd.", "cname_enabled":true, "cname": "'$TYK_PORTAL_DOMAIN'"}' http://$DOCKER_IP:3000/admin/organisations 2>&1)
ORG_ID=$(echo $ORG_DATA | jq -r ".Meta")
echo "ORG ID: $ORG_ID"

echo "Adding new user"
USER_DATA=$(curl --silent --header "admin-auth: 12345" --header "Content-Type:application/json" --data '{"first_name": "Tyk","last_name": "","email_address": "'$TYK_DASHBOARD_USERNAME'","active": true,"org_id": "'$ORG_ID'"}' http://$DOCKER_IP:3000/admin/users 2>&1)
USER_AUTH=$(echo $USER_DATA | jq -r ".Message")
USER_LIST=$(curl --silent --header "authorization: $USER_AUTH" http://$DOCKER_IP:3000/api/users 2>&1)
USER_ID=$(echo $USER_LIST | jq -r ".users[0].id")
echo "USER AUTH: $USER_AUTH"
echo "USER ID: $USER_ID"

echo "Setting password"
OK=$(curl --silent --header "authorization: $USER_AUTH" --header "Content-Type:application/json" http://$DOCKER_IP:3000/api/users/$USER_ID/actions/reset --data '{"new_password":"'$TYK_DASHBOARD_PASSWORD'"}')

echo "Setting up the Portal catalogue"
CATALOGUE_DATA=$(curl --silent --header "Authorization: $USER_AUTH" --header "Content-Type:application/json" --data '{"org_id": "'$ORG_ID'"}' http://$DOCKER_IP:3000/api/portal/catalogue 2>&1)
CATALOGUE_ID=$(echo $CATALOGUE_DATA | jq -r ".Message")
OK=$(curl --silent --header "Authorization: $USER_AUTH" http://$DOCKER_IP:3000/api/portal/catalogue 2>&1)

echo "Creating the Portal Home page"
OK=$(curl --silent --header "Authorization: $USER_AUTH" --header "Content-Type:application/json" --data '{"is_homepage": true, "template_name":"", "title":"Tyk Developer Portal", "slug":"home", "fields": {"JumboCTATitle": "Tyk Developer Portal", "SubHeading": "Sub Header", "JumboCTALink": "#cta", "JumboCTALinkTitle": "Your awesome APIs, hosted with Tyk!", "PanelOneContent": "Panel 1 content.", "PanelOneLink": "#panel1", "PanelOneLinkTitle": "Panel 1 Button", "PanelOneTitle": "Panel 1 Title", "PanelThereeContent": "", "PanelThreeContent": "Panel 3 content.", "PanelThreeLink": "#panel3", "PanelThreeLinkTitle": "Panel 3 Button", "PanelThreeTitle": "Panel 3 Title", "PanelTwoContent": "Panel 2 content.", "PanelTwoLink": "#panel2", "PanelTwoLinkTitle": "Panel 2 Button", "PanelTwoTitle": "Panel 2 Title"}}' http://$DOCKER_IP:3000/api/portal/pages 2>&1)

echo "Fixing Portal URL"
URL_DATA=$(curl --silent --header "admin-auth: 12345" --header "Content-Type:application/json" http://$DOCKER_IP:3000/admin/system/reload 2>&1)
CAT_DATA=$(curl -X POST --silent --header "Authorization: $USER_AUTH" --header "Content-Type:application/json" --data "{}" http://$DOCKER_IP:3000/api/portal/configuration 2>&1)

echo ""

echo "DONE"
echo "===="
echo "Login at http://$TYK_DASH_DOMAIN:3000/"
echo "Username: $TYK_DASHBOARD_USERNAME"
echo "Password: $TYK_DASHBOARD_PASSWORD"
echo "Portal: http://$TYK_PORTAL_DOMAIN:3000$TYK_PORTAL_PATH"
echo ""