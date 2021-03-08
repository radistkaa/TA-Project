*** Settings ***
Library         amadeus.py
Library         finnairOperatedFlight.py
Library         String


*** Variables ***
${session_id}
${security_token}
${sequence_number}  0
@{nationalities}    EST    RUS    LVA    GBR    UKR    FRA    USA    IND    AUS    CZE    NOR    SWE    
@{months}           JAN    FEB    MAR    APR    MAY    JUN    JUL    AUG    SEP    OCT    NOV    DEC
@{infant_months}    JAN    FEB    MAR    APR    MAY    JUN    JUL    AUG    SEP    OCT 
${numbers}          1234567890

*** Keywords ***
Login To Amadeus
    [Arguments]  ${office_code}=hel    
    ${session_id}   ${security_token}=  amadeus login      HELAY0671  
    set global variable  ${session_id}
    set global variable  ${security_token}
    set global variable  ${sequence_number}     1

Login To Amadeus For Group bookings
    [Arguments]  ${office_code}=hel
    ${session_id}   ${security_token}=  amadeus login      HELAY0671    RC
    set global variable  ${session_id}
    set global variable  ${security_token}
    set global variable  ${sequence_number}     1


Execute Cryptic Command
    [Arguments]  ${command}     ${session_id}=${session_id}  ${security_token}=${security_token}   ${sequence_number}=${sequence_number}
    ${output}=  execute amadeus command     ${command}     ${session_id}  ${security_token}    ${sequence_number}
    log to console  ${output}
    ${sequence_number} =    Evaluate    ${sequence_number}+1
    set global variable  ${sequence_number}
    [Return]  ${output}


Execute Multiple Cryptic Commands
    [Documentation]     execute multiple cryptic commands in chain
    ...                 commands are separated with ::
    ...
    ...                 example:
    ...                 Execute Multiple Cryptic Commands   dd::rtFAKEPN::somecommand::othercommand
    [Arguments]  ${commands}     ${session_id}=${session_id}  ${security_token}=${security_token}   ${sequence_number}=${sequence_number}
    @{commands list}=   split string  ${commands}    ::
    FOR     ${command}  IN  @{commands list}
    ${output}=  execute amadeus command     ${command}     ${session_id}  ${security_token}    ${sequence_number}
    log to console  ${output}
    END
    ${sequence_number} =    Evaluate    ${sequence_number}+1
    set global variable  ${sequence_number}
    [Return]  ${output}


Logout From Amadeus
    [Documentation]  logout from amadeus and cancel booking if testcase failed!!!
    [Arguments]  ${session_id}=${session_id}  ${security_token}=${security_token}   ${sequence_number}=${sequence_number}
    ${x}=  Get Variable Value  ${booking_reference}   not-set
    Run Keyword If Test Failed  log to console  testcase failed booking ${x} should be cancelled...
    # CANCEL PNR
    Run Keyword If Test Failed  Cancel PNR  ${x}
    ${status_code}=  amadeus logout  ${session_id}   ${security_token}   ${sequence_number}


Cryptic Command Verify Output
    [Arguments]  ${command}=dd  ${expected_outcome}=SYSTEM TIME IS
    log to console  \n=======================
    log to console  ==== COMMAND: ${command}
    log to console  =======================\n
    ${stdout}=  Execute Cryptic Command  ${command}
    should contain  ${stdout}   ${expected_outcome}
    [Return]  ${stdout}


Execute Amadeus Cryptic Command
    [Arguments]  ${command}=dd
    log to console  command: ${command}
    ${stdout}=  Execute Cryptic Command  ${command}
    [Return]  ${stdout}

