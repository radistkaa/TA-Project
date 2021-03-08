*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}            HEL
${destination}       BKK
${passenger name}           ${pax_emma_adelaide}
${template}                 xbgg-extra-bag-adelaide


*** Test Cases ***
Create Flight From Helsinki To Bangkok With XBGG
    [Documentation]     XBGG - Excess piece special charge
    [Tags]              xbgg-extra-bag-adelaide
    Prepare Variables   ${origin}    ${destination}
    Create Random Flight Date Next 100 To 250 Days
    Book Flight On Finnair Operated Flight
    Add Passenger To Booking    ${passenger name}
    Price Itinerary
    Validate And Issue Ticket
    Add Excess Price Special Charge XBGG For Pax 1
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    
