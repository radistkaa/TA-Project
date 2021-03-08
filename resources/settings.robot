*** Settings ***
Library         OperatingSystem
Library         ${EXECDIR}${/}robot_files${/}/resources/dateHelper.py
Library         ${EXECDIR}${/}robot_files${/}/resources/flightdate.py
Variables       ${EXECDIR}${/}robot_files${/}/resources/variables.py
Resource        ${EXECDIR}${/}robot_files${/}/resources/amadeus.robot
Resource        ${EXECDIR}${/}robot_files${/}/resources/general.robot
Resource        ${EXECDIR}${/}robot_files${/}/resources/test_server.robot
