*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 HEL
${destination}            OUL
${MA FF-number}       690876156
${TT FF-number}       677677247
${custom filter}      ${space}*AY

*** Test Case ***
14. iOS - Logged in, check-in for multipax, BP validation
    [Tags]                                                PNR14    PNR0
    Prepare Variables                                       HEL     OUL
    Create Random Flight Date Next 3 To 29 Days
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    Y    435   
    Add Passenger To Booking    ${pax_tim_hall}
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}
