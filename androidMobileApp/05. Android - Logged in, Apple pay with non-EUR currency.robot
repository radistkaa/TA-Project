# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 BKK
${destination}            HEL
${MA FF-number}       690876149        
${TT FF-number}       677677247

*** Test Case ***
5. Android - Logged in, Apple pay with non-EUR currency
    [Tags]                                                PNR05    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              15        40 
    Book Flight On Finnair Operated Flight                  1          K
    Set Return Date    
    Book Return Flight                                      1          K     ${return_day}    ${return_month} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    #Price Itinerary With Different Currency        THB       #need to login to different office - BKKAY08AA
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}








