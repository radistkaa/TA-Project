# Requirements: https://finnair365.sharepoint.com/:x:/s/FinnairSWTesting/EWTzpLppvApGmMQpXtz0WO8BO706y6cyIRrk2x29Sd5_sw?e=tAyHWg

*** Settings ***
Resource                 ${EXECDIR}${/}robot_files${/}resources${/}settings.robot
Test Setup               Login To Amadeus
#Test Setup               Login To Amadeus For Group bookings
Test Teardown            Logout From Amadeus

*** Variables ***
# This prerequired data can be imported directly from excel:
#${origin}         ARN
#${destination}    HEL
${custom filter}    ${space}AY
${custom filter non-pure flight}    ${space}*AY
${day}                26
${exact_month}        11
${exact_year}        2020
#@{nationalities}    EST    FIN    LV




*** Test Case ***

ROW5
    [Tags]                                    ROW5
    #Prepare Variables                        ${origin}     ${destination}
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On Finnair Operated Flight On Certain Flight Number    3    C    810  ${custom filter}  ARN    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    3    C    131  ${custom filter}  HEL    SIN
    Add Passenger To Booking                  ${pax_olli_joki}
    Add DOCS                                  ${pax_olli_joki}
    Add Child Passenger                       ${pax_ilpo_joki_child}    
    Add DOCS For Child                        ${pax_ilpo_joki_child}       
    Add Second Passenger To Booking           ${pax_anna_joki}
    Add DOCS                                  ${pax_anna_joki}
    Price Itinerary
    Validate Ticket
    Add Extra Bag PDBG For Pax 1   
    Print Booking Reference
#done    
#need to think about the correct association for the DOCS (group for bookings)  

ROW6 
    [Tags]                                     ROW6
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}  
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    C    131  ${custom filter}  HEL    SIN
    Add Pax name from Frequent Flyer Number To Booking    676393903
    Add DOCS                                              ${pax_cooke_fbtest_edoh}
    Price Itinerary
    Validate Ticket
    Add Meal For Pax 1       FPML                         #not chargeable for the business class
    Print Booking Reference
#done

ROW7 
    [Tags]                                     ROW7
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}  
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    P    131  ${custom filter}  HEL    SIN
    Add Passenger To Booking                  ${pax_tim_lehti}
    Add DOCS                                  ${pax_tim_lehti}
    Add Second Passenger To Booking           ${pax_sukunimi}
    Add DOCS For 2nd PAX                      ${pax_sukunimi}
    Price Itinerary For the Premium Economy Cabin Multipax  
    Validate Ticket 
    Add Seat For 2 PAXes    23    AC    3    
    Print Booking Reference
#done

ROW8
    [Tags]                                     ROW8
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}  
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    810  ${custom filter}  ARN    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking       ${pax_pekka_perus}  
    Add DOCS                       ${pax_pekka_perus} 
    Price Itinerary
    Validate Ticket  
    Add Seat For 1 PAX    13    F    2    
    Add Seat For 1 PAX    31    J    3    
    Print Booking Reference
#done

ROW9
    [Tags]                                     ROW9
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    P    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_aapo_automaatio}  
    Add DOCS                                  ${pax_aapo_automaatio} 
    Add Second Passenger To Booking           ${pax_erik_adelaide}
    Add DOCS                                  ${pax_erik_adelaide}  
    Price Itinerary For the Premium Economy Cabin Multipax
    Validate Ticket  
    Add 12H Internet Access For Pax 1
    Print Booking Reference
#done

ROW10
    [Tags]                                     ROW10
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    3    P    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_janne_jarvi}  
    Add DOCS                                  ${pax_janne_jarvi} 
    Add Second Passenger To Booking           ${pax_jonna_jarvi}
    Add DOCS For 2nd PAX                      ${pax_jonna_jarvi}  
    Add Second Passenger To Booking           ${pax_temu_saari}  
    #Add DOCS                                 ${pax_temu_saari}   need a help with the association 
    Price Itinerary For the Premium Economy Cabin Multipax
    Validate Ticket 
    Add Blind Passanger SSR 
    Print Booking Reference  
