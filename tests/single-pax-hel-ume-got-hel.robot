*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}                HEL
${destination}           UME
${second flight destination}    GOT
${booking class}                Y
${passenger name}               ${pax_berta_basic}
${template}                     regression-testcase-5


*** Test Cases ***
Create Flight From Helsinki To Umea And From Gothenburg To Helsinki
    [Documentation]     HEL - UME -ARNK - GOT -HEL
    [Tags]              regression-testcase-5
    Prepare Variables   ${origin}    ${destination}
    Create Random Flight Date Next X To Y Days  90  170
    Set Return Date     1
    # outbound
    Cryptic Command Verify Output       AN${day}${month_as_string}${origin}${destination}/AAY   1
    Cryptic Command Verify Output       SS1${booking class}1   1
    Arrival Unknown Segment
    # inbound
    Cryptic Command Verify Output       AN${return_day}${return_month}${second flight destination}${origin}/AAY   1
    Cryptic Command Verify Output       SS1${booking class}1   1
    Add Passenger To Booking            ${passenger name}
    Price Itinerary
    Validate And Issue Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    
