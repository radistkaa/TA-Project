*** Settings ***
Resource        ../templates/return_flight_template.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus


*** Test Cases ***
Book Singlepax Return Flight Shanghai Helsinki Shanghai
    [Tags]                  one-upgrade-smoketest
    [Template]              Create Return Flight Template
    ${pax_pekka_perus}      PVG     HEL     one-upgrade-smoketest


Book Singlepax Return Flight Helsinki Oslo Helsinki
    [Tags]                  regression-testcase-8
    [Template]              Create Return Flight Template
    ${pax_pekka_perus}      HEL     OSL     regression-testcase-8   1   Y   5   45


Book Singlepax Return Flight Helsinki Delhi Helsinki
    [Tags]                  regression-testcase-9
    [Template]              Create Return Flight Template
    ${pax_pekka_perus}      HEL     DEL     regression-testcase-9   1   Y   10  24


Book Singlepax Return Flight Helsinki Bangkok Helsinki
    [Tags]                  regression-testcase-11
    [Template]              Create Return Flight Template
    ${pax_pekka_perus}      HEL     BKK     regression-testcase-11   1   O   30  60


Book Singlepax Return Flight Helsinki Bangkok Helsinki
    [Tags]                  regression-testcase-20-ios
    [Template]              Create Return Flight Template
    ${pax_antti_tester}      HEL     BKK     regression-testcase-20-ios   1   K   15  60