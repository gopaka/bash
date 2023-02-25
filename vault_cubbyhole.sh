#!/bin/bash

# Set the vault address
VAULT_ADDR=http://10.26.0.13:8200/ui/

# Set the path to the password in the cubbyhole
SECRET_PATH=cubbyhole/password

# Use username/password to get creds
VAULT_TOKEN=$(curl 'http://10.26.0.13:8200/v1/auth/ldap/login/agopak' \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-GB,en-US;q=0.9,en;q=0.8' \
  -H 'Connection: keep-alive' \
  -H 'Origin: http://10.26.0.13:8200' \
  -H 'Referer: http://10.26.0.13:8200/ui/vault/auth?with=ldap' \
  -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36' \
  -H 'content-type: application/json; charset=UTF-8' \
  --data-raw '{"password":"Cricketer@93"}' \
  --compressed \
  --insecure 2>/dev/null | jq '.')

echo jq '.[] | .auth.client_token'| awk -F'"' '/client_token/ {print $4}' > $VAULT_TOKEN $VAULT_TOKEN1
echo $VAULT_TOKEN1

# # Retrieve the password from vault
# PASSWORD=$(curl --silent --header "X-Vault-Token: $VAULT_TOKEN" \
#     "$VAULT_ADDR/v1/$SECRET_PATH" | jq -r .data.password)
    

# # Output the password
# echo $PASSWORD


