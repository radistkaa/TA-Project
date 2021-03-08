*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 LHR
${destination}            HEL
${MA FF-number}       690875976         #DON'T CHANGE THIS ACCOUNT NUMBER
${TT FF-number}       680113180


*** Test Case ***
17. Android - Silver tier, lounge not eligible, contact channels
    [Tags]                                               PNR017    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              4         30                                        
    Book Flight On Finnair Operated Flight                  1          C     #booking in business class
    Set Return Date    
    Book Return Flight                                      1          C     ${return_day}    ${return_month} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}