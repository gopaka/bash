#! /bin/bash

echo Please enter UI username and password
read -p 'username :' username
read -sp 'password :' password

echo Please enter the IP of node or fqdn
read ip 

#username="testuser4"
#password="Password@123"
#ip=10.16.16.173

for ips in $ip ; do
	echo "==== $ip ====" ;
	echo "Fetching Token ... "
	token=$(curl -X POST --insecure "https://$ip/irisservices/api/v1/public/accessTokens" -H  "accept: application/json" -H  "Content-Type: application/json" -d "{  \"password\": \"$password\",  \"username\": \"$username\"}" 2>/dev/null | jq '.accessToken')
    echo $ip
    echo $token
done


source=$(curl --insecure -v GET "https://$ip/irisservices/api/v1/public/protectionSources?_clientSideExcludeTypes=kResourcePool&_useClientSideExcludeTypesFilter=true&allUnderHierarchy=true&id=59740&includeEntityPermissionInfo=true&includeVMFolders=true" -H "accept: application/json"  -H "authorization : Bearer $token" --http1.1)

echo $source