####
#### AMADEUS
####
Set CC As Formal Of Payment
    [Documentation]  execute FPCC and parse booking reference from output
    [Arguments]  ${command}=FP CCVI4000000000000002/1020*CV737;ER
    ${stdout}=  Execute Cryptic Command  ${command}
    set local variable  ${tmp file}     ${TEMPDIR}/amadeusPNRcash.txt
    create file  ${tmp file}  ${stdout}
    ${booking_reference}=   parse booking reference    ${tmp file}
    log to console          refloc: >>>>> ${booking_reference} <<<<<
    set global variable     ${booking_reference}



Set Cash As Formal Of Payment
    Execute Amadeus Command FPCASH


Execute Amadeus Command FPCASH
    [Documentation]  execute FPCASH and parse booking reference from output
    [Arguments]  ${command}=FPCASH;ER
    ${stdout}=  Execute Cryptic Command  ${command}
    set local variable  ${tmp file}     ${TEMPDIR}/amadeusPNRcash.txt
    create file  ${tmp file}  ${stdout}
    ${booking_reference}=   parse booking reference    ${tmp file}
    log to console          refloc: >>>>> ${booking_reference} <<<<<
    set global variable     ${booking_reference}


Price PNR And Create TST
    [Documentation]  price pnr and create tst - without tst ticket cannot be issued
    Cryptic Command Verify Output     FXP    AL FLGT ${SPACE}BK T DATE ${SPACE}TIME ${SPACE}FARE BASIS

Price Itinerary For the Premium Economy Cabin For 1 PAX
    Cryptic Command Verify Output     FXP/R,U175539  1
    Cryptic Command Verify Output     FXT01  1


Price Itinerary For the Premium Economy Cabin Multipax
    ${stdout}=  Cryptic Command Verify Output     FXP/R,U175539  1
    run keyword if  "* P1-2" in """${stdout}"""     Cryptic Command Verify Output     FXT01/P1-2  1
    run keyword if  "* P1-3" in """${stdout}"""     Cryptic Command Verify Output     FXT01/P1-3  1



Price Itinerary
    ${stdout}=  Cryptic Command Verify Output     FXP  1
    run keyword if  "* P1" in """${stdout}"""     Cryptic Command Verify Output     FXT01  1


Price Itinerary With Different Currency
    [Arguments]    ${currency_name}
    ${stdout}=  Cryptic Command Verify Output     FXP/R,FC-${currency_name}  1
    #run keyword if  "* P1" in """${stdout}"""     Cryptic Command Verify Output     FXT01  1


Price Itinerary And Select First Option
    Cryptic Command Verify Output     FXP  1
    Cryptic Command Verify Output     FXT01  1


Price Itinerary And Select First Option 2 pax
    ${stdout}=  Cryptic Command Verify Output     FXP  1
    run keyword if  "* P1-2" in """${stdout}"""     Cryptic Command Verify Output     FXT01/P1-2  1


Price Itinerary And Select First Option 3 pax
    Cryptic Command Verify Output     FXP  1
    Cryptic Command Verify Output     FXT01/P1-3  1
    Cryptic Command Verify Output     TQT  1


Price Itinerary And Select First Option 3 pax And Infant
    Cryptic Command Verify Output     FXP  1
    Cryptic Command Verify Output     FXT01/P1,3//02/P2//03/P1  1
    #Cryptic Command Verify Output    FXT01/P1-3//02/P3  1
    # show TST
    Cryptic Command Verify Output     TQT  1


Price Itinerary With Best Price
    Cryptic Command Verify Output     FXB  1

Validate And Issue Ticket with CC
    Validate Ticket with CC

Validate Ticket with CC
     [Documentation]  no cancellation queue, set formal of payment to cash and issue ticket
     # no cancellation queue
     Cryptic Command Verify Output     TKOK    TK OK
     # format of payment
     Set CC As Formal Of Payment
     Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
     # issue ticket
     ${stdout}=  execute amadeus cryptic command     TTX
     ${stdout}=  execute amadeus cryptic command     TTP
     Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  IR
     ${stdout}=  Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  TTP
     # validate that ticket is issued
     wait until keyword succeeds  5x     1s  Cryptic Command Verify Output     RT${booking_reference}  /ETAY/EUR