#done

 ROW11
    [Tags]                                     ROW11
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    T    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_anders_svensson}  
    Add DOCS                                  ${pax_anders_svensson} 
    Add Second Passenger To Booking           ${pax_john_smith}
    Add DOCS                                  ${pax_john_smith} 
    Price Itinerary For the Premium Economy Cabin Multipax
    Validate Ticket
    Add Meal For Pax 1                        DBML    #meal is not chargeable for this class
    Print Booking Reference
#done

ROW12
    [Tags]                                     ROW12
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    438  ${custom filter}  OUL    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_arianne_busse}  
    Add DOCS                                  ${pax_arianne_busse} 
    Price Itinerary
    Validate Ticket
    Add Seat For 1 PAX    2     F    2               #check the seat num in request sheet with Ramya
    Add Seat For 1 PAX    32    K    3 
    Print Booking Reference 
#done

ROW13
    [Tags]                                     ROW13
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    810  ${custom filter}  ARN    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_ariel_falgout}  
    Add DOCS                                  ${pax_ariel_falgout} 
    Price Itinerary
    Validate Ticket
    Add Seat For 1 PAX    13    B    2              
    Add Seat For 1 PAX    33    B    3 
    Print Booking Reference 
#done

ROW14
    [Tags]                                     ROW14
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    T    131  ${custom filter}  HEL    SIN    
    Add Passenger To Booking                  ${pax_aron_couts}  
    Add DOCS                                  ${pax_aron_couts} 
    Add Second Passenger To Booking           ${pax_arica_dunnington}
    Add DOCS For 2nd PAX                      ${pax_arica_dunnington} 
    Price Itinerary For the Premium Economy Cabin Multipax
    Validate Ticket
    Add 1H Internet Access For Pax 1
    Print Booking Reference 
 #done

ROW15
    [Tags]                                     ROW15
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    T    131  ${custom filter}  HEL    SIN    
    Add Passenger To Booking                  ${pax_ashley_easton}  
    Add DOCS                                  ${pax_ashley_easton} 
    Add Second Passenger To Booking           ${pax_armando_ellard}
    Add DOCS For 2nd PAX                      ${pax_armando_ellard} 
    Price Itinerary For the Premium Economy Cabin Multipax
    Validate Ticket
    Add Meal For Pax 1                        AVML       #meal is not chargeable for this class
    Print Booking Reference 
 #done   

ROW16
    [Tags]                                     ROW16
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    B    131  ${custom filter}  HEL    SIN  
    Add Passenger With Extra Seat             ${pax_ashlee_cline}
    Add DOCS                                  ${pax_ashlee_cline}
    Price Itinerary
    Validate Ticket For The Extra Seat
    Print Booking Reference
#done
#cancellation-time element (OPC) in booking - because there are 1 ticket fot 2 passangers (PAX+EXST)

ROW17
    [Tags]                                     ROW17
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    H    131  ${custom filter}  HEL    SIN  
    Add Passenger To Booking                  ${pax_augustine_gazda}  
    Add DOCS                                  ${pax_augustine_gazda} 
    Add Second Passenger To Booking           ${pax_augustina_helbert}
    Add DOCS For 2nd PAX                      ${pax_augustina_helbert} 
    Price Itinerary
    Validate Ticket
    Add Meal For Pax 1                        NLML       #meal is not chargeable for this class
    Print Booking Reference 
#done

ROW18
    [Tags]                                     ROW18
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter}  HEL    SIN  
    Add Passenger To Booking                  ${pax_aurelio_dalke}
    Add DOCS                                  ${pax_aurelio_dalke} 
    Price Itinerary
    Validate Ticket 
    Add WheelChair                                       #for free                       
    Print Booking Reference 
#done

ROW19
    [Tags]                                     ROW19
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter}  HEL    SIN
    Add Passenger To Booking                  ${pax_aurora_charpentier}
    Add DOCS                                  ${pax_aurora_charpentier} 
    Price Itinerary
    Validate Ticket 
    Add Seat For 1 PAX    33    H    2 
    Print Booking Reference
#done 

