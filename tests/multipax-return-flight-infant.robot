*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}            HEL
${destination}       PEK
${number of paxes}          3
${flight class}             K
${template}                 regression-testcase-21-ios

*** Test Cases ***
Create Multipax Return Flight With Infant
    [Documentation]     create return flight with infant
    [Tags]              regression-testcase-21-ios
    Prepare Variables                           ${origin}   ${destination}
    Create Random Flight Date Next X To Y Days  15     45
    Set Return Date
    Book Flight On Finnair Operated Flight      ${number of paxes}  ${flight class}
    Book Return Flight                          ${number of paxes}  ${flight class}     ${return_day}   ${return_month}
    Add Passenger To Booking                    ${pax_jeanie_west}
    Add Passenger With Infant                   ${pax_willie_west}
    Add Second Passenger To Booking             ${pax_michelle_west}
    Price Itinerary And Select First Option 3 pax And Infant
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    