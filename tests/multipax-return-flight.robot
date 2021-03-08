*** Settings ***
Resource        ../templates/multipax_return_flight_template.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus


*** Test Cases ***
Book Multipax Return Flight From Helsinki To Bangkok
    [Tags]                  regression-testcase-10
    [Template]              Create Multipax Return Flight
    ${pax_emma_adelaide}    ${pax_george_cloonie}   HEL     DEL     regression-testcase-10  20  60  2   K


Book Multipax Return Flight From Helsinki To London
    [Tags]                  regression-testcase-12-android
    [Template]              Create Multipax Return Flight
    ${pax_emma_adelaide}    ${pax_cristiano_ronaldo}   HEL     LHR     regression-testcase-12-android  14  45  2   O


Book Multipax Return Flight From Helsinki To Beijing
    [Tags]                  regression-testcase-20-android
    [Template]              Create Multipax Return Flight
    ${pax_emma_adelaide}    ${pax_erik_adelaide}   HEL     PEK     regression-testcase-20-android  25  60  2   K
