#!/usr/bin/env python
#
import datetime
import random
import calendar



def generate_random_flight_date(days2departure, days2return):
    """ generate random flight date """
    departure_date = datetime.date.today() + datetime.timedelta(
        days=random.randint(int(days2departure), int(days2return)))

    year, month, day = str(departure_date).split("-")
    return year, month, day, calendar.month_name[int(month)][:3].upper()


def generate_random_flight_date_in_this_month(firstday2departure, lastday2dep):
    """ generate random flight date on current month """
    year, month, day = str(datetime.date.today()).split("-")
    day = random.randint(int(firstday2departure), int(lastday2dep))
    return year, month, day, calendar.month_name[int(month)][:3].upper()


def get_flight_days_for_this_month(treshold=3):
    """ return flight days for this month """
    now = datetime.datetime.now()
    days = _days_on_this_month()
    return now.day + treshold, days


def _days_on_this_month():
    """ how many days we have on this month """
    now = datetime.datetime.now()
    return calendar.monthrange(now.year, now.month)[1]