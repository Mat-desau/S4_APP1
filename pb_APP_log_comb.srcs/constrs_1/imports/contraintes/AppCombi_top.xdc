## circuit_labo_adder_4b.xdc
## This file is a general .xdc for the Zybo Z7 Rev. B
## It is compatible with the Zybo Z7-20 and Zybo Z7-10
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Adaptation  circuit_labo_adder_4b
## D. Dalle, novembrere 2018
## Simplification - retrait des lignes en double/triple
## M-A Tétrault, Janvier 2022
##

## Section préconfigurée - atelier, laboratoire et problématique

##Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { sysclk }]; #IO_L12P_T1_MRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { sysclk }];

##Switches (Circuit_Thermo_Bin, circuit_labo_adder_4b)
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { i_sw[0] }]; #IO_L19N_T3_VREF_35 Sch=sw[0]
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { i_sw[1] }]; #IO_L24P_T3_34 Sch=sw[1]
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { i_sw[2] }]; #IO_L4N_T0_34 Sch=sw[2]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { i_sw[3] }]; #IO_L9P_T1_DQS_34 Sch=sw[3]

##Buttons (Circuit_Thermo_Bin, labo_adder4b)
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { i_btn[0] }]; #IO_L12N_T1_MRCC_35 Sch=btn[0]
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { i_btn[1] }]; #IO_L24N_T3_34 Sch=btn[1]
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { i_btn[2] }]; #IO_L10P_T1_AD11P_35 Sch=btn[2]
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { i_btn[3] }]; #IO_L7P_T1_34 Sch=btn[3]


##LEDs   (Circuit_Thermo_Bin, labo_adder4b)
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { o_led[0] }]; #IO_L23P_T3_35 Sch=led[0]
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { o_led[1] }]; #IO_L23N_T3_35 Sch=led[1]
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { o_led[2] }]; #IO_0_35 Sch=led[2]
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { o_led[3] }]; #IO_L3N_T0_DQS_AD1N_35 Sch=led[3]

##RGB LED 6 (labo_adder4b a decider)
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { o_led6_r }]; #IO_L18P_T2_34 Sch=led6_r
##set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { led6_g }]; #IO_L6N_T0_VREF_35 Sch=led6_g
##set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { led6_b }]; #IO_L8P_T1_AD10P_35 Sch=led6_b



## Section préconfigurée - laboratoire et problématique
#  Note: il faut retirer les "#" au début des lignes "set_property"
#        pour activer ces liaisons physique


##Pmod Header JA (Circuit_Thermo_Bin, labo_adder4b: branchement: PmodSSD)
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[0] }]; #IO_L21P_T3_DQS_AD14P_35 Sch=JA1_R_p		#  pmod haut   
set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[1] }]; #IO_L22P_T3_AD7P_35 Sch=JA2_R_P          #  pmod haut   
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[2] }]; #IO_L24P_T3_AD15P_35 Sch=JA3_R_P         #  pmod haut    
set_property -dict { PACKAGE_PIN K14   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[3] }]; #IO_L20P_T3_AD6P_35 Sch=JA4_R_P          #  pmod haut   
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[4] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=JA1_R_N    #  pmod bas  
set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[5] }]; #IO_L22N_T3_AD7N_35 Sch=JA2_R_N         #  pmod bas  
set_property -dict { PACKAGE_PIN J16   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[6] }]; #IO_L24N_T3_AD15N_35 Sch=JA3_R_N        #  pmod bas
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { o_SSD[7] }]; #IO_L20N_T3_AD6N_35 Sch=JA4_R_N         #  pmod bas 

##Pmod Header JC  (Circuit_Thermo_Bin, circuit_labo_adder_4b: branchement : Pmod8LD)
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[0] }]; #IO_L10P_T1_34 Sch=jc_p[1]     #  pmod haut		 
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[1] }]; #IO_L10N_T1_34 Sch=jc_n[1]     #  pmod haut	     
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[2] }]; #IO_L1P_T0_34 Sch=jc_p[2]      #  pmod haut
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[3] }]; #IO_L1N_T0_34 Sch=jc_n[2]      #  pmod haut   
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[4] }]; #IO_L8P_T1_34 Sch=jc_p[3]      # pmod bas        
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[5] }]; #IO_L8N_T1_34 Sch=jc_n[3]      # pmod bas       
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[6] }]; #IO_L2P_T0_34 Sch=jc_p[4]      # pmod bas        
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33     } [get_ports { o_pmodled[7] }]; #IO_L2N_T0_34 Sch=jc_n[4]      # pmod bas
 


## Section partiellement préconfigurée - problématique
#  Note: Vous devez renommer le nom du port pour correspondre à votre projet.
#        Il faut également retirer les "#" au début des lignes "set_property"
#        pour activer ces liaisons physique
 
##Pmod Header JD     (Circuit_Thermo_Bin)                                                                                                              
#set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[0] }]; #IO_L5P_T0_34 Sch=jd_p[1]                  
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[1] }]; #IO_L5N_T0_34 Sch=jd_n[1]				 
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[2] }]; #IO_L6P_T0_34 Sch=jd_p[2]                  
#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[3] }]; #IO_L6N_T0_VREF_34 Sch=jd_n[2]             
#set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[4] }]; #IO_L11P_T1_SRCC_34 Sch=jd_p[3]            
#set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[5] }]; #IO_L11N_T1_SRCC_34 Sch=jd_n[3]            
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[6] }]; #IO_L21P_T3_DQS_34 Sch=jd_p[4]             
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33     } [get_ports { i_ADC_th[7] }]; #IO_L21N_T3_DQS_34 Sch=jd_n[4]             
                                                                                                                              
##Pmod Header JE   (Circuit_Thermo_Bin)                                                                                                                
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { i_ADC_th[8]}];   #IO_L4P_T0_34 Sch=je[1]			 
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { i_ADC_th[9]}];   #IO_L18N_T2_34 Sch=je[2]            
#set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { i_ADC_th[10] }]; #IO_25_35 Sch=je[3]  
#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { i_ADC_th[11] }]; #IO_L19P_T3_35 Sch=je[4]                    
#set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { o_DEL2 }];        #IO_L3N_T0_DQS_34 Sch=je[7]                  
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { o_DEL3 }];        #IO_L9N_T1_DQS_34 Sch=je[8]                  
#set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { i_S1 }];       #IO_L20P_T3_34 Sch=je[9]            
#set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { i_S2 }];       #IO_L7N_T1_34 Sch=je[10]



 


