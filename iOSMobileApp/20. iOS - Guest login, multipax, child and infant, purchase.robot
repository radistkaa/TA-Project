*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 HEL
${destination}            PEK


*** Test Case ***
20. iOS - Guest login, multipax, child and infant, purchase
    [Tags]                                                PNR20    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              30         50                                        
    Book Flight On Finnair Operated Flight                  3          L     
    Set Return Date    
    Book Return Flight                                      3          L     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_olli_joki}
    Add Passenger With Infant    ${pax_anna_joki}    IIRIS
    Add Child Passenger    ${pax_ilpo_joki_child}
    Price Itinerary And Select First Option 3 pax And Infant
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}

***Comments*****
pax_olli_joki 
pax_anna_joki 
pax_ilpo_joki_child 