Validate And Issue Ticket
    Validate Ticket

Validate Ticket
    [Documentation]  no cancellation queue, set formal of payment to cash and issue ticket
    # no cancellation queue
    Cryptic Command Verify Output     TKOK    TK OK
    # format of payment
    Set Cash As Formal Of Payment
    Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    # issue ticket
    ${stdout}=  execute amadeus cryptic command     TTP
    Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  IR
    ${stdout}=  Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  TTP
    # validate that ticket is issued
    wait until keyword succeeds  5x     1s  Cryptic Command Verify Output     RT${booking_reference}  /ETAY/EUR

 Validate Ticket For The Extra Seat
    [Documentation]  no cancellation queue, set formal of payment to cash and issue ticket
    # no cancellation queue
    # format of payment
    Cryptic Command Verify Output     TKOK    TK OK
    Set Cash As Formal Of Payment
    Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    Cryptic Command Verify Output     TQT                                                         1
    Cryptic Command Verify Output     TTK/FEUR1886                                                1   
    Cryptic Command Verify Output     TTI/B BNN0S9FZ EX                                           1
    Cryptic Command Verify Output     TTK/T1/CHEL AY SIN Q1063.20 1063.20EUR2126.40END            1
    Cryptic Command Verify Output     ER                                                          1
    #Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    # issue ticket
    ${stdout}=  execute amadeus cryptic command     TTP
    Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  IR
    ${stdout}=  Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    execute amadeus cryptic command  TTP
    # validate that ticket is issued
    wait until keyword succeeds  5x     1s  Cryptic Command Verify Output     RT${booking_reference}  /ETAY/EUR   


Cancel PNR
    [Documentation]  cancel pnr
    [Arguments]  ${pnr}
    run keyword if  '${pnr}' != 'not-set'       log to console  cancelling pnr ${pnr}
    ...     ELSE    log to console              pnr is not set so no need for cancelling pnr
    log to console  ******************************************
    run keyword if  '${pnr}' != 'not-set'       Cancel Booking With Cryptic    ${pnr}


Cancel Booking With Cryptic Katya
    [Arguments]  ${pnr}
    Cryptic Command Verify Output     RT${pnr}  RP/HELAY
    Execute Amadeus Cryptic Command     XI
    ${stdout}=  Execute Amadeus Cryptic Command    ET
    login to amadeus  ${stdout}
    ${stdout}=  Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    sleep  3
    Execute Amadeus Cryptic Command  RT${pnr}
    Execute Amadeus Cryptic Command  XI
    Execute Amadeus Cryptic Command  ET


Cancel Booking With Cryptic
    [Arguments]  ${pnr}
    Cryptic Command Verify Output     RT${pnr}  RP/HELAY
    Cryptic Command Verify Output     XI    2 APE
    ${stdout}=  execute amadeus cryptic command     ET
    login to amadeus  ${stdout}
    ${stdout}=  Run keyword if  "SIMULTANEOUS CHANGES TO PNR" in """${stdout}"""    sleep  3
    execute amadeus cryptic command  RT${pnr}
    execute amadeus cryptic command  XI
    execute amadeus cryptic command  ET


Book Flight On Finnair Operated Flight
    [Arguments]  ${number_of_paxs}=1    ${class}=Y  ${custom filter}=${space}AY
    # FILTER AY - Finnair Flights
    # FILTER FN - non stop
    ${stdout}=  Cryptic Command Verify Output       AN${day}${month_as_string}${flight origin}${flight destination}/AAY/FN   1
    set local variable  ${tmp file}     ${TEMPDIR}/finnairflight.txt
    create file     ${tmp file}   ${stdout}
    ${flight_id}=  finnair flight   ${tmp file}     ${custom filter}
    log to console  ***************************
    log to console  * - ${flight_id} - is pure AY flight
    log to console  ***************************
    ${stdout}=  Cryptic Command Verify Output       SS${number_of_paxs}${class}${flight_id}   1
    should not contain  ${stdout}   NOT AVAILABLE AND WAITLIST CLOSED   NO SEATS AVAILABLE ON THIS FLIGHT ON CLASS: ${class}


