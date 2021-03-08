*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 HEL
${destination}            SHA


*** Test Case ***
23. iOS - Guest login, multipax, check-in
    [Tags]                                                PNR23    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days                         2    4
    Book Flight On Finnair Operated Flight                             3    L                                 
    Set Return Date    
    Book Return Flight                                                 3    M     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_janne_jarvi}
    Add Second Passenger To Booking     ${pax_tomi_tuomi}  
    Add Second Passenger To Booking     ${pax_jonna_jarvi}  
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}