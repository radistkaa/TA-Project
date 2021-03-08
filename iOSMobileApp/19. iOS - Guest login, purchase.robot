*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 HEL
${destination}            SIN




*** Test Case ***
19. iOS - Guest login, purchase
    [Tags]                                                PNR19    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight In This Month                                      
    Book Flight On Finnair Operated Flight                  1          S     
    Set Return Date    12
    Book Return Flight                                      1          S     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_asa_ylamaki}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}