ROW20    
    [Tags]                                     ROW20
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    K    131  ${custom filter}  HEL    SIN
    #Add Passenger To Booking                  ${pax_aurora_charpentier}   in here has to be some other command to book 2seats 1 for pax and 1 for cabin bag
    Add DOCS                                  ${pax_aurora_charpentier} 
    Price Itinerary
    Validate Ticket 
    Add Extra Bag CBBG  
    Print Booking Reference


#CBBG, skip until issue with the EXST will be resolved - resolved now


#ROW21
  #  [Tags]                                     ROW21
  #  Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
  #  Book Flight On Finnair Operated Flight On Certain Flight Number    1   L    131  ${custom filter}  HEL    SIN
  #  Set Return Date    16 - doesn't work
  #  Book Flight On Finnair Operated Flight On Certain Flight Number    1   L    132  ${custom filter}  SIN    HEL
  #  Add Passenger With Infant    ${pax_anna_slavinski}    Viktoriia
  #  Add DOCS                     ${pax_anna_slavinski}
  #  Add Seat For 1 PAX    31    D    2 


#ROW22       - MISSING FARES FOR L CLASS.
    #[Tags]                                     ROW22
    #Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    #Book Flight On Finnair Operated Flight On Certain Flight Number    1    L    131  ${custom filter}  HEL    SIN
    #Set Return Date    16    #doesn't work
    #Book Flight On Finnair Operated Flight On Certain Flight Number    1    L    132  ${custom filter}  SIN    HEL
    #Add Passenger To Booking                  ${pax_beau_bukowski}
    #Add DOCS                                  ${pax_beau_bukowski} 
    #Price Itinerary
    #Validate Ticket 

    #Add 3H Internet Access For Pax 1

ROW23
    [Tags]                                     ROW23
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    810  ${custom filter}  ARN    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN 
    Add Pax name from Frequent Flyer Number To Booking    680113180
    Add DOCS                                           ${pax_paul_cliff_fbstest}
    Price Itinerary
    Validate Ticket  
    Add Seat For 1 PAX    15    A    2    #seat number changed due to the flight configuration          
    Add Seat For 1 PAX    51    B    3 
    Print Booking Reference 
#done

ROW24
    [Tags]                                     ROW24
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    M    810  ${custom filter}  ARN    HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_bertram_buskirk}
    Add DOCS                                  ${pax_bertram_buskirk} 
    Add Second Passenger To Booking           ${pax_bert_dubois} 
    Add DOCS For 2nd PAX                      ${pax_bert_dubois} 
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Add Seat For 2 PAXes    16    FD    3     #seat number changed due to the flight configuration
    Add Seat For 2 PAXes    52    BC    4     #seat number changed due to the flight configuration
    Print Booking Reference 
#done 

 ROW25
    [Tags]                                     ROW25
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_bettie_crespin}
    Add DOCS                                  ${pax_bettie_crespin} 
    Add Second Passenger To Booking           ${pax_bobby_giordano} 
    Add DOCS For 2nd PAX                      ${pax_bobby_giordano} 
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Add WheelChair 
    Print Booking Reference    

 ROW26
    [Tags]                                     ROW26
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_louisa_smith_umnr}
    Add DOCS For Child                        ${pax_louisa_smith_umnr}
    Price Itinerary
    Validate Ticket
    Add UMNR                #the year of birth in passport info and years in SSR are different. For the testing purpose - ok, but nice to have feature.
    Print Booking Reference 
#done

 ROW27
    [Tags]                                     ROW27
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_branda_devore}
    Add DOCS                                  ${pax_branda_devore}
    Price Itinerary
    Validate Ticket
    Add Seat For 1 PAX    31    C    2 
    Print Booking Reference
#done

 ROW28
    [Tags]                                     ROW28
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_bud_carpio}
    Add DOCS                                  ${pax_bud_carpio}   
    Price Itinerary
    Validate Ticket
    Add Deaf Passanger SSR 
#done

ROW29
    [Tags]                                     ROW29
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    2    M    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_caitlyn_faught}
    Add DOCS                                  ${pax_caitlyn_faught}  
    Add Second Passenger To Booking           ${pax_briitni_felch}  
    Add DOCS For 2nd PAX                      ${pax_briitni_felch} 
    Price Itinerary And Select First Option 2 pax
    Validate Ticket
    Add Meal For Pax 1    LCML                #for free?
