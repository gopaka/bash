echo -e "\n"
echo This is a bash script can run in any linux machine have access to the cluster ip
echo change ip in ips based on the cluster ip we need to add notification alerts
echo keep alert1.json, alert2.json,... in a single directory
echo -e "\n"
echo If error is "KInternalError","message":"An internal critical error has occurred." then alert is already present in the notification
echo -e "\n"
echo Script starts here
echo ==========================
echo -e "\n"

ips=("10.16.16.173" "10.16.18.25")

username=testuser4
password="Cohe\$1ty"
alert_files=$(ls alert*json)

for ip in ${ips[@]} ; do
	echo "==== $ip ====" ;
	echo "Fetching Token ... "
	token=$(curl -X POST --insecure "https://$ip/irisservices/api/v1/public/accessTokens" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"password\": \"$password\",  \"username\": \"$username\"}" 2>/dev/null | jq '.accessToken')


	for alert_file in ${alert_files} ;
	do
		ruleId=$(jq '.ruleId' $alert_file)
		echo "Adding alert rule ID " $ruleId
		curl --insecure -X POST "https://$ip/irisservices/api/v1/public/alertNotificationRules" -H "accept: application/json" -H "Content-Type: application/json" -H "authorization : Bearer $token" -d @${alert_file}

echo -e "\n"
	done
done
