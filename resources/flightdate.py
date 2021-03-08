from robot.libraries.BuiltIn import BuiltIn
import re


def get_flight_date(file2read="/tmp/booking.txt"):
    """
        check flight date from booking
    """
    flights = []
    with open(file2read) as f:
        content = f.readlines()

    # find lines that starts with digit and contains AY
    for line in content:
        if line.strip().__contains__(" AY"):
            if line.strip(" ").startswith(tuple('0123456789')):
                flights.append(line)

    BuiltIn().log_to_console("\ntotal count of potential flights is: {}"
                             .format(len(flights)))

    # find first flight date that starts with ddMON
    for flight in flights:
        line = flight.strip().split(" ")
        for i in line:
            # match with ddMON ie. 16MAR
            if re.match("^\d\d\D\D\D", i):
                flight_date = i
                break
        if flight_date is not None:
            break
    if flight_date is not None:
        BuiltIn().log_to_console(
            "\nfound flight date: {}".format(flight_date))
    return flight_date[:2], flight_date[2:]     # 13 JAN

