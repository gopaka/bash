# script to list out users which are part of non-autoprotect OD jobs but do not have valid OD but present in EH.
# please change source_id and job_id accordingly in main_task():
import requests
import json
import urllib3
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

CLUSTER_USERNAME = 'cohesity_ui_support_6706347909807572'
CLUSTER_PASSWORD = 'ci8aCIl8EsbI/2rN8puSE/pAjGkaHF7Af9C03IL5oK4='
CLUSTER_VIP = 'localhost:41844'
DOMAIN = 'LOCAL'

##########################################################
def get_access_token():
  url = "https://"+CLUSTER_VIP+"/irisservices/api/v1/public/accessTokens"

  payload = json.dumps({
    "domain": DOMAIN,
    "password": CLUSTER_PASSWORD,
    "username": CLUSTER_USERNAME
  })
  headers = {
    'authority': CLUSTER_VIP,
    'pragma': 'no-cache',
    'cache-control': 'no-cache',
    'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
    'accept': 'application/json',
    'content-type': 'application/json',
    'sec-ch-ua-mobile': '?0',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
    'sec-ch-ua-platform': '"Windows"',
    'origin': 'https://'+CLUSTER_VIP,
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'sec-fetch-dest': 'empty',
    'referer': 'https://'+CLUSTER_VIP+'/docs/restApiDocs/browse/',
    'accept-language': 'en-US,en;q=0.9'
  }

  response = requests.request(
      "POST", url, headers=headers, data=payload, verify=False, timeout=1000)

  # print(response.json()['accessToken'])

  return response.json()['accessToken']

###############################################################
def get_od_sources_info(access_token, source_id):
  url = "https://"+CLUSTER_VIP+"/irisservices/api/v1/public/protectionSources?pageSize=50000&id="+str(source_id)+"&hasValidOnedrive=true&allUnderHierarchy=true"
  payload={}
  headers = {
    'authority': CLUSTER_VIP,
    'pragma': 'no-cache',
    'cache-control': 'no-cache',
    'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
    'accept': 'application/json, text/plain, */*',
    'sec-ch-ua-mobile': '?0',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'sec-fetch-dest': 'empty',
    'accept-language': 'en-US,en;q=0.9',
    'Authorization': 'Bearer '+access_token
  }

  response = requests.request(
      "GET", url, headers=headers, data=payload, verify=False)
  valid_od_list = {}
  node_list = response.json()[0]['nodes']
  # print(len(node_list))
  for node in node_list:
    valid_od_list[node['protectionSource']['id']] = node['protectionSource']['name']

  # if 235110 not in valid_od_list.keys():
  #   print("ok")
  return valid_od_list

###############################################################
def get_missing_and_sources_info_for_pg(access_token, job_id):
  url = "https://"+CLUSTER_VIP+"/v2/data-protect/protection-groups/"+job_id+"?pruneSourceIds=false"
  payload={}
  headers = {
    'authority': CLUSTER_VIP,
    'pragma': 'no-cache',
    'cache-control': 'no-cache',
    'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
    'accept': 'application/json, text/plain, */*',
    'sec-ch-ua-mobile': '?0',
    'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
    'sec-ch-ua-platform': '"Windows"',
    'sec-fetch-site': 'same-origin',
    'sec-fetch-mode': 'cors',
    'sec-fetch-dest': 'empty',
    'accept-language': 'en-US,en;q=0.9',
    'Authorization': 'Bearer '+access_token
  }

  response = requests.request(
      "GET", url, headers=headers, data=payload, verify=False)
  missing_entities = {}
  job_entities = {}
  for entities in response.json()['missingEntities']:
    missing_entities[entities['id']] = entities['name']
  for entities in response.json()['office365Params']['objects']:
    job_entities[entities['id']] = entities['name']

  # print(len(missing_entities))
  # print((job_entities))
  return missing_entities, job_entities

###############################################################
def main_task():

  ## get token.
  access_token = get_access_token()

  source_id = 10879
  job_id = "6706347909807572%1602575626064%1790318"

  ## get valid od list.
  valid_od_list = get_od_sources_info(access_token, source_id)

  # get missing and job entities for PG
  missing_entities, job_entities = get_missing_and_sources_info_for_pg(access_token, job_id)

  for key, value in job_entities.items():
    if key not in missing_entities.keys() and key not in valid_od_list.keys():
      print(value)


#################################################################
if __name__ == '__main__':
  main_task()