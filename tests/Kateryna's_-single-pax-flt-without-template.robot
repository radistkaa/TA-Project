*** Settings ***
#Resource        ../templates/Katya_SP_template.robot
Resource        ../resources/settings.robot
Test Setup       Login To Amadeus
Test Teardown    Logout From Amadeus


*** Test Cases ***

Flight From Helsinki To Bangkok
    [Tags]                                                             Katyas_demo
    Prepare Variables                                                  HEL                                         BKK    # Converts HEL to Helsiki, LHR to London
    Create Random Flight Date Next X To Y Days                         150                                         300
    Book Flight On Finnair Operated Flight On Certain Flight Number    1                                           M      141
    Add Passenger To Booking                                           ${pax_kateryna_vinokurova}
    Price Itinerary
    Validate And Issue Ticket
    Print Booking Reference
