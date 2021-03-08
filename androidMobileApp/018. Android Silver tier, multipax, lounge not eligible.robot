*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${origin}                 RVN
${destination}            HEL
${MA FF-number}       690875976         #DON'T CHANGE THIS ACCOUNT NUMBER
${TT FF-number}       680113180



*** Test Case ***
18. Android - ilver tier, multipax, lounge not eligible
    [Tags]                                                PPNR018    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              12         50                                        
    Book Flight On Finnair Operated Flight                  2          L     
    Set Return Date    
    Book Return Flight                                      2          L     ${return_day}    ${return_month} 
    Add Passenger To Booking    ${pax_temu_saari}
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}