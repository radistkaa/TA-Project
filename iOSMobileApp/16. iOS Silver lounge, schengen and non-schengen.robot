*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:

${MA FF-number}       690875976         #DON'T CHANGE THIS ACCOUNT NUMBER
${TT FF-number}       680113180
${custom filter}         ${space}*AY

*** Test Case ***
16. (iOS) Silver lounge, schengen and non-schengen
    [Tags]                                                PNR16    PNR0
    Prepare Variables                                 KAJ       HEL 
    Create Random Flight Date Next X To Y Days        25        50
    Book Flight On Finnair Operated Flight            1         M          ${custom filter}
    Set Return Date    2
    Book Return Flight                                1         M    ${return_day}    ${return_month}   HEL    SIN 
    Set Return Date    
    Book Return Flight                                1         L    ${return_day}    ${return_month}   SIN    KAJ 
    #Add Pax name from Frequent Flyer Number To Booking    ${MA FF-number}
    Add Pax name from Frequent Flyer Number To Booking    ${TT FF-number}
    Price Itinerary With Best Price
    Validate Ticket
    Print Booking Reference
    Save result to file    ${TEST NAME}

***Comments***
RP/HELAY0980/HELAY0980            WS/SU   9OCT20/1246Z   VVQQO8
HELAY0980/9999WS/9OCT20
  1.HOPEA/VELI MR
  2  AY 420 M 26OCT 1 KAJHEL HK1  0440    0525 0645   *1A/E*
  3  AY 131 M 28OCT 3 HELSIN HK1  2255 2  2355 1715+1 *1A/E*            //+2 days - stopover
  4  AY 132 L 02NOV 1 SINHEL HK1  2245 1  2345 0600+1 *1A/E*            //Set Return Date is 7 days by default, but it takes 7 days from the 1st flight. How about 7 days after stopover?
  5  AY 643 L 03NOV 2 HELKAJ HK1  0715 2  0800 0920   *1A/E*
  6 APN AY/M+35850123456789/EN
  7 APN AY/E+ANCILLARYTEST@GMAIL.COM/EN
  8 TK OK09OCT/HELAY0980//ETAY
  9 SSR CTCE AY HK1 ANCILLARYTEST//GMAIL.COM/EN
 10 SSR CTCM AY HK1 35850123456789/EN
 11 *SSR FQTV AY HK/ AY690875976 RUBY/SILV-7000
 12 SK XACI AY HK1 CUSTOMER REFUSED AUTOMATIC CHECKIN
 13 FA PAX 105-2469301297/ETAY/EUR1388.82/09OCT20/HELAY0980/1942
       0483/S2-5
 14 FB PAX 0000000000 TTP OK ETICKET ADVISE PSGR TO BRING PICT
       ID AT APT/S2-5
 15 FE PAX NO BAG INCL/NONREF-NO CHNG/S2-5
 16 FG PAX 0000000000 OSLS12462/S2-5
 17 FP CASH