#done

#ROW30
  #  [Tags]                                     ROW30
  #  Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
  #  Book Flight On Finnair Operated Flight On Certain Flight Number    4    V    131  ${custom filter}  HEL    SIN 
  #  Set Return Date    16       #doesn't work
  #  Book Flight On Finnair Operated Flight On Certain Flight Number    4   L    132  ${custom filter}  SIN    HEL


#ROW31
   # [Tags]                                     ROW31
   # Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
   # Book Flight On Finnair Operated Flight On Certain Flight Number    1    V    438  ${custom filter}  OUL    HEL 
   # Book Flight On Finnair Operated Flight On Certain Flight Number    1    V    131  ${custom filter}  HEL    SIN 
   # Set Return Date    16       #doesn't work
   # Book Flight On Finnair Operated Flight On Certain Flight Number    1    V    132  ${custom filter}  SIN    HEL


ROW32
    [Tags]                                     ROW32
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_candra_clary}
    Add DOCS                                  ${pax_candra_clary}   
    Price Itinerary
    Validate Ticket
    Add Deportee Passanger SSR  
    Print Booking Reference
#done

ROW33
    [Tags]                                     ROW33
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 









ROW123
    [Tags]                                    ROW132
    #Prepare Variables                        ${origin}     ${destination}
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter}  HEL    SIN
    Add Passenger With Infant                 ${pax_louella_draughn}    ${pax_manuel_infant}            
    Add DOCS for PAX with Infant              ${pax_louella_draughn}    ${pax_manuel_infant}   
    Price Itinerary
    Validate Ticket  
    Print Booking Reference
#done 

#ROW124
#    [Tags]                                    ROW124
#    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
#    Book Flight On Finnair Operated Flight On Certain Flight Number    1    Q    131  ${custom filter}  HEL    SIN
#    Book Return Flight                        1    V    ${day}     ${exact_month}    return_from    return_dst
#    Add Passenger To Booking                  ${pax_loyce_cushenberry}
#    Add DOCS                                  ${pax_loyce_cushenberry}
#    Price Itinerary
#    Validate Ticket 
#    Print Booking Reference
#failing - Return flight issues

ROW125
    [Tags]                                    ROW125
    #Prepare Variables                        ${origin}     ${destination}
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN
    Add Passenger To Booking                  ${pax_loyd_borquez}
    Add DOCS                                  ${pax_loyd_borquez}
    Price Itinerary
    Validate Ticket  
    Print Booking Reference
#done 

ROW126
    [Tags]                                    ROW126
    #Prepare Variables                        ${origin}     ${destination}
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN
    Add Passenger To Booking                  ${pax_luis_gillan}
    Add DOCS                                  ${pax_luis_gillan}
    Price Itinerary
    Validate Ticket  
    Print Booking Reference
#done    

#ROW127
#    [Tags]                                    ROW127
#    #Prepare Variables                        ${origin}     ${destination}
#    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
#    Book Flight On Finnair Operated Flight On Certain Flight Number    3    N    810  ${custom filter}  ARN    HEL
#    Book Flight On Finnair Operated Flight On Certain Flight Number    3    N    131  ${custom filter}  HEL    SIN
#    Book Return Flight                        3    N    ${day}     ${exact_month}    return_from    return_dst
#    Add Passenger With Infant                 ${pax_lupita_masse}     ${pax_marlin_infant}
#    Add DOCS for PAX with Infant              ${pax_lupita_masse}     ${pax_marlin_infant}                               
#    Add Child Passenger                       ${pax_mandie_child}    
#    Add DOCS For Child                        ${pax_mandie_child}       
#    Add Child Passenger                       ${pax_minich_child}   
#    Add DOCS                                  ${pax_minich_child}
#    Price Itinerary
#    Validate Ticket
#    Add Extra Bag PDBG For Pax 1   
#    Print Booking Reference
#adult with infant / return flight / 2nd chilt who is 3rd passenger