Book Flight On Finnair Operated Flight On Certain Flight Number
    [Arguments]  ${number_of_paxs}=${seats}    ${class}=${booking class}  ${flight number}=${flight number}    ${custom filter}=${space}AY    ${origin}=${flight origin}    ${destination}=${flight destination} 
    # FILTER AAY435 - Finnair flight AY435
    ${stdout}=  Cryptic Command Verify Output       AN${day}${month_as_string}${origin}${destination}/AAY${flight number}   1
    ${rnd}=	    Generate Random String
    set local variable  ${tmp file}     ${TEMPDIR}/finnairflight${rnd}.txt
    create file     ${tmp file}   ${stdout}
    ${flight_id}=  finnair flight    ${tmp file}        ${custom filter}
    log to console  ***************************
    log to console  * - ${flight_id} - is pure AY flight
    log to console  ***************************
    ${stdout}=  Cryptic Command Verify Output       SS${number_of_paxs}${class}${flight_id}     1
    should not contain  ${stdout}   NOT AVAILABLE AND WAITLIST CLOSED   NO SEATS AVAILABLE ON THIS FLIGHT ON CLASS: ${class}

Book Flight On NON-PURE Finnair Operated Flight On Certain Flight Number
    [Arguments]  ${number_of_paxs}=${seats}    ${class}=${booking class}  ${flight number}=${flight number}    ${custom filter}=${space}*AY    ${origin}=${flight origin}    ${destination}=${flight destination} 
    # FILTER AAY435 - Finnair flight AY435
    ${stdout}=  Cryptic Command Verify Output       AN${day}${month_as_string}${origin}${destination}/AAY${flight number}   1
    ${rnd}=	    Generate Random String
    set local variable  ${tmp file}     ${TEMPDIR}/finnairflight${rnd}.txt
    create file     ${tmp file}   ${stdout}
    ${flight_id}=  finnair flight    ${tmp file}        ${custom filter}
    log to console  ***************************
    log to console  * - ${flight_id} - is pure AY flight
    log to console  ***************************
    ${stdout}=  Cryptic Command Verify Output       SS${number_of_paxs}${class}${flight_id}     1
    should not contain  ${stdout}   NOT AVAILABLE AND WAITLIST CLOSED   NO SEATS AVAILABLE ON THIS FLIGHT ON CLASS: ${class}



Book Return Flight
    [Arguments]  ${seats}=1     ${class}=V  ${departure day}=${day}   ${departure month}=${month_as_string}  ${return_from}=${flight destination}     ${return_dst}=${flight origin} 
    [Documentation]  book return flight
    ${tmp file}=    set variable    ${TEMPDIR}/fclassflight.txt
    ${stdout}=  Cryptic Command Verify Output       AN${departure day}${departure month}${return_from}${return_dst}/AAY   1
    create file     ${tmp file}   ${stdout}
    ${flight with class}=  verify that certain class is open    ${tmp file}  ${class} 
    log to console  *****************************************************
    log to console  ${flight with class} has open seats on class ${class}
    log to console  *****************************************************
    ${stdout}=  Cryptic Command Verify Output       SS${seats}${class}${flight with class}   1
    should not contain  ${stdout}   NOT AVAILABLE AND WAITLIST CLOSED


