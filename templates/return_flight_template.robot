*** Settings ***
Resource        ../resources/settings.robot

*** Keywords ***
Create Return Flight Template
    [Documentation]     book return flight
    ...                 pax         - name of passenger
    ...                 origin      - name of origin city       - use short code ie HEL
    ...                 destination - name of destination city  - use short code ie HEL
    ...                 template    - name of the test flight template
    [Arguments]  ${pax}     ${origin}   ${destination}  ${template}    ${number of paxes}=1     ${flight class}=Y  ${departure}=10  ${return}=40
    Prepare Variables   ${origin}   ${destination}
    Create Random Flight Date Next X To Y Days  ${departure}  ${return}
    Set Return Date
    Book Flight On Finnair Operated Flight  ${number of paxes}  ${flight class}
    Book Return Flight                      ${number of paxes}  ${flight class}     ${return_day}   ${return_month}
    Add Passenger To Booking    ${pax}
    Price Itinerary
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    