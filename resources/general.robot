*** Settings ***
Library     general.py
Library     dateHelper.py
Library     DateTime
Variables   variables.py
Library     OperatingSystem

*** Keywords ***
Create Random Flight Date Next 100 To 250 Days
    ${year}     ${month}    ${day}  ${month_as_string}=    generate random flight date  100    250
    set global variable  ${month_as_string}
    set global variable  ${month}
    set global variable  ${year}
    set global variable  ${day}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}


Set Exact Flight Day
    [Arguments]  ${day}     ${month}    ${year}
    ${month_as_string}=  Convert Date  ${month}  date_format=%m    result_format=%b
    log to console      \n${month_as_string.upper()}     # logs ie FEB
    set global variable  ${month_as_string}
    set global variable  ${month}
    set global variable  ${year}
    set global variable  ${day}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}

#Failover Create Random Flight Date Next 100 To 250 Days
#    Create Random Flight Date Next 100 To 250 Days
#    Book Flight On Finnair Operated Flight     1   Y       

Create Exact Date Flight
    #[Arguments]  ${​​year}​​     ${​​month}​​    ${​​day}​​  ${​​month_as_string}​​
    #[Arguments]       ${​​day}​​    ${​​month}​​=${​​exact_month}​​    ${​​year}​​=${​​exact_year}​​   
    [Arguments]      ${day}    ${month}   ${year}
    set global variable  ${​​month}​​
    set global variable  ${​​year}​​
    set global variable  ${​​day}​​
    ${​​date}​​=    set variable  ${​​day}​​/${​​month}​​/${​​year}​​
    set global variable  ${​​date}​​
    #Set Last Year Global Variable
    ${​​month_as_string}​​=  Convert Date  ${​​month}​​   date_format=%m    result_format=%b
    set global variable  ${​​month_as_string}
    ​​
    Log To Console    ${​​month_as_string}​​katyatest${​​month}​​


Create Random Flight Date Next 3 To 29 Days
    ${year}     ${month}    ${day}  ${month_as_string}=    generate random flight date  3    29
    set global variable  ${month_as_string}
    set global variable  ${month}
    set global variable  ${year}
    set global variable  ${day}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}

#Failover Create Random Flight Date Next 3 To 29 Days
#    Create Random Flight Date Next 3 To 29 Days
#    Book Flight On Finnair Operated Flight     1   Y       

Create Random Flight Date Next X To Y Days
    [Arguments]  ${days_from}    ${days_to}  
    ${year}     ${month}    ${day}  ${month_as_string}=    generate random flight date  ${days_from}    ${days_to}
    set global variable  ${month_as_string}
    set global variable  ${month}
    set global variable  ${year}
    set global variable  ${day}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}
    Set Last Year Global Variable

Failover Create Random Flight Date Next X To Y Days
    [Arguments]  ${days_from}    ${days_to}   ${number_of_passengers}    ${flight_class}=Y    ${custom filter}=${space}AY
    Create Random Flight Date Next X To Y Days    ${days_from}    ${days_to}
    Book Flight On Finnair Operated Flight     ${number_of_passengers}   ${flight_class}    ${custom filter}       

Set Return Date
    [Documentation]  set return date - default is after 7 days
    [Arguments]  ${return_after_days}=7
    ${return_day}   ${return_month}=  get return day and month  ${day}  ${month_as_string}     ${return_after_days}
    ${return_month_as_number}=  convert month string to int  ${return_month}
    ${return_date}=  set variable  ${return_day}/${return_month_as_number}/${year}
    set global variable  ${return_day}
    set global variable  ${return_month}
    set global variable  ${return_date}

Create Random Flight In This Month
    ${start}    ${end}=     get flight days for this month
    ${year}     ${month}    ${day}  ${month_as_string}=    generate random flight date in this month  ${start}    ${end}
    set global variable  ${month_as_string}
    set global variable  ${year}
    set global variable  ${month}
    set global variable  ${day}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}

#Failover Create Random Flight In This Month
#    Create Random Flight In This Month
#    Book Flight On Finnair Operated Flight     1   ${flight_class}       

