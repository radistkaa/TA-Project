*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
${MA FF-number}       690876156       
${TT FF-number}       677677247


*** Test Case ***
3. iOS- Logged in, non-AY operated flight, non-air elements in PNR
    [Tags]                                                PNR3    PNR0
    Log To Console         "Ignored due to pricing issue and PNR duplications" 
