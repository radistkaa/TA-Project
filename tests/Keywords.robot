*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${base_url}       https://www-preprod.finnair.com/master-en
${front_login}    //fin-login-button[contains(@class, "white-text")]
${username}       //input[@formcontrolname="username"]
${password}       //input[@formcontrolname="password"]
${login_submit}    //button[@type="submit"]
${logged_in_button}    //button[@title="Display my profile information"]
${close_cookies}    //button[text()="Close"]
${pick_origin}    //div[contains(@class,"bw-origin")]
${first_origin}    id:origin-locations-0
${pick_destination}    //div[contains(@class,"bw-destination")]
${location_search}    name:locationSearch
${first_destination}    id:destination-locations-0
${oneway}         //input[@value="oneway"]/../div
################################################################################################################################
${master_password}    //input[@placeholder='password']
${master_username}    //input[@placeholder='username']
${master_login_button}    //body//input[3]
${close_cookies_button}    //button[@class='btn rounded pr-large-x tr-small']
${one_way_button}    //label[@class='bw-4 block relative mr-xxsmall-y medium-type link-hover nowrap']//div[@class='is-small northern-light-60-text bw-icon']
${flight_from}    //div[@class='bw-37 bw-7 bw-origin bw-23 bw-14 focus-inset flex flex--column flex--left-center grow fill']
${location_origin}    //input[@id='origin-input']
${pick_flight_from}    //li[@id='origin-locations-0']
${flight_to}      //div[@class='bw-37 bw-7 bw-destination bw-24 bw-14 focus-inset flex flex--column flex--left-center grow fill']
${pick_flight_to}    //li[@id='destination-locations-0']
${location_destination}    //input[@id='destination-input']
#${select_class}    //div[@class='bw-travel-class bw-29 bw-37 bw-6 bw-14 focus-inset flex flex--column flex--left-center grow fill']
#${travel_class}    //div[@class='bw-53 flex--nogrow white-bg fill ps-large']
#${economy_class}    //label[@class='bw-14 ts-xsmall ps-medium-y fill ice-70-text']
${departure_date}    //div[contains(text(),'Departure date')]
${exact_departure_date}    //div[@class='flex flex-1 ps-xxsmall-x ps-xsmall-y border-right']
${departure_date}    //input[@id='bw-departureInput']
${done_button}    //button[@class='bw-modal-done bw-57 bw-15 bw-58 ps-small-x ps-xsmall-y btn--white ts-xxsmall bold-type uppercase border rounded nordic-blue-100-border']
${book_now}       //span[contains(text(),'Book now')]
${ticket_type}    //li[1]//fin-air-bounds-bound-selection[1]//label[1]//div[1]//fin-fare-family-option-list[1]//div[1]//button[1]
${select_ticket_type}    //fin-fare-family-option[1]//div[1]//div[2]//div[3]//fcom-button[1]//div[1]//button[1]
${continue_button}    //button[@class='rounded bold-type uppercase block btn-cta has-text btn-fill ps-medium-x tr-small']
${first_passenger}    //div[text()=' passenger 1 ']
${gender_male}    //span[contains(text(),'Male')]
${gender_female}    //span[contains(text(),'Female')]
${first_name}     //div[text()=' passenger 1 ']/ancestor::div[2] //input[@type='text'][@id='firstName-0']
${last_name}      //div[text()=' passenger 1 ']/ancestor::div[2] //input[@type='text'][@id='lastName-0']
${email}          //div[text()=' passenger 1 ']/ancestor::div[2] //input[@type='email'][@name='email-0']
${tel_country_code}    //div[text()=' passenger 1 ']/ancestor::div[2] //select[@name='tel-country-code-0']
${tel_number}     //div[text()=' passenger 1 ']/ancestor::div[2] //*[@name='tel-national-0']
${terms_and_conditions}    //button[@class='rounded bold-type uppercase block btn-high has-text ps-medium-x tr-small']
${credit_or_debit_card_button}    //*[name()='circle' and contains(@cx,'12')]
${card_form}      //iframe[@id='PAYMENT_CARD_IFrame']
${credit_card_form}    //iframe[@id='creditCardFrame']
${credit_card_num}    //input[@name='tokenizedCreditCardNumber']
${credit_card_expiry_date}    //input[@name='expiryDate']
${credit_card_cvv}    //input[@name='tokenizedCVV']
${credit_card_name}    //input[@name='cardHoldername']
${credit_card_adress}    //input[@name='address']
${credit_card_city}    //input[@name='city']
${credit_card_postcode}    //input[@name='zipCode']
${credit_card_country}    //option[@value="FI"]
${pay_now}        //button[contains(@class,'sc-fzplWN sc-fzqAui eoGDzK continue-button')]
${pass_code}      //input[@id='userInput1_password']
${do_authentication}    //div[@id='userInput1']//input[3]
${back_to_merchant}    //input[@id='backToMerchant']
${user_login_button}   //span[@class='ng-star-inserted']
${F_username}  //input[@formcontrolname="username"]
${F_password}  //input[@formcontrolname="password"]
${F_login_button}   //button[@class='button button-blue login-submit ng-star-inserted']
${F_logged_in}   //button[@title="Display my profile information"]
${F_saved_card}    //label[@class='sc-pciEQ pvbqM']//span[@class='sc-AxhCb eSwYtm sc-pZaHX hCKhjF radio-button-icon']
${return_date}   //input[@id='bw-returnInput']

