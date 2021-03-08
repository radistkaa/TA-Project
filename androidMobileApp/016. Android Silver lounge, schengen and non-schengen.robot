*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${MA FF-number}       690875976         #DON'T CHANGE THIS ACCOUNT NUMBER
${TT FF-number}       680113180
${custom filter}         ${space}*AY

*** Test Case ***
16. Android - Silver lounge, schengen and non-schengen
    [Tags]                                                PNR016    PNR_android
    Prepare Variables                                 KAJ       HEL 
    Create Random Flight Date Next X To Y Days        25        50
    Book Flight On Finnair Operated Flight            1         M          ${custom filter}
    Set Return Date    2
    Book Return Flight                                1         M    ${return_day}    ${return_month}   HEL    SIN 
    Set Return Date    
    Book Return Flight                                1         L    ${return_day}    ${return_month}   SIN    KAJ 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}

