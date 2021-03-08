*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}            KIX
${destination}       HEL
${number of paxes}          3
${flight class}             V
${template}                 regression-testcase-6

*** Test Cases ***
Create Multipax Return Flight With Infant And Child
    [Documentation]     create multipax return fligth with infant and child
    [Tags]              regression-testcase-6
    Prepare Variables                           ${origin}   ${destination}
    Create Random Flight Date Next X To Y Days  60     150
    Set Return Date
    Book Flight On Finnair Operated Flight      ${number of paxes}  ${flight class}
    Book Return Flight                          ${number of paxes}  ${flight class}     ${return_day}   ${return_month}
    Add Passenger To Booking                    ${pax_emma_adelaide}
    Add Passenger With Infant                   ${pax_sukunimi}
    Add Child Passenger                         ${pax_charlie_child}
    Price Itinerary
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    
    