# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
${origin}         BCN
${destination}    HEL
${MA FF-number}       690876156        
${TT FF-number}       677677247
${custom filter}         ${space}*AY


*** Test Case ***
1. iOS - Logged in, OW
    [Tags]                                    PNR1    PNR0
    Prepare Variables                         ${origin}     ${destination}
    Create Random Flight In This Month
    Book Flight On Finnair Operated Flight    1    M    ${custom filter} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking     ${TT FF-number}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}
    
    







