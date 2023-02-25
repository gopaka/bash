import requests
import json
import os

ips = ["10.16.16.173", "10.16.18.25"]
username = "testuser4"
password = "Password@123"
alert_files = [f for f in os.listdir() if f.startswith("alert") and f.endswith(".json")]

for ip in ips:
    print(f"==== {ip} ====")
    print("Fetching Token ... ")
    data = {"username": username, "password": password}
    response = requests.post(f"https://{ip}/irisservices/api/v1/public/accessTokens", json=data, verify=False)
    token = response.json()["accessToken"]
    print(ip)
    print(token)

    for alert_file in alert_files:
        with open(alert_file) as f:
            alert_data = json.load(f)
        ruleId = alert_data["ruleId"]
        print(f"Adding alert rule ID {ruleId}")
        headers = {
            "accept": "application/json",
            "Content-Type": "application/json",
            "authorization": f"Bearer {token}",
        }
        response = requests.post(f"https://{ip}/irisservices/api/v1/public/alertNotificationRules", json=alert_data, headers=headers, verify=False)

print("\n")