#ROW128
#    [Tags]                                    ROW128
#    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
#    Book Flight On NON-PURE Finnair Operated Flight On Certain Flight Number   1    V    1142  ${custom filter non-pure flight}   WAW     HEL
#    Book Flight On Finnair Operated Flight On Certain Flight Number    1    V    131  ${custom filter}  HEL    SIN
#    Book Return Flight                        1    V    ${day}     ${exact_month}    return_from    return_dst
#    Add Passenger To Booking                  ${pax_malvina_haggins}
#    Add DOCS                                  ${pax_malvina_haggins}
#    Price Itinerary
#    Validate Ticket 
#    Print Booking Reference
#failing - why ? something about destination? Return flight issues

ROW129
    [Tags]                                    ROW129
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On NON-PURE Finnair Operated Flight On Certain Flight Number   1    K    1142  ${custom filter non-pure flight}   WAW     HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter} HEL    SIN
    Add Passenger To Booking                  ${pax_maranda_debellis}
    Add DOCS                                  ${pax_maranda_debellis}
    Price Itinerary
    Validate Ticket 
    Print Booking Reference
#failing - why ? something about destination?


ROW130
     [Tags]                                     ROW130
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    2    M    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_marcus_corral}
     Add DOCS                                  ${pax_marcus_corral}
     Add Child Passenger                       ${pax_margarite_child}
     Add DOCS For Child                        ${pax_margarite_child}      
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#failing - why?

ROW131
     [Tags]                                     ROW131
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_marg_cada}
     Add DOCS                                  ${pax_marg_cada}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done

ROW132
     [Tags]                                     ROW132
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    Y    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_margot_dynes}
     Add DOCS                                  ${pax_margot_dynes}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done

ROW133
    [Tags]                                    ROW133
    Set Exact Flight Day                      ${day}      ${exact_month}       ${exact_year}     
    Book Flight On NON-PURE Finnair Operated Flight On Certain Flight Number   1    K    1142  ${custom filter non-pure flight}   WAW     HEL
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter} HEL    SIN
    Add Passenger To Booking                  ${pax_marguerita_gandee}
    Add DOCS                                  ${pax_marguerita_gandee}
    Price Itinerary
    Validate Ticket 
    Print Booking Reference
#failing - why ? something about destination?



#ROW134
#     [Tags]                                     ROW134
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        3    q    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_marianne_funke}
#     Add DOCS                                  ${pax_marianne_funke}
#     Add Second Passenger To Booking           ${pax_miguelina_kleven}
#     Add DOCS For 2nd PAX                      ${pax_miguelina_kleven}
#     Add Child Passenger                       ${pax_maynard_child}
#     Add DOCS For Child                        ${pax_maynard_child}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it   

ROW135
     [Tags]                                     ROW135
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    y    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_marinie_donaghy}
     Add DOCS                                  ${pax_marinie_donaghy}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done

#ROW136
#     [Tags]                                     ROW136
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        3    q    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_marty_emmerich}
#     Add DOCS                                  ${pax_marty_emmerich}
#     Add Second Passenger To Booking           ${pax_milton_garmany}
#     Add DOCS For 2nd PAX                      ${pax_milton_garmany}
#     Add Child Passenger                       ${pax_meta_child}
#     Add DOCS For Child                        ${pax_meta_child}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it     

#ROW137
#     [Tags]                                     ROW137
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        3    q    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_mathew_ellington}
#     Add DOCS                                  ${pax_mathew_ellington}
#     Add Second Passenger To Booking           ${pax_minta_fair}
#     Add DOCS For 2nd PAX                      ${pax_minta_fair}
#     Add Child Passenger                       ${pax_michael_child}
#     Add DOCS For Child                        ${pax_michael_child}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it     

ROW138
     [Tags]                                     ROW138
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    y    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_mattie_bedard}
     Add DOCS                                  ${pax_mattie_bedard}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done

ROW139
     [Tags]                                     ROW139
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    y    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_donati_mckinley}
     Add DOCS                                  ${pax_donati_mckinley}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done


#140-152 have return flight


