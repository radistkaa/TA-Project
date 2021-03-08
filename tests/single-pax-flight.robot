*** Settings ***
Resource        ../templates/single_pax_template.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus


*** Test Cases ***
Book Singlepax Finnair Account Flight From Helsinki To Bangkok
    [Tags]                  extra-bag-ancillary-booking-finnair-account
    [Template]              Create Singlepax Flight
    ${pax_antti_tester}     HEL     BKK     extra-bag-ancillary-booking-finnair-account

Book Singlepax Flight From Helsinki To Bangkok
    [Tags]                  extra-bag-ancillary-booking-emma-adelaide
    [Template]              Create Singlepax Flight
    ${pax_emma_adelaide}    HEL     BKK     extra-bag-ancillary-booking-emma-adelaide

Book Singlepax Platinum User Flight From Helsinki To Bangkok
    [Tags]                  extra-bag-ancillary-booking-arvo-platina
    [Template]              Create Singlepax Flight
    ${pax_arvo_platina}     HEL     BKK     extra-bag-ancillary-booking-arvo-platina

Book Singlepax Flight Booking
    [Tags]                  guest-journey-no-ape-element
    [Template]              Create Singlepax Flight
    ${pax_arvo_platina}     HEL     BKK     guest-journey-no-ape-element    ${True}


Book Singlepax Flight From Helsinki To Amsterdam
    [Tags]                  extra-bag-ancillary-booking-tuija-makkonen
    [Template]              Create Singlepax Flight
    ${pax_makkonen}         HEL     AMS     extra-bag-ancillary-booking-tuija-makkonen


Book Singlepax Flight From Helsinki To Stockholm
    [Tags]                  token-invalidation
    [Template]              Create Singlepax Flight
    ${pax_rafal_repinski}   HEL     ARN     token-invalidation


Book Singlepax Flight From Helsinki To London
    [Tags]                  guest-login-family-name-with-space
    [Template]              Create Singlepax Flight
    ${pax_liisa_vaha_jarvi}   HEL     LHR     guest-login-family-name-with-space


Book Singlepax Flight From Helsinki To Bangkok As User Tester
    [Tags]                  antti-tester-bkk
    [Template]              Create Singlepax Flight
    ${pax_antti_tester}     HEL     BKK     antti-tester-bkk


Book Singlepax Flight From Helsinki To Bangkok as Pekka Perus
    [Tags]                  smoketest-meals
    [Template]              Create Singlepax Flight
    ${pax_pekka_perus}      HEL     BKK     smoketest-meals


Book Singlepax Flight From Helsinki To Barcelona as Pekka Perus
    [Tags]                  regression-testcase-1-phase-1
    [Template]              Create Singlepax Flight
    ${pax_pekka_perus}      HEL     BCN     regression-testcase-1-phase-1   ${False}   7    30


Book Singlepax Flight From Helsinki To Barcelona as Emma Adelaide
    [Tags]                  regression-testcase-1-phase-2
    [Template]              Create Singlepax Flight
    ${pax_emma_adelaide}    HEL     BCN     regression-testcase-1-phase-2   ${False}   2    5


Book Singlepax Flight From Barcelona To Helsinki as Pekka Perus
    [Tags]                  regression-testcase-2
    [Template]              Create Singlepax Flight
    ${pax_pekka_perus}      BCN     HEL     regression-testcase-2   ${False}   15    30


Book Singlepax Flight From Helsinki To Singapore as Emma Adelaide
    [Tags]                  regression-testcase-16
    [Template]              Create Singlepax Flight
    ${pax_emma_adelaide}      HEL     SIN     regression-testcase-16   ${False}   45    75


Book Singlepax Flight From Helsinki To London With Veli Hopea
    [Tags]                  regression-testcase-18-ios
    [Template]              Create Singlepax Flight
    ${pax_veli_hopea}       HEL     LHR     regression-testcase-18-ios   ${False}   12    45


Book Singlepax Flight From Helsinki To Gran Canaria With Pekka Perus
    [Tags]                  smoketest-meals-shorthaul
    [Template]              Create Singlepax Flight
    ${pax_pekka_perus}      HEL     LPA     smoketest-meals-shorthaul   ${False}   30    90
