*** Settings ***
Resource        ../templates/Katya_SP_template.robot
#Resource        ../resources/settings.robot
Test Setup       Login To Amadeus
Test Teardown    Logout From Amadeus


*** Test Cases ***
Single Pax to OUL
  Create Singlepax Flight   ${pax_kateryna_vinokurova}    HEL    OUL    Testing