Book Via Flight On Finnair Operated Flight
    [Arguments]  ${number_of_paxs}=1    ${class}=Y  ${via_city}=HEL
    # FILTER AY - Finnair Flights
    # FILTER /X - flight via certain city
    ${stdout}=  Cryptic Command Verify Output       AN${day}${month_as_string}${flight origin}${flight destination}/AAY/X${via_city}   1
    ${rnd}=	    Generate Random String
    set local variable  ${tmp file}     ${TEMPDIR}/finnairflight${rnd}.txt
    create file     ${tmp file}   ${stdout}
    ${flight_id}=  finnair flight    ${tmp file}
    log to console  ***************************
    log to console  * - ${flight_id} - is pure AY flight
    log to console  ***************************
    ${stdout}=  Cryptic Command Verify Output       SS${number_of_paxs}${class}${flight_id}   1
    should not contain  ${stdout}   NOT AVAILABLE AND WAITLIST CLOSED   NO SEATS AVAILABLE ON THIS FLIGHT ON CLASS: ${class}


Validate That Booking Contains One Checked Bag
    [Arguments]  ${booking_reference}
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${status}=  run keyword and return status   Cryptic Command Verify Output     TQT    1PC
    run keyword if  "${status}" == "False"  Cancel PNR  ${booking_reference}
    run keyword if  "${status}" == "False"  FAIL  INCORRECT BAGGAGE COUNT!


Add Passenger To Booking
    [Documentation]  add passenger to booking - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}
    Cryptic Command Verify Output     NM1${pax_name[1]}/${pax_name[0]} ${pax_name[2]};APM-${pax_name[3]};APE-${pax_name[4]}     1.${pax_name[1]}/${pax_name[0]} ${pax_name[2]}

Add Second Passenger To Booking
    [Documentation]  add passenger to booking - no output validation
    [Arguments]  ${pax_name}=${pax_emma_adelaide}
    Cryptic Command Verify Output     NM1${pax_name[1]}/${pax_name[0]} ${pax_name[2]};APM-${pax_name[3]}                        1.


Add Passenger With Infant
    [Documentation]  add passenger with infant to booking - no output validation
    [Arguments]  ${pax_name}    ${infant_name}=${pax_rebeca_infant} 
    Cryptic Command Verify Output     NM1${pax_name[1]}/${pax_name[0]} ${pax_name[2]}(INF${infant_name[1]}/${infant_name[0]}/10JAN20)            1.

Add Child Passenger
    [Arguments]  ${pax}    ${expected outocome}=1.
    Cryptic Command Verify Output               NM1${pax[1]}/${pax[0]}(CHD/11SEP16);APM-${pax[3]}           ${expected outocome}


Add Frequent Flyer Number To Booking
    [Arguments]  ${ffnumber}
    #Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    #Cryptic Command Verify Output     SRFQTVAY-AY${ffnumber}/P1   1
    Cryptic Command Verify Output     ffnay-${ffnumber}/P1   1
    #Cryptic Command Verify Output     ET    END OF TRANSACTION COMPLETE

Add Pax name from Frequent Flyer Number To Booking
    [Arguments]  ${ffnumber}
    Cryptic Command Verify Output     FFAAY-${ffnumber}   1
    #Cryptic Command Verify Output     ER    1
    #Cryptic Command Verify Output     ET    END OF TRANSACTION COMPLETE
    #Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY

Add Passenger With Extra Seat
    [Documentation]  add passenger with infant to booking - no output validation
    [Arguments]  ${pax_name}    ${line number}=6
    Cryptic Command Verify Output     NM2${pax_name[1]}/${pax_name[0]} ${pax_name[2]}(IDEXST)/EXST;APM-${pax_name[3]};APE-${pax_name[4]}    1.
    Cryptic Command Verify Output     SR EXST-PERSONAL COMFORT/P1    1
    Cryptic Command Verify Output     ${line number}/KK              1                     
    Cryptic Command Verify Output     ${line number}/HK              1

