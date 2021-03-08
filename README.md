# mobile-app-test-flights
installation

* install python3

* install pip3

* install robotframework and plugins

  > pip install robotframework robotframework-requests 


Note: This branch is used for creating test flights for mobileapp test automation 
so if your creating new flights please do not upload them to mobile-app json server.
Todo so please comment out keyword "#Add Test Server Entry". Thank you!


create preprod test flights

    > robot -V robot_files/resources/variables.py robot_files/tests/single-pax-flight.robot

create certain flight with tag:

    > robot -d /tmp -i PNR0 robot_files/

read pnr content, pass pnr from command line

    > robot -d /tmp -v pnr:UC5L39 -i get-pnr-content robot_files/tests/



WINDOWS INSTALLATION

1) download python3 from  https://www.python.org/downloads/

2) install python and select "**Add python 3.X to PATH**"

3) open command prompt or power shell and verify that python is found

    > python --version      // Python 3.8.6

4) install Robot Framework

    > pip install robotframework            // installing collected packages: robotframework ...
    > pip install robotframework-requests

5) verify robotframework

    > robot --version               // robot framework 3.X.X