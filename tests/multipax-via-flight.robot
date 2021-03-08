*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}                CPH
${destination}           HKG
${booking class}                V
${template}                     regression-testcase-7


*** Test Cases ***
Create Multipax Return Flight From Copenhagen To Hong Kong Via Helsinki
    [Tags]              regression-testcase-7
    [Documentation]     create multipax flight from Copenhagen To Hong Kong Via Helsinki
    Prepare Variables   ${origin}    ${destination}
    Create Random Flight Date Next X To Y Days  20  60
    Set Return Date     3
    # outbound
    Cryptic Command Verify Output       AN${day}${month_as_string}${origin}${destination}/AAY   1
    Cryptic Command Verify Output       SS3V1   1
    # inbound
    Cryptic Command Verify Output       AN${return_day}${return_month}${destination}${origin}/AAY   1
    Cryptic Command Verify Output       SS3V1   1
    Add Passenger To Booking            ${pax_arvo_platina}
    Add Second Passenger To Booking     ${pax_janne_junior}
    Add Second Passenger To Booking     ${pax_liisa_vaha_jarvi}
    Price Itinerary
    Price Itinerary With Best Price
    Validate And Issue Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    
