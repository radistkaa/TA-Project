#!/usr/bin/env python

import datetime


def get_return_day_and_month(departure_day, departure_month,
                             return_after_days=10):
    """ return departure day and month """
    start_date = "{}/{}".format(departure_day, departure_month)

    departure = datetime.datetime.strptime(start_date, "%d/%b")

    end_date = departure + datetime.timedelta(days=int(return_after_days))

    return_day = end_date.strftime("%d")
    return_month = end_date.strftime("%b").upper()
    return return_day, return_month


def convert_month_string_to_int(month_as_string):
    """ convert JUN -> 06 """
    return datetime.datetime.strptime(month_as_string, "%b").strftime("%m")


