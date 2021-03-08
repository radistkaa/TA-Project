*** Settings ***
Resource        ../templates/multipax_template.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus


*** Test Cases ***
Book Multipax Flight From Helsinki To Shangahai
    [Tags]                  one-upgrade-multipax-smoketest
    [Template]              Create Multipax Flight
    ${pax_pekka_perus}     ${pax_willie_west}   HEL     PVG     one-upgrade-multipax-smoketest


Book Multipax Flight From Helsinki To Singapore
    [Tags]                  economy-comfort-ancillary-booking-2-pax
    [Template]              Create Multipax Flight
    ${pax_makkonen}     ${pax_sukunimi}   HEL     SIN     economy-comfort-ancillary-booking-2-pax


Book Multipax Flight From Helsinki To Barcelona
    [Tags]                  lounge-multipax
    [Template]              Create Multipax Flight
    ${pax_veli_hopea}     ${pax_willie_west}   HEL     BCN     lounge-multipax


Book Multipax Flight From Helsinki To Bangkok
    [Tags]                  antti-tester-multipax-bkk
    [Template]              Create Multipax Flight
    ${pax_antti_tester}     ${pax_willie_west}   HEL     BKK     antti-tester-multipax-bkk


Book Multipax Flight From Osaka To Helsinki
    [Tags]                  regression-testcase-18
    [Template]              Create Multipax Flight
    ${pax_emma_adelaide}    ${pax_erik_adelaide}   OSA     HEL     regression-testcase-18


Book Multipax Flight From Helsinki To Rovaniemi
    [Tags]                  regression-testcase-19-ios
    [Template]              Create Multipax Flight
    ${pax_veli_hopea}       ${pax_willie_west}   HEL     RVN     regression-testcase-19-ios     12  45
