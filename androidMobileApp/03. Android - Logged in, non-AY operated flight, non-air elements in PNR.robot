*** Settings ***
Resource                  ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup                Login To Amadeus
Test Teardown             Logout From Amadeus

*** Variables ***
${MA FF-number}       690876149       
${TT FF-number}       677677247


*** Test Case ***
3. Android - Logged in, non-AY operated flight, non-air elements in PNR
    [Tags]                                               PNR03    PNR_android
    Log To Console         "Ignored due to pricing issue and PNR duplications" 
