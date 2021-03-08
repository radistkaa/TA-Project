# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu

*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
${MA FF-number}       690876149       
${TT FF-number}       677677247


*** Test Case ***
2. Android - Logged in, single pax, bound handling, complimentary seat
    [Tags]                                                PNR02    PNR_android
    Create Random Flight In This Month
    Book Return Flight    1    H    ${day}    ${month_as_string}       OUL     HEL
    Set Return Date    1
    Book Return Flight    1    H    ${return_day}    ${return_month}   HEL    SHA 
    Arrival Unknown Segment
    Set Return Date    
    Book Return Flight    1    H    ${return_day}    ${return_month}   PEK    OUL 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}    
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}

