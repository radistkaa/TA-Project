#!/usr/bin/env python
#
# amadeus soap template
body = """<?xml version="1.0" encoding="UTF-8"?>
  <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
     <soapenv:Body>
        <vls:Security_Authenticate xmlns:vls="http://xml.amadeus.com/VLSSLQ_06_1_1A">
           <vls:userIdentifier>
              <vls:originIdentification>
                 <vls:sourceOffice>HELAY0671</vls:sourceOffice>
              </vls:originIdentification>
              <vls:originatorTypeCode>U</vls:originatorTypeCode>
              <vls:originator>WSAYGEN</vls:originator>
           </vls:userIdentifier>
           <vls:dutyCode>
              <vls:dutyCodeDetails>
                 <vls:referenceQualifier>DUT</vls:referenceQualifier>
                 <vls:referenceIdentifier>SU</vls:referenceIdentifier>
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
  </soapenv:Envelope>"""