#!/usr/bin/env python

import requests
import xml.etree.ElementTree
from amadeus_template import *
from robot.libraries.BuiltIn import BuiltIn

amadeus_webservices_url = "https://test.webservices.amadeus.com"

#def amadeus_login():
  #  """ login to amadeus - return session id and token
  #      office id HELAY0980
  #  """    
  #  headers = {'content-type': 'application/xml',
  #             'SOAPAction': 'http://webservices.amadeus.com/'
  #                           '1ASIWGENAY/VLSSLQ_06_1_1A'}

def amadeus_login(office_id='HELAY0671', duty_code='SU'):
   body = """<?xml version="1.0" encoding="UTF-8"?>
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
     <soapenv:Body>
        <vls:Security_Authenticate xmlns:vls="http://xml.amadeus.com/VLSSLQ_06_1_1A">
           <vls:userIdentifier>
              <vls:originIdentification>
                 <vls:sourceOffice>%s</vls:sourceOffice>
              </vls:originIdentification>
              <vls:originatorTypeCode>U</vls:originatorTypeCode>
              <vls:originator>WSAYGEN</vls:originator>
           </vls:userIdentifier>
           <vls:dutyCode>
              <vls:dutyCodeDetails>
                 <vls:referenceQualifier>DUT</vls:referenceQualifier>
                 <vls:referenceIdentifier>%s</vls:referenceIdentifier>
              </vls:dutyCodeDetails>
           </vls:dutyCode>
           <vls:systemDetails>
              <vls:organizationDetails>
                 <vls:organizationId>AY</vls:organizationId>
              </vls:organizationDetails>
           </vls:systemDetails>
           <vls:passwordInfo>
              <vls:dataLength>7</vls:dataLength>
              <vls:dataType>E</vls:dataType>
              <vls:binaryData>QU1BREVVUw==</vls:binaryData>
           </vls:passwordInfo>
        </vls:Security_Authenticate>
     </soapenv:Body>
  </soapenv:Envelope>""" % (office_id, duty_code)
   
   #if not_groupbooking:
    #  from amadeus_template import body
   #else:
    #  from group_booking_amadeus_template import body
 
   headers = {'content-type': 'application/xml',
              'SOAPAction': 'http://webservices.amadeus.com/'
                            '1ASIWGENAY/VLSSLQ_06_1_1A'}


    # soap post request to amadeus
   response = requests.post(amadeus_webservices_url, data=body,
                             headers=headers)

    # get root structure
   tree = xml.etree.ElementTree.fromstring(response.content)

    # parse soap response
   security_token = tree.find('.//{http://xml.amadeus.com/ws/2009/01/'
                               'WBS_Session-2.0.xsd}SecurityToken').text
   session_id = tree.find('.//{http://xml.amadeus.com/ws/2009/01/'
                           'WBS_Session-2.0.xsd}SessionId').text
   status_code = tree.find('.//{http://xml.amadeus.com/'
                            'VLSSLR_06_1_1A}statusCode').text

    # check status code
   if status_code != "P":
        BuiltIn().log_to_console("login failed with status " % status_code)
        raise Exception("%s login failed" % status_code)

   return session_id, security_token


def amadeus_logout(sessionid, token, sequence_number):
    """ logout from amadeus """
    headers = {'content-type': 'application/xml',
               'SOAPAction': 'http://webservices.amadeus.com/1ASIWGENAY/VLSSOQ_04_1_1A'}

    logout_body = """<?xml version="1.0" encoding="UTF-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
         <soapenv:Header>
            <wbs:Session xmlns:wbs="http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd">
               <wbs:SessionId>{}</wbs:SessionId>
               <wbs:SequenceNumber>{}</wbs:SequenceNumber>
               <wbs:SecurityToken>{}</wbs:SecurityToken>
            </wbs:Session>
         </soapenv:Header>
         <soapenv:Body>
            <vls:Security_SignOut xmlns:vls="http://xml.amadeus.com/VLSSOQ_04_1_1A" />
         </soapenv:Body>
      </soapenv:Envelope>""".format(sessionid, sequence_number, token)
    response = requests.post(amadeus_webservices_url, data=logout_body,
                             headers=headers)

    # get structure
    tree = xml.etree.ElementTree.fromstring(response.content)

    # parse soap response
    status_code = tree.find('.//{http://xml.amadeus.com/'
                            'VLSSOR_04_1_1A}statusCode').text

    if status_code != "P":
        raise Exception("%s logout failed" % status_code)

    return status_code


def execute_amadeus_command(command, sessionid, token, sequence_number):
    """ execute cryptic command on amadeus """
    headers = {'content-type': 'application/xml',
               'SOAPAction': 'http://webservices.amadeus.com/1ASIWGENAY/HSFREQ_07_3_1A'}

    command_body = """<?xml version="1.0" encoding="UTF-8"?>
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
         <soapenv:Header>
            <Session xmlns="http://xml.amadeus.com/ws/2009/01/WBS_Session-2.0.xsd">
               <SessionId>{}</SessionId>
               <SequenceNumber>{}</SequenceNumber>
               <SecurityToken>{}</SecurityToken>
            </Session>
         </soapenv:Header>
         <soapenv:Body>
           <hsf:Command_Cryptic xmlns:hsf="http://xml.amadeus.com/HSFREQ_07_3_1A">
              <hsf:messageAction>
                 <hsf:messageFunctionDetails>
                    <hsf:messageFunction>M</hsf:messageFunction>
                 </hsf:messageFunctionDetails>
              </hsf:messageAction>
              <hsf:longTextString>
                 <hsf:textStringDetails>{}</hsf:textStringDetails>
              </hsf:longTextString>
           </hsf:Command_Cryptic>
         </soapenv:Body>
      </soapenv:Envelope>""".format(sessionid, sequence_number, token, command)
    response = requests.post(amadeus_webservices_url, data=command_body,
                             headers=headers)

    # get structure
    tree = xml.etree.ElementTree.fromstring(response.content)

    return tree.find('.//{http://xml.amadeus.com/'
                     'HSFRES_07_3_1A}textStringDetails').text


def parse_booking_reference(pnr_data_file, line_begins="RP/HELAY"):
    """ parse booking reference from PNR """
    with open(pnr_data_file, "r") as pnr_file:
        for ln in pnr_file:
            if ln.startswith(line_begins):
                pnr = ln
    pnr = pnr[-7:].strip('\n')
    if ' ' in pnr:
        raise Exception("%s pnr is not valid booking reference" % pnr)
    return pnr
