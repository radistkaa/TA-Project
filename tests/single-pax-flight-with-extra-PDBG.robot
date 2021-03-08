*** Settings ***
Resource        ../templates/single_pax_with_PDBG_template.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus


*** Test Cases ***
Book Flight From Helsinki To Bangkok With Extra Bag PDBG
    [Tags]                  1-extra-bag-tuija-makkonen
    [Template]              Create Singlepax Flight With PDBG
    ${pax_makkonen}         HEL     BKK     1-extra-bag-tuija-makkonen


Book Flight From Barcelona To Helsinki With Extra Bag PDBG
    [Tags]                  regression-testcase-2-android
    [Template]              Create Singlepax Flight With PDBG
    ${pax_pekka_perus}      BCN     HEL     regression-testcase-2-android   15  30
