*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 HEL
${destination}            SHA
${MA FF-number}       690876156
${TT FF-number}       677677247

*** Test Case ***
15. iOS - Logged in, Business upgrade after CI
    [Tags]                                                PNR15    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              2          4                                        
    Book Flight On Finnair Operated Flight                  1          K
    Set Return Date    
    Book Return Flight                                      1          K     ${return_day}    ${return_month} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number} 
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number} 
    Price Itinerary With Best Price 
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}