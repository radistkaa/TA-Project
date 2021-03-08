*** Settings ***
Resource        ../resources/settings.robot

Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Variables ***
${origin}                OUL
${destination}           PVG
${booking class}                Y
${passenger name}               ${pax_testi_automaatio}
${template}                     regression-testcase-3-android


*** Test Cases ***
Create Flight From Oulu To Shnaghai Via Helsinki Return From Beijing
    [Tags]              regression-testcase-3-android
    Prepare Variables                           ${origin}    ${destination}
    Create Random Flight Date Next X To Y Days  30  90
    Set Return Date
    # outbound
    Book Via Flight On Finnair Operated Flight  1   ${booking class}
    # inbound from PEK
    Book Return Flight  1   H  ${return_day}   ${return_month}     PEK     ${origin}
    Arrival Unknown Segment
    Add Passenger To Booking            ${passenger name}
    Price Itinerary
    Validate And Issue Ticket
    Print Booking Reference
    Validate Flight Day