Get Departure Day From Booking Reference
    [Documentation]  check departure day from pnr
    [Arguments]  ${departure filter}=2${space}${space}AY
    ${pnr}=  Cryptic Command Verify Output     RT${booking_reference}  RP/HELAY
    ${lines} =	Get Lines Containing String	    ${pnr}	${departure filter}
    @{words} =	Split String	${lines}
    ${day}=    set variable  ${words[4][:-3].lstrip("0")}
    log to console  departure date is ${words[4][:-3].lstrip("0")}
    ${date}=    set variable  ${day}/${month}/${year}
    set global variable  ${date}

Subtract Days From Flight Date
    [Documentation]  ie via flights departure might be day before
    [Arguments]  ${days to subtract}=1
    ${date} =	Convert Date	            ${date}	    date_format=%d/%m/%Y
    ${date} =	Subtract Time From Date	    ${date}	    ${days to subtract} days
    ${date} =	Convert Date	            ${date}	    result_format=%d/%m/%Y
    set global variable                     ${date}

Create Return Day
    [Arguments]  ${departure_day}   ${days_to_increase}=3
    ${returnDay} =    Evaluate    ${departure_day.lstrip('0')}+${days_to_increase}
    log to console  return day is ${returnDay}
    [Return]  ${returnDay}

Set Last Year Global Variable
    ${current date} =	Get Current Date
    ${last year} =	Subtract Time From Date	    ${current date}	365 days    result_format=%Y
    set global variable     ${last year}


Prepare Variables
    [Documentation]  set testcase global variables
    [Arguments]  ${origin}  ${destination}
    ${flight origin}=            set variable    ${origin}
    ${flight destination}=       set variable    ${destination}
    # set origin long name ie HEL -> Helsinki
    FOR    ${key}    IN    @{cities.keys()}
        ${flight origin long}=   set variable if  "${key}" == "${origin}"   ${cities["${key}"]}
        exit for loop if    "${key}" == "${origin}"
    END
    # set destination long name AMS - Amsterdam
    FOR    ${key}    IN    @{cities.keys()}
        ${flight destination long}=   set variable if  "${key}" == "${destination}"   ${cities["${key}"]}
        exit for loop if    "${key}" == "${destination}"
    END


    set global variable     ${flight origin}
    set global variable     ${flight destination}
    set global variable     ${flight origin long}
    run keyword if  "${flight origin long}" == "None"           FAIL  failed to set origin city
    set global variable     ${flight destination long}
    run keyword if  "${flight destination long}" == "None"      FAIL  failed to set long destination city


Save result to file
    [Arguments]    ${PNR_scenario_name}
    #Append To File                                Results/generatedPNRs.txt     ${\n}${PNR_scenario_name}: ${booking_reference}. Booking date: ${date}    encoding=UTF-8
    ${fullPNR}=  Cryptic Command Verify Output     RT${booking_reference}       RP/HELAY
    Append To File                                Results/generatedPNRs.txt     ${\n}${PNR_scenario_name}    #${\n}
    Append To File                                Results/generatedPNRs.txt     ${fullPNR}${\n}
    Log To Console                                ${\n} >>>>>> PNR no ${booking_reference} saved to generatedPNRs.txt <<<<<<
    Save results to file for cancellation
#    Cancel specific date PNRs
#    Log To Console        Read saved result from ${timestamp}.txt


Save results to file for cancellation
    ${timestamp} =    Get Current Date    result_format=%Y%m%d
    set global variable  ${timestamp}
    Append to File                            Results/${timestamp}.txt             ${booking_reference}${\n}
    Log To Console        >>>>>>> Added PNR ${booking_reference} to ${timestamp}.txt

Cancel specific date PNRs
    [Arguments]    ${timestamp}
    ${PNRs from file}    Get File    Results/${timestamp}.txt    encoding=UTF-8    encoding_errors=strict
    @{PNRs from file as list}=    Split to lines  ${PNRs from file}   
    Log To Console  ${\n}PNRs readed as the the list: @{PNRs from file as list}

    FOR    ${one PNR}    IN    @{PNRs from file as list}
        Log To Console    >>>>>>> Starting cancel PNR: ${one PNR}
        Cancel Booking With Cryptic    ${one PNR}
    END