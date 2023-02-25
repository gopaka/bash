#! /bin/bash

# Prompt for cred details
#echo Please enter UI username and password
#read -p 'username :' username
#read -sp 'password :' password

#echo Please enter the IP of node or fqdn
#read ip 

username="testuser4"
password="Password@123"
ip=10.16.16.173

# Api call to get token
for ips in $ip ; do
	#echo "==== $ip ====" ;
	#echo "Fetching Token .."
	token=$(curl -X POST --silent --insecure "https://$ip/irisservices/api/v1/public/accessTokens" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"password\": \"$password\",  \"username\": \"$username\"}" 2>/dev/null | jq '.accessToken')
    #echo $ip
    echo $token
done

# Get source details using API call
source_details=$(curl --silent --insecure -v GET "https://$ip/irisservices/api/v1/public/protectionSources/protectedObjects?environment=kO365&id=3&includeRpoSnapshots=false&pruneProtectionJobMetadata=true" -H "accept: application/json"  -H "authorization : Bearer $token" --http1.1 2>/dev/null)

echo "$source_details" | jq > $PWD/source_details.json

# Verify that the JSON file was created and contains data
if [ -f source_details.json ]; then
  echo "Successfully Fetched Source Details!"
  echo "Number of Users Discovered is : `grep -iw 'kUser' $PWD/source_details.json | wc -l`"
  
  #find, filter and save the final list to json format 
  search_string='kUser'
  grep_output=$(grep "$search_string" $PWD/source_details.json -A3)
  while read -r line; do
  printf "%s\n" "$line" 
  done <<< "$grep_output" > $PWD/output.json
  
  echo "Plese find the source list file in Location "$PWD/output.json""
else
  echo "Error: JSON file was not created."
fi