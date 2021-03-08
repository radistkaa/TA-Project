# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 OSA
${destination}            HEL
${MA FF-number}       690876156        
${TT FF-number}       677677247
 

*** Test Case ***
6. iOS - Logged in, multipax, non-EUR currency
    [Tags]                                                PNR6    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              30         60                                        
    Book Flight On Finnair Operated Flight                  3          M
    Set Return Date    
    Book Return Flight                                      3          L     ${return_day}    ${return_month}
    #Add Passenger With Infant    ${pax_emma_adelaide}    ANNA ADELAIDE
    Add Passenger With Infant    ${pax_nile_indy_fbstest}    ANNA FBSTEST
    #Add Frequent Flyer Number To Booking            ${MA FF-number}
    Add Frequent Flyer Number To Booking            ${TT FF-number}
    Add Child Passenger          ${pax_child_adelaide}   
    Add Second Passenger To Booking    ${pax_erik_adelaide}
    Price Itinerary With Best Price
    Validate Ticket
    Save result to file    ${TEST NAME}
    

