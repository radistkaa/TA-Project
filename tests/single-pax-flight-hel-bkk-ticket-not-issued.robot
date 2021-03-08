*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}            HEL
${destination}       BKK
${passenger name}           ${pax_aapo_automaatio}
${template}                 guest-journey-ticket-not-issued

*** Test Cases ***
Create Flight From Bangkok To Helsinki
    [Documentation]     create booking but do not issue ticket
    [Tags]              guest-journey-ticket-not-issued
    Prepare Variables   ${origin}    ${destination}
    Create Random Flight Date Next 100 To 250 Days
    Book Flight On Finnair Operated Flight
    Add Passenger To Booking    ${passenger name}
    Price Itinerary
    Set Ticket Time Limit to OK
    Set Cash As Formal Of Payment
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    
