*** Settings ***
Resource        ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Test Cases ***
Read PNR
    [Tags]  get-pnr-content
    execute amadeus cryptic command  RT${pnr}