#ROW153
#     [Tags]                                     ROW154
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_pam_herrman}
#     Add DOCS                                  ${pax_pam_herrman}
#     Add Second Passenger To Booking           ${pax_raleigh_hess}
#     Add DOCS For 2nd PAX                      ${pax_raleigh_hess}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it

#ROW154
#     [Tags]                                     ROW154
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        3    N    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_patria_essary}
#     Add DOCS                                  ${pax_patria_essary}
#     Add Second Passenger To Booking           ${pax_randa_hintze}
#     Add DOCS For 2nd PAX                      ${pax_randa_hintze}
#     Add Child Passenger                       ${pax_rhett_child}  
#     Add DOCS For Child                        ${pax_rhett_child}   
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it 

#ROW155
#     [Tags]                                     ROW155
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_patricia_dunne}
#     Add DOCS                                  ${pax_patricia_dunne}
#     Add Child Passenger                       ${pax_ricarda_child}  
#     Add DOCS For Child                        ${pax_ricarda_child}   
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it 


#ROW156
#     [Tags]                                     ROW156
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        4    V    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_pearline_duncan}
#     Add DOCS                                  ${pax_pearline_duncan}
#     Add Second Passenger To Booking           ${pax_rene_feinberg}
#     Add DOCS For 2nd PAX                      ${pax_rene_feinberg}   
#     Add Child Passenger                       ${pax_rickie_child}  
#     Add DOCS For Child                        ${pax_rickie_child}  
#     Add 2nd child ????                        ${pax_rosalee_child} 
#     Add DOCS For 2nd Child                    ${pax_rosalee_child}  
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it / 2nd child

#ROW157
#     [Tags]                                     ROW157
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_quinton_foust}
#     Add DOCS                                  ${pax_quinton_foust}
#     Add Second Passenger To Booking           ${pax_rima_guthmiller}
#     Add DOCS For 2nd PAX                      ${pax_rima_guthmiller}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it

ROW158
     [Tags]                                     ROW158
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    4    V    131  ${custom filter}  HEL    SIN 
#     Book Return Flight                        4    V    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_rafael_gannaway}
#     Add DOCS                                  ${pax_rafael_gannaway}
#     Add Second Passenger To Booking            ${pax_robin_kanode}
#     Add DOCS For 2nd PAX                      ${pax_robin_kanode}
     Add Passenger With Infant                 ${pax_owen_kirkendoll}      ${pax_rebeca_infant}   
     Add DOCS for PAX with Infant              ${pax_owen_kirkendoll}      ${pax_rebeca_infant} 
#     Add Child Passenger                       ${pax_robin_child}
#     Add DOCS For Child                        ${pax_robin_child}
#     Add DOCS for infant? 3rd pax ?
#     Price Itinerary
#     Validate Ticket  
     Print Booking Reference
#problem with return flight - Katya wanted to finish it   / 3rd pax ? infant ? DOCS ?

#ROW159
#     [Tags]                                     ROW159
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_raphael_glaspie}
#     Add DOCS                                  ${pax_raphael_glaspie}
#     Add Child Passenger                       ${pax_romona_child}
#     Add DOCS For Child                        ${pax_romona_child}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it     


ROW160
     [Tags]                                     ROW160
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    3    B    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_renaldo_beckner}
     Add DOCS                                  ${pax_renaldo_beckner}
     Add Second Passenger To Booking           ${pax_rocco_couts}
     Add DOCS For 2nd PAX                      ${pax_rocco_couts}
     Add Child Passenger                       ${pax_rory_child}
     Add DOCS For Child                        ${pax_rory_child}
     #Add Child Passenger                       ${pax_russaw_child} 
     #Add DOCS For 3th pax child                ${pax_russaw_child}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#not done ; problems with 2nd child passenger


#ROW161
#     [Tags]                                     ROW161
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        4    L    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_rich_bruening}
#     Add DOCS                                  ${pax_rich_bruening}
#     Add Second Passenger To Booking           ${pax_rodger_chancey}
#     Add DOCS For 2nd PAX                      ${pax_rodger_chancey}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it