*** Keywords ***

Log in preproduction
  Input Text    ${master_username}    f.com
  Input Text    ${master_password}    preview2020
  Click Element    ${master_login_button}

Select Oneway
    Click Element    ${one_way_button}

Select Flight From
    Click Element    ${flight_from}
    Wait Until Element Is Visible    ${location_origin}    30s
    Input Text    ${location_origin}    hel
    Wait Until Element Is Visible    ${pick_flight_from}    30s
    Click Element    ${pick_flight_from}
    Sleep    1s

Select Flight To
    Click Element    ${flight_to}
    Wait Until Element Is Visible    ${location_destination}    30s
    Input Text    ${location_destination}    cph
    Wait Until Element Is Visible    ${pick_flight_to}    30s
    Click Element    ${pick_flight_to}
    Sleep    1s

Select Departure Date
    Click Element    ${departure_date}
    Click Element    ${exact_departure_date}
    Input Text    ${departure_date}    15102020
    Click Element    ${done_button}
    Click Element    ${book_now}
#Select Return Date
Select Departure Flight
    Wait Until Element Is Visible    ${ticket_type}    30s
    Click Element    ${ticket_type}
    Sleep    1s
    Wait Until Element Is Visible    ${select_ticket_type}    30s
    Click Element    ${select_ticket_type}
    Wait Until Element Is Visible    ${continue_button}    30s
    Click Element    ${continue_button}
#Select Return flight

Review your flights
    Click Element    ${continue_button}

Enter Passenger Details
    Wait Until Element Is Visible    ${first_passenger}    30s
    Click Element    ${gender_male}
    Wait Until Element Is Enabled    ${gender_male}
    Input Text    ${first_name}    Mark
    Input Text    ${last_name}    Ronson
    Input Text    ${email}    kateryna.vinokurova@finnair.com
    Press Keys    ${tel_country_code}    Estonia
    Wait Until Element Is Visible    ${tel_number}    30s
    Input Text    ${tel_number}    12345678
    Click Element    ${continue_button}
    Sleep    5s

Travel Extras
    Click Element    ${continue_button}
    Sleep    5s

Review Your Purchase
    Click Element    ${continue_button}
    Wait Until Element Is Visible    ${terms_and_conditions}    30s
    Click Element    ${terms_and_conditions}

Select Payment Method
    Wait Until Element Is Visible    ${credit_or_debit_card_button}    30s
    Click Element    ${credit_or_debit_card_button}
    Wait Until Element Is Visible    ${card_form}    30s
    Select Frame    ${card_form}
    Wait Until Element Is Visible    ${credit_card_form}    30s
    Select Frame    ${credit_card_form}
    Input Text    ${credit_card_num}    4000000000000002
    Input Text    ${credit_card_expiry_date}    1020
    Input Text    ${credit_card_cvv}    737
    Input Text    ${credit_card_name}    Mark Ronson
    Input Text    ${credit_card_adress}    Narva mnt.27
    Input Text    ${credit_card_city}    Helsinki
    Input Text    ${credit_card_postcode}    51009
    Wait Until Element Is Visible    ${credit_card_country}    30s
    Click Element    ${credit_card_country}
    unselect Frame
    unselect Frame
    Wait Until Element Is Visible    ${pay_now}    30s
    Sleep    3s
    Click Element    ${pay_now}

