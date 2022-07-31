import sys
import csv
import requests
newList = []
#create a string and integer dictionary
speed_lookup = dict([("Bassi Pathana Road",45),("North Ambazari Road",50)])
filename = sys.argv[1]
with open(filename, "r") as f:
    csvFile = csv.reader(f)
    for row in csvFile:
        newList.append(row)
for i in range(len(newList)):
    latitude = newList[i][0]
    longitude = newList[i][1]
    speed = int(newList[i][2])
    apiKey = "mapmyindiaapikey"
    #call mapmyindia reverse geocoding API
    url = "https://apis.mapmyindia.com/advancedmaps/v1/"
    url += apiKey
    url += "/rev_geocode?lat="
    url += latitude
    url += "&lng="
    url += longitude
    url += "&region=IND"
    #get the response from the API
    response = requests.get(url)
    #parse the response
    data = response.json()
    street_name = data['results'][0]['street']
    speed_limit = speed_lookup[street_name]
    if speed > speed_limit:
        print("Speed limit exceeded on " + street_name + " by " + str(speed - speed_limit) + " km/hr")
