*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 CPH
${destination}            HEL
${MA FF-number}       690875851    #DON'T CHANGE THIS NUMBER
${TT FF-number}       676393903  
${MA ffnumber_junior}    690876057    #DON'T CHANGE THIS NUMBER
${TT ffnumber_junior}    692732563

  

*** Test Case ***
7. Android - Logged in platinum tier, complimentary seats, meals multipax
    [Tags]                                                PNR07    PNR_android
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight In This Month                                        
    Book Flight On Finnair Operated Flight                  3          S
    Set Return Date    
    Book Return Flight                                      3          K     ${return_day}    ${return_month} 
    Add Child Passenger    ${pax_paul_ruse_fbstest_junior}  
    #Add Child Passenger    ${pax_janne_junior} 
    Add Frequent Flyer Number To Booking        ${TT ffnumber_junior}    
    #Add Frequent Flyer Number To Booking        ${MA ffnumber_junior}  
    Add Second Passenger To Booking             ${pax_michelle_west} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MT FF-number}    
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}     
    Price Itinerary With Best Price
    Validate Ticket 
    Print Booking Reference
    Save result to file    ${TEST NAME}