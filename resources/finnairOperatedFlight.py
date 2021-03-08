#!/usr/bin/env python

from robot.libraries.BuiltIn import BuiltIn
import re


def finnair_flight(file2read="/tmp/finnairflight.txt", flight_filter=" AY"):
    """ validate that flight is operated by finnair

        return flight id for SS command

    """
    filename = file2read
    flights = []
    with open(filename) as f:
        content = f.readlines()

    # find lines that starts with digit and contains AY
    for line in content:
        if line.strip().__contains__("%s" % flight_filter):
            if line.strip(" ").startswith(tuple('0123456789')):
                print(line.strip())
                flights.append(line)

    print(flights)
    BuiltIn().log_to_console("\nwe have {} Finnair flights".format(len(flights)))

    if len(flights) == 0:
        raise Exception("failed to find pure AY flight")
    flightIndex = re.search("\d", flights[0])

    # return first option
    return flights[0][flightIndex.start()]


def verify_that_certain_class_is_open(file2read="/tmp/classfinder.txt", classTofind="V"):
    """ validate that class is open """
    flight_bound_with_certain_class = 99
    filename = file2read
    flights_full_seat_availibility = []
    with open(filename) as f:
        content = f.readlines()

    # find lines that contains AY and starts with digit
    for i, line in enumerate(content):
        if line.strip().__contains__(" AY"):
            if line.strip(" ").startswith(tuple('0123456789')):
                print(str(i) + ": " + line.strip())
                print(content[i + 1])
                flights_full_seat_availibility.append(line)
                flights_full_seat_availibility.append(content[i + 1])
                break

    BuiltIn().log_to_console("\nwe have {} AY flight(s):".format(len(flights_full_seat_availibility) / 2))

    # loop content and find flight that has certain class open
    for i, line in enumerate(flights_full_seat_availibility):
        if re.search("%s\d{1}" % classTofind, line) is not None:
            flight_bound_with_certain_class = flights_full_seat_availibility[0][1]

    if flight_bound_with_certain_class == 99:
        raise Exception("failed to find flight with open %s class" % classTofind)

    # return bound id
    return flight_bound_with_certain_class

