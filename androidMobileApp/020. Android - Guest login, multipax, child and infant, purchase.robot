*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 HEL
${destination}            PEK


*** Test Case ***
20. Android - Guest login, multipax, child and infant, purchase
    [Tags]                                                PNR020    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              30         50                                        
    Book Flight On Finnair Operated Flight                  3          L     
    Set Return Date    
    Book Return Flight                                      3          L     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_rafael_villanueva}
    Add Passenger With Infant    ${pax_rosaura_villanueva}    
    Add Child Passenger    ${pax_rosalinda_child}
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}

