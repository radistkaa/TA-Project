*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     DateTime

*** Variables ***
${SERVER}       https://lj8ls5bi1h.execute-api.eu-central-1.amazonaws.com
${PATH}         /dev/api/bookings
${X-API-KEY}    46P79nS8NZ7hk89gtahYD3L8WkXZDRNcj9GKrJhb
@{flight_dst_list}  Singapore   Bangkok
@{existing_dst_list}

*** Keywords ***
*** Comments ***
#Add Test Server Entry
    [Documentation]  post data to test json server
    [Arguments]
    ...    ${template}=economy-comfort-ancillary-booking-2-pax
    ...    ${firstname}=Tuija
    ...    ${lastname}=Makkonen
    ...    ${pnr}=invalid
    ...    ${flight_route}=Helsinki — Singapore
    ...    ${flight_destination}=Singapore
    ...    ${flight_destination_shortcode}=SIN
    ...    ${flight_departure}=N/A
    ...    ${return_flight_departure}=N/A
    ...    ${return_flight_route}=N/A
    ...    ${checkin_completed}=False
    ...    ${flight_number}=N/A
    log to console  === POST FLIGHT TO SERVER ===
    Create Session	test-server   ${SERVER}
    ${today}=    Get Current Date    result_format=%d.%m.%Y
    &{data}=  Create Dictionary
    ...    template=${template}
    ...    first_name=${firstname}
    ...    last_name=${lastname}
    ...    pnr=${pnr}
    ...    flight_route=${flight_route}
    ...    flight_destination=${flight_destination}
    ...    flight_destination_shortcode=${flight_destination_shortcode}
    ...    flight_departure=${flight_departure}
    ...    return_flight_departure=${return_flight_departure}
    ...    return_flight_route=${return_flight_route}
    ...    booking_created=${today}
    ...    checkin_completed=${checkin_completed}
    ...    flight_number=${flight_number}
    &{headers}=  Create Dictionary  Content-Type=application/json   x-api-key=${X-API-KEY}
    ${resp}=  Post Request  test-server  ${PATH}  data=${data}  headers=${headers}
    Should Be Equal As Strings  ${resp.status_code}  201
