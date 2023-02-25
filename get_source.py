import requests
import json
import os

username = "cohesity_ui_support_5240701493375482"
password = "RYe308iPbOR+/W+3j4fOVi2gI2jB4CtsFzauFi9kLc8="
ip = 'localhost:57399'

url = f"https://{ip}/irisservices/api/v1/public/accessTokens"

# Get token
data = {"username": username, "password": password}
headers = {
    "accept": "application/json",
    "Content-Type": "application/json"
}
response = requests.post(url, headers=headers, data=json.dumps(data), verify=False)
token = response.json()["accessToken"]

# Get source details using API call
url = f"https://{ip}/irisservices/api/v1/public/protectionSources/protectedObjects?environment=kO365&id=3&includeRpoSnapshots=false&pruneProtectionJobMetadata=true"
headers = {
    "accept": "application/json",
    "authorization": f"Bearer {token}"
}
source_details = requests.get(url, headers=headers, verify=False)

with open("source_details.json", "w") as f:
    f.write(json.dumps(source_details.json(), indent=4))

# Verify that the JSON file was created and contains data
try:
    with open("source_details.json") as f:
        source_details = json.loads(f.read())

    print("Successfully Fetched Source Details!")
    print(f"Number of Users Discovered is : {sum(1 for obj in source_details if obj['kind'] == 'kUser')}")
  
    # find, filter and save the final list to json format 
    filtered_details = [obj for obj in source_details if obj['kind'] == 'kUser']

    with open("output.json", "w") as f:
        f.write(json.dumps(filtered_details, indent=4))

    print(f"Please find the source list file in Location output.json")
except FileNotFoundError:
    print("Error: JSON file was not created.")
