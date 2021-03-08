# Scope PNR 1:
# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu
# iOS - Logged in, OW	HELAY0708	OW	BCN-HEL	Any	None	1 adt	Sähäkkä/Siiri Ms	690876149	Basic	Yes	Yes	EUR

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}                 HEL
${destination}            DEL
${MA FF-number}       690876156
${TT FF-number}       677677247

*** Test Case ***
9. iOS - Logged in, business upgrade with upgrade benefit, single pax
    [Tags]                                                PNR9    PNR0
    Prepare Variables                                   ${origin}     ${destination}
    Create Random Flight Date Next X To Y Days              4         30                                        
    Book Flight On Finnair Operated Flight                  1          M
    Set Return Date    
    Book Return Flight                                      1          L     ${return_day}    ${return_month} 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Validate Flight Day
    Save result to file    ${TEST NAME}

    







