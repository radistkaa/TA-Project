#!/usr/bin/env python

import requests
import json
import robot
from variables import *


def list_all_flights():
    """ list all flights with template """
    headers = {
        'x-api-key': apikey,
        'Content-Type': 'application/json',
    }
    response = requests.get("%s/bookings" % bookings_url, headers=headers)
    if response.status_code != 200:
        raise AssertionError("Failed to fetch bookings, status code: {}"
                             .format(response.status_code))
    print(response.status_code)
    jsondata = json.loads(response.text)
    print("Total count: {} flights".format(len(jsondata)))
    return jsondata


def create_new_flight(template):
    """ create new flight with robot """
    print("create new flight ...")
    with open('stdout.txt', 'w') as stdout:
        robot.run('robot_files/tests/',
                  include=[template],
                  log=None,
                  stdout=stdout)


def count_flights(template):
    flights = []
    for i in range(len(flight_data)):
        if flight_data[i][u'template'] == template:
            flights.append(flight_data[i])
            print("flight with template {} id :{}"
                  .format(flight_data[i][u'template'], flight_data[i][u'id']))

    print("found {} flights with template {}".format(len(flights), template))
    # create flight with template as tag value
    if len(flights) < 10:
        create_new_flight(template)
    else:
        print("no need to create new flights")


# get current flights
flight_data = list_all_flights()

# loop needed templates
with open('scripts/flight-templates.json') as json_file:
    data = json.load(json_file)
    for p in data['templates']:
        print("list flights with template: * {} *".format(p['template']))
        print("*************************************************")
        print("*************************************************")
        count_flights(p['template'])

