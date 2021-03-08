# https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EdRhZMVdHTRNmwD9CDeU8yUB342dBxJgOKHrLGMknJ8L2A?e=NMiftu

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
${origin}         HEL
${destination}    UME
${MA FF-number}       690876156        
${TT FF-number}       677677247
${custom filter}         ${space}*AY


*** Test Case ***
4. iOS - Logged in, wetlease flights, OJ
    [Tags]                                          PNR4    PNR0
    Prepare Variables                                HEL      UME
    Create Random Flight Date Next X To Y Days        15       40                            
    Book Flight On Finnair Operated Flight            2         M          ${custom filter}
    Arrival Unknown Segment
    Set Return Date 
    Book Return Flight                                2         M    ${return_day}    ${return_month}      GOT     HEL
    Add Passenger To Booking                              ${pax_anders_svensson}
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}
 


*** Comments ***
Need to use the custom filter to book the weatlease flight.
Using the FXP pricing command need to choose the Option and number of paxes, 
the command "Price Itinerary" doesn't work here because of the ARNK.





