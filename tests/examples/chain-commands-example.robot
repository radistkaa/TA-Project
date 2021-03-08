*** Settings ***
Resource        ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup      Login To Amadeus
Test Teardown   Logout From Amadeus

*** Test Cases ***
Multiple Commands
    [Tags]  commands
    execute amadeus cryptic command  dd
    execute amadeus cryptic command  dd


Multiple Chained Commands
    [Tags]  chain
    Execute Multiple Cryptic Commands  dd::dd::dd::dd::dd