Add DOCS
    [Documentation]  add DOCS - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}
    Pick Random Nationality
    Pick Random Day Of Birth
    Pick Random Month Of Birth
    Pick Random Year Of Birth
    Pick Random Passport Expiration Day
    Pick Random Passport Expiration Month
    Pick Random Passport Expiration Year
    Pick Random Passport Number
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth}${year of birth}-${pax_name[5]}-${expiration day}${expiration month}${expiration year}-${pax_name[1]}-${pax_name[0]}/P1    1

Add DOCS for PAX with Infant
    [Documentation]  add DOCS - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}       ${infant_name}=${pax_rebeca_infant} 
    Pick Random Nationality
    Pick Random Day Of Birth
    Pick Random Month Of Birth
    Pick Random Year Of Birth
    Pick Random Passport Expiration Day
    Pick Random Passport Expiration Month
    Pick Random Passport Expiration Year
    Pick Random Passport Number
    Pick Random Year Of Birth of infant
    Pick Random Month Of Birth for Infant
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth}${year of birth}-${pax_name[5]}-${expiration day}${expiration month}${expiration year}-${pax_name[1]}-${pax_name[0]}/P1    1
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth for infant}${year of birth infant}-${infant_name[5]}-${expiration day}${expiration month}${expiration year}-${infant_name[1]}-${infant_name[0]}/P1    1



<Add DOCS For Child
    [Documentation]  add DOCS - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}
    Pick Random Nationality
    Pick Random Day Of Birth
    Pick Random Month Of Birth
    Pick Random Year Of Birth For Child
    Pick Random Passport Expiration Day
    Pick Random Passport Expiration Month
    Pick Random Passport Expiration Year
    Pick Random Passport Number
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth}${year of birth child}-${pax_name[5]}-${expiration day}${expiration month}${expiration year}-${pax_name[1]}-${pax_name[0]}/P1    1>

Add DOCS For 3th pax child 
    [Documentation]  add DOCS - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}
    Pick Random Nationality
    Pick Random Day Of Birth
    Pick Random Month Of Birth
    Pick Random Year Of Birth For Child
    Pick Random Passport Expiration Day
    Pick Random Passport Expiration Month
    Pick Random Passport Expiration Year
    Pick Random Passport Number
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth}${year of birth child}-${pax_name[5]}-${expiration day}${expiration month}${expiration year}-${pax_name[1]}-${pax_name[0]}/P3    1

Add DOCS For 2nd PAX
    [Documentation]  add DOCS - default pax Emma Adelaide
    [Arguments]     ${pax_name}=${pax_emma_adelaide}
    Pick Random Nationality
    Pick Random Day Of Birth
    Pick Random Month Of Birth
    Pick Random Year Of Birth
    Pick Random Passport Expiration Day
    Pick Random Passport Expiration Month
    Pick Random Passport Expiration Year
    Pick Random Passport Number
    Cryptic Command Verify Output    SRDOCS AY HK1-P-${random nationality}-${passport number}-${random nationality}-${day of birth}${month of birth}${year of birth}-${pax_name[5]}-${expiration day}${expiration month}${expiration year}-${pax_name[1]}-${pax_name[0]}/P2    1


Add Excess Price Special Charge XBGG For Pax 1
    [Arguments]  ${line number}=6
    Cryptic Command Verify Output    RT${booking_reference}    RP/HELAY
    Cryptic Command Verify Output     SR XBGG/P1            /SSR XBGG
    Cryptic Command Verify Output     FXG          /
    Cryptic Command Verify Output     TQM          /
    Cryptic Command Verify Output     ${line number}/KK          /
    Cryptic Command Verify Output     TTM          /
    Cryptic Command Verify Output     TTM          /


