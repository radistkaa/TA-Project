*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 ZRH
${destination}            OSA


*** Test Case ***
21. Android - Guest login, multipax, complimentary seats, meals multipax
    [Tags]                                                PNR021    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight In This Month
    Book Via Flight On Finnair Operated Flight              2          Y        HEL                                     
    Set Return Date    
    Book Return Flight                                      2          Y     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_rafael_villanueva}
    Add Second Passenger To Booking    ${pax_rosaura_villanueva}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}

