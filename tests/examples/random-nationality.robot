*** Settings ***
Resource  ../../resources/amadeus.robot
Resource  ../../resources/general.robot


*** Variables ***
@{nationalities}    FIN  EST  RUS

*** Test Cases ***
Select Random Nationality
    PICK RANDOM NATIONALITY
    log to console  random nationality is: ${random nationality}

Select Random Year
    [Documentation]  create random year
    [Tags]  date
    Pick Random Year Of Birth
    log to console  Random year is: ${year of birth}
    Set Exact Flight Day    16  11  2020

