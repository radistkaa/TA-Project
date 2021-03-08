*** Settings ***
Resource        ../resources/settings.robot


*** Keywords ***
Create Singlepax Flight
    [Documentation]     create single pax flight
    ...                 pax         - name of passenger
    ...                 origin      - name of origin city       - use short code ie HEL
    ...                 destination - name of destination city  - use short code ie HEL
    ...                 template    - name of the test flight template
    [Arguments]  ${pax}     ${origin}   ${destination}  ${template}     ${remove line}=False    ${departure}=100    ${return}=250
    Prepare Variables   ${origin}   ${destination}
    Create Random Flight Date Next X To Y Days  ${departure}    ${return}
    Book Flight On Finnair Operated Flight
    Add Passenger To Booking    ${pax}
    Price Itinerary
    Validate Ticket
    Remove Line From Booking    ${remove line}
    Print Booking Reference
    Validate Flight Day
    Add Date Created Remark