#ROW162
#     [Tags]                                     ROW162
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Book Return Flight                        4    V    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_robbie_comiskey}
#     Add DOCS                                  ${pax_robbie_comiskey}
#     Add Second Passenger To Booking           ${pax_rolando_heinze}
#     Add DOCS For 2nd PAX                      ${pax_rolando_heinze}
#     Add Passenger To Booking                  ${pax_phillip_lemay}
#     Add DOCS                                  ${pax_phillip_lemay}
#     Add Child Passenger                       ${pax_rosio_child} 
#     Add DOCS For Child                        ${pax_rosio_child}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it - / 3rd pax , 3rd max doc ?

#ROW163
#    [Tags]                                     ROW163
#    Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#    Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#    Add Passenger To Booking                  ${pax_ robt_bozarth} 
#    Add DOCS                                  ${pax_robt_bozarth} 
#    Add Child Passenger                       ${pax_rosita_child}                
#    Add DOCS For Child                        ${pax_rosita_child}
#    Price Itinerary
#    Validate Ticket  
#    Print Booking Reference
#problem with return flight - Katya wanted to finish it

#ROW164
#    [Tags]                                     ROW164 
#    Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#    Book Return Flight                        2    L    ${day}     ${exact_month}    return_from    return_dst
#    Add Passenger To Booking                  ${pax_ronald_corona}
#    Add DOCS                                  ${pax_ronald_corona}
#    Add Second Passenger To Booking           ${pax_rosalee_crisch}
#    Add DOCS For 2nd PAX                      ${pax_rosalee_crisch}
#    Price Itinerary
#    Validate Ticket  
#    Print Booking Reference
#problem with return flight - Katya wanted to finish it 

ROW165
    [Tags]                                     ROW165 
    Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
    Book Flight On Finnair Operated Flight On Certain Flight Number    1    K    131  ${custom filter}  HEL    SIN 
    Add Passenger To Booking                  ${pax_rosamond_etchison}
    Add DOCS                                  ${pax_rosamond_etchison}
    Price Itinerary
    Validate Ticket  
    Print Booking Reference
#done

#ROW166
#     [Tags]                                     ROW167
#     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
#     Set Return Date                           10            
#     Book Return Flight                        1    K    ${day}     ${exact_month}    return_from    return_dst
#     Add Passenger To Booking                  ${pax_roscoe_heal}
#     Add DOCS                                  ${pax_roscoe_heal}
#     Price Itinerary
#     Validate Ticket  
#     Print Booking Reference
#problem with return flight - Katya wanted to finish it 

ROW167
     [Tags]                                     ROW167
     Set Exact Flight Day                      ${day}      ${exact_month}     ${exact_year}
     Book Flight On Finnair Operated Flight On Certain Flight Number    1    M    131  ${custom filter}  HEL    SIN 
     Add Passenger To Booking                  ${pax_rosendo_hibbert}
     Add DOCS                                  ${pax_rosendo_hibbert}
     Price Itinerary
     Validate Ticket  
     Print Booking Reference
#done

    
  
    
ROW1000
     [Tags]                                     ROW1000
     Cancel Booking With Cryptic Katya      OU9A5X
     




    
    




 




***Comments*****
#done# Create a command for the book exact date flight
#done# HEL-ARN-SIN
#done# AY810  AY131
#done# Via Flight, but on the certain flight number (just need to add "optional" arguments?)
#done Change date every time - not a solution

////
E-mail to use? (finnairtesting@gmail.com). If yes, then I suggest to create a new var-s file for the full flight 
creation with new names and we can duplicate the same names, but change the e-mail info
(+change the e-mail for the MA test cases. Do we need to create testers' e-mail box?)
///

SRDOCS AY HK1-P-SGP-012345678-SGP-09MAY78-F-06APR24-ESTEPPE-ALAINA/P1
if adult, then random DOB before 1990 for example, if chd, before 2017, if MS - F, if MR - M, if CHD?
random doc number and random expiration date

#Add DOCS
    #[Documentation]  add DOCS - default pax Emma Adelaide
    #[Arguments]     ${pax_name}=${pax_emma_adelaide}
    #Cryptic Command Verify Output    SRDOCS AY HK1-P-FIN-012345678-FIN-09MAY78-${pax_name[5]}-06APR24-${pax_name[1]}-${pax_name[0]}






