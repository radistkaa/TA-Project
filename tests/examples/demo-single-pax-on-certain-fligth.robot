*** Settings ***
Resource        ${EXECDIR}${/}robot_files${/}resources${/}settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}            HEL
${destination}       LHR
${passenger name}           ${pax_emma_adelaide}
${template}                 demo
${booking class}            Y
${flight number}            1337
${custom filter}            ${space}*AY

*** Test Cases ***
Demo Create Flight From Helsinki To London
    [Documentation]     DEMO - test flight on certain flight number
    [Tags]              demo
    Prepare Variables   ${origin}    ${destination}
    Create Random Flight Date Next 100 To 250 Days
    Book Flight On Finnair Operated Flight On Certain Flight Number     1   ${booking class}   ${flight number}
    Add Passenger To Booking    ${passenger name}
    Price Itinerary
    Validate And Issue Ticket
    #Add Excess Price Special Charge XBGG For Pax 1
    Print Booking Reference
    Validate Flight Day


Demo Book Flight With Custom Filter
    [Documentation]     DEMO - how to book flight with *AY prefix
    ...                 default filter is AY
    [Tags]              demo-2
    Prepare Variables   UME    HEL
    Create Random Flight Date Next 100 To 250 Days
    Book Flight On Finnair Operated Flight     1   ${booking class}   ${custom filter}
    Add Passenger To Booking                   ${passenger name}
    Price Itinerary
    Validate And Issue Ticket
    Print Booking Reference
    Validate Flight Day
