*** Settings ***
Resource    ../resources/general.robot
Library     DateTime
Library     OperatingSystem
Library     String
Resource    ../resources/amadeus.robot

*** Test Case ***
Start cancel PNRs
    [Tags]                                                             cancelPNR
    Cancel specific date PNRs    20201120