Password verification
    Wait Until Element Is Visible    ${pass_code}    30s
    Input Text    ${pass_code}    123
    Click Element    ${do_authentication}
    Wait Until Element Is Visible    ${back_to_merchant}    30s
    Click Element    ${back_to_merchant}

#F plus user
F plus login
    Click Element   ${user_login_button}
    Wait Until Element Is Visible    ${username}  30s
    Input Text    ${username}  667817159
    Input Text    ${F_password}  finnair2018
    Click Element    ${F_login_button}
    Wait Until Element Is Visible    ${F_logged_in}  30s

F plus Flight From
    Click Element    ${flight_from}
    Wait Until Element Is Visible    ${location_origin}    30s
    Input Text    ${location_origin}    hel
    Wait Until Element Is Visible    ${pick_flight_from}    30s
    Click Element    ${pick_flight_from}
    Sleep    1s

F plus Flight To
    Click Element    ${flight_to}
    Wait Until Element Is Visible    ${location_destination}    30s
    Input Text    ${location_destination}   mad
    Wait Until Element Is Visible    ${pick_flight_to}    30s
    Click Element    ${pick_flight_to}
    Sleep    1s

F plus Departure Date
    Click Element    ${departure_date}
    Click Element    ${exact_departure_date}
    Input Text    ${departure_date}    22082020
    Click Element    ${done_button}
    Click Element    ${book_now}

F plus Departure Flight
    Wait Until Element Is Visible    ${ticket_type}    30s
    Click Element    ${ticket_type}
    Sleep    1s
    Wait Until Element Is Visible    ${select_ticket_type}    30s
    Click Element    ${select_ticket_type}
    Wait Until Element Is Visible    ${continue_button}    30s
    Click Element    ${continue_button}

F plus Passenger Details
    Wait Until Element Is Visible    ${first_passenger}    30s
    Click Element    ${gender_female}
    Wait Until Element Is Enabled    ${gender_female}
    Input Text    ${email}    kateryna.vinokurova@finnair.com
    Click Element    ${continue_button}
    Sleep    5s

F plus Payment Method
    Wait Until Element Is Visible    ${F_saved_card}   30s
    Click Element    ${F_saved_card}
    Wait Until Element Is Visible    ${pay_now}    30s
    Sleep    3s
    Click Element    ${pay_now}
#Choose 3 pax
3PaxRT Flight From
    Click Element    ${flight_from}
    Wait Until Element Is Visible    ${location_origin}    30s
    Input Text    ${location_origin}    hel
    Wait Until Element Is Visible    ${pick_flight_from}    30s
    Click Element    ${pick_flight_from}
    Sleep    1s

3PaxRT Flight To
    Click Element    ${flight_to}
    Wait Until Element Is Visible    ${location_destination}    30s
    Input Text    ${location_destination}   lon
    Wait Until Element Is Visible    ${pick_flight_to}    30s
    Click Element    ${pick_flight_to}
    Sleep    1s

3PaxRT Travel Date
    Click Element    ${departure_date}
    Click Element    ${exact_departure_date}
    Input Text    ${departure_date}    11082020
    Input Text  ${return_date}  15092020
    Click Element    ${done_button}
    Click Element    ${book_now}

Login User
    [Arguments]    ${user}    ${pass}
    #login-button with white text from the website inspect
    Wait Until Element Is Visible    ${front_login}    30s
    Click Element    ${front_login}
    Wait Until Element Is Visible    ${username}    30s
    #id:663331833, password:finnair2018
    #30s timelimit
    Input Text    ${username}    ${user}
    Input Text    ${password}    ${pass}
    Click Element    ${login_submit}
    Wait Until Element Is Visible    ${logged_in_button}    30s

Close Cookies
    Wait Until Element Is Visible    ${close_cookies_button}    30s
    Click Element    ${close_cookies_button}

Select Origin
    Click Element    ${pick_origin}
    Wait Until Element Is Visible    ${location_search}    30s
    Input Text    ${location_search}    hel
    Wait Until Element Is Visible    ${first_origin}    30s
    Click Element    ${first_origin}
    Sleep    1s

Select Destination
    Click Element    ${pick_destination}
    Wait Until Element Is Visible    ${location_search}    30s
    Input Text    ${location_search}    sto
    Wait Until Element Is Visible    ${first_destination}    30s
    Click Element    ${first_destination}
    Sleep    1s

Select Oneway Flight
    Wait Until Element Is Visible    ${oneway}    30s
    Click Element    ${oneway}
    Radio Button Should Be Set To    travelType    oneway