Add Seat For 1 PAX
    [Arguments]    ${seat number}    ${seat letter}    ${segment}   ${line number}=6
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           ST/${seat number}${seat letter}/P1/S${segment};ER
    ${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    run keyword if  '${contains}' == 'True'   Price And Issue Ancillary    ${line number}   RQST

Add Seat For 2 PAXes
    [Arguments]    ${seat numbers}    ${seat letters}    ${segment}   ${line number}=6
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           ST/${seat numbers}${seat letters}/P1-2/S${segment};ER
    ${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    run keyword if  '${contains}' == 'True'   Price And Issue Ancillary    ${line number}   RQST

Add Meal For Pax 1
    [Arguments]  ${meal}    ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SR${meal}/P1;ER
    ${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    run keyword if  '${contains}' == 'True'   Price And Issue Ancillary     ${line number}   ${meal}

Add WheelChair
    [Arguments]    ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRWCHR/P1;ER
 #   ${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   WCHR

Add UMNR
    [Arguments]    ${line number}=7
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRUMNR-UM07/P1;ER
    Cryptic Command Verify Output       ${line number}/KK        1
    Cryptic Command Verify Output       ${line number}/HK        1
    Cryptic Command Verify Output     OS AY DEP CTC HEL 212 555 1212/MRS ANNA SMITH/MOTHER        1
    Cryptic Command Verify Output     OS AY ARR CTCH SIN 212 555 5555/MR JOE SMITH/FATHER         1
    #${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   UMNR

Add 12H Internet Access For Pax 1
    [Arguments]   ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRWIAL/P1;ER
    #${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   WIAL

Add 3H Internet Access For Pax 1
    [Arguments]   ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRWIAM/P1;ER
    #${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   WIAM    

Add 1H Internet Access For Pax 1
    [Arguments]   ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRWIAS/P1;ER
    #${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   WIAS  

Add Blind Passanger SSR
    [Arguments]   ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRBLND/P1;ER

Add Deaf Passanger SSR
    [Arguments]   ${line number}=6 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRDEAF/P1;ER

Add Deportee Passanger SSR
    [Arguments]   ${line number}=7 
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SRDEPA/P1;ER
    Cryptic Command Verify Output    ${line number}/KK        1
    Cryptic Command Verify Output    ${line number}/HK        1
    Cryptic Command Verify Output    ER                       1    


Add Extra Bag PDBG For Pax 1
    [Arguments]  ${line number}=6
    Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=      Execute Amadeus Cryptic Command           SR PDBG/P1;ER
    #${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    Price And Issue Ancillary     ${line number}   PDBG


Price And Issue Ancillary
    [Arguments]  ${line number}=6   ${expected outcome}=XBGG
    Cryptic Command Verify Output     FXG                        ${expected outcome}
    #Cryptic Command Verify Output     ${line number}/KK          ${expected outcome}
    ${stdout}=      Execute Amadeus Cryptic Command       TTM
    ${contains}=    Run Keyword And Return Status    Should Contain    ${stdout}    AY REQUIRES DOCUMENT BEFORE
    run keyword if  '${contains}' == 'True'             Cryptic Command Verify Output     TTM                        OK EMD ADVISE PSGR TO BRING FOID/PICT ID AT APT
    Cryptic Command Verify Output     RT${booking_reference}     /SSR ${expected outcome}


Add Date Created Remark
    [Documentation]  add RM element to pnr
    ${today}=    Get Current Date    result_format=%d.%m.%Y
    ${stdout}=  Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    ${stdout}=  Cryptic Command Verify Output     RM booking for testautomation created ${today};ER   RP/HELAY


Print Booking Reference
    ${stdout}=  Cryptic Command Verify Output     RT${booking_reference}    RP/HELAY
    set local variable   ${tmp file}     ${TEMPDIR}/booking.txt
    create file  ${tmp file}  ${stdout}
    log to console  >>>>> ${booking_reference} <<<<<<
    Set Global Variable   ${booking_reference}


Check Flight Number
    [Documentation]  check flight number
    Print Booking Reference
    ${flight number}=  get flight number
    set global variable  ${flight number}


Validate Flight Day
    [Documentation]  check that flight day on pnr is matching flight day that was asked
    ${flight day}   ${flight month}=  get flight date   ${TEMPDIR}/booking.txt
    Print Booking Reference
    # wait a while we fetch pnr data
    sleep  1
    set global variable  ${flight day}
    set global variable  ${flight month}
    log to console  checking flight dates ...
    # weekday
    log to console  flight day on pnr is ${flight day}
    log to console  flight day asked for booking was ${day}
    # month
    log to console  flight month on pnr is ${flight month}
    log to console  flight month asked for booking was ${month as string}
    # validate and fix date if needed
    run keyword if  '${flight day}' != '${day}'                     Set Correct Flight Date
    run keyword if  '${flight month}' != '${month as string}'       Set Correct Flight Date


Set Correct Flight Date
    [Documentation]  correct flight date
    ${date}=    set variable  ${flight day}/${month}/${year}
    set global variable  ${date}
    log to console      fixing flight date to be ${date}


Remove Line From Booking
    [Arguments]  ${remove line}=False   ${line number}=3   ${expected outocome}=3 APM 358401230000
    run keyword if  "${remove line}" == "True"      Remove Line From PNR    ${remove line}  ${line number}  ${expected outocome}


Remove Line From PNR
    [Arguments]  ${remove line}=False   ${line number}=3   ${expected outocome}=3 APM 3584012345679
    log to console  NOTE! remove line variable is set to True so removing line ${line number} from pnr!
    Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    # remove ape (email) element
    Cryptic Command Verify Output     XE${line number}    ${expected outocome}
    Cryptic Command Verify Output     ET    END OF TRANSACTION COMPLETE


Set Ticket Time Limit to OK
    [Arguments]  ${expected outcome}=5 TK OK
    Cryptic Command Verify Output     TKOK    ${expected outcome}

Arrival Unknown Segment
    Cryptic Command Verify Output       SIARNK   1

Pick Random Nationality
    ${random nationality}=  Evaluate  random.choice($nationalities)  random
    log to console  \nvalue: ${random nationality}
    set global variable  ${random nationality}

Pick Random Day Of Birth
   ${day of birth}=    Evaluate    random.randint(10, 28)    random
    log to console  ${day of birth}
    set global variable  ${day of birth}

Pick Random Month Of Birth
   ${month of birth}=    Evaluate  random.choice($months)  random
    log to console  \nvalue: ${month of birth}
    set global variable  ${month of birth}

Pick Random Month Of Birth for Infant
   ${month of birth for infant}=    Evaluate  random.choice($infant_months)  random
    log to console  \nvalue: ${month of birth for infant}
    set global variable  ${month of birth for infant}

Pick Random Year Of Birth
    ${year of birth}=    Evaluate    random.randint(22, 90)    random
    log to console  ${year of birth}
    set global variable  ${year of birth}

Pick Random Year Of Birth of infant
    ${year of birth infant} =    Evaluate    random.randint(19, 20)    random
    log to console  ${year of birth infant}
    set global variable  ${year of birth infant}

Pick Random Year Of Birth For Child
    ${year of birth child}=    Evaluate    random.randint(10, 15)    random
    log to console  ${year of birth child}
    set global variable  ${year of birth child}

Pick Random Passport Expiration Day
   ${expiration day}=    Evaluate    random.randint(10, 28)    random
    log to console  ${expiration day}
    set global variable  ${expiration day}

Pick Random Passport Expiration Month
   ${expiration month}=    Evaluate  random.choice($months)  random
    log to console  \nvalue: ${expiration month}
    set global variable  ${expiration month}

Pick Random Passport Expiration Year
    ${expiration year}=    Evaluate    random.randint(22, 29)    random
    log to console  ${expiration year}
    set global variable  ${expiration year}

Pick Random Passport Number  
    ${passport number}=   Generate Random String    8    ${numbers}
    log to console  ${passport number}
    set global variable  ${passport number}