*** Settings ***
Resource        ../resources/settings.robot

*** Keywords ***
Create Multipax Return Flight
    [Documentation]     create multi pax return flight
    ...                 pax         - name of passenger
    ...                 pax2        - name of second passenger
    ...                 origin      - name of origin city       - use short code ie HEL
    ...                 destination - name of destination city  - use short code ie BKK
    ...                 template    - name of the test flight template
    [Arguments]  ${pax}     ${pax2}     ${origin}   ${destination}  ${template}     ${departure}=10     ${return}=50    ${number of paxes}=2  ${flight class}=K
    Prepare Variables                           ${origin}   ${destination}
    Create Random Flight Date Next X To Y Days  ${departure}     ${return}
    Set Return Date
    Book Flight On Finnair Operated Flight      ${number of paxes}  ${flight class}
    Book Return Flight                          ${number of paxes}  ${flight class}     ${return_day}   ${return_month}
    Add Passenger To Booking                    ${pax}
    Add Second Passenger To Booking             ${pax2}
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    
    
    
    
    