*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
${origin}                 HEL
${destination}            TLL
#${​​custom filter}​​          ${EMPTY}  #" "


*** Keyword ***
Fail Over Book Flight
    Create Random Flight Date Next 100 To 250 Days
    Book Flight On Finnair Operated Flight     1   Y       



*** Test Case ***

PNR21 iOS
        [Tags]                                                remi1
        Prepare Variables                                   ${origin}     ${destination}
        wait until keyword succeeds  10x  1s  Fail Over Book Flight      
*** comment ***
        Book Via Flight On Finnair Operated Flight              2          Y        HEL                                     
        Set Return Date    
        Book Return Flight                                      2          Y     ${return_day}    ${return_month} 
        Add Passenger To Booking    ${pax_john_smith}
        Add Second Passenger To Booking    ${pax_tim_jones}
        Price Itinerary
        Validate Ticket
        Print Booking Reference
        Validate Flight Day
        Append To File                            Results/generatedPNRs.txt     ${\n}PNR21 iOS: ${booking_reference} was created: ${date}    encoding=UTF-8
        Log To Console                            ${\n} >>>>>> Result: ${booking_reference} saved to /robot_files/Results/generatedPNRs.txt <<<<<<

