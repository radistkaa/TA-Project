*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 ZRH
${destination}            OSA


*** Test Case ***
21. iOS - Guest login, multipax, complimentary seats, meals multipax
    [Tags]                                                PNR21    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight In This Month
    Book Via Flight On Finnair Operated Flight              2          Y        HEL                                     
    Set Return Date    
    Book Return Flight                                      2          Y     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_john_smith}
    Add Second Passenger To Booking    ${pax_tim_jones}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}

