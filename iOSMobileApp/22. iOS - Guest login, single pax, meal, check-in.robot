*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 HEL
${destination}            OUL


*** Test Case ***
22. iOS - Guest login, single pax, meal, check-in
    [Tags]                                                PNR22    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days                         2    4
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    435                                  
    Set Return Date    
    Book Return Flight                                                 1    M     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_antero_salo}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}