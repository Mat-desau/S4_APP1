---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date            : 21 Avril 2020
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle, Marc-André Tétrault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Circuit utilitaire pour le laboratoire et la problématique de logique combinatoire
--
---------------------------------------------------------------------------------------------
-- À faire :
-- Voir le guide de l'APP
--    Insérer les modules additionneurs ("components" et "instances")
--
---------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity AppCombi_top is
  port ( 
          i_btn       : in    std_logic_vector (3 downto 0); -- Boutons de la carte Zybo
          i_sw        : in    std_logic_vector (3 downto 0); -- Interrupteurs de la carte Zybo
          sysclk      : in    std_logic;                     -- horloge systeme
          o_SSD       : out   std_logic_vector (7 downto 0); -- vers cnnecteur pmod afficheur 7 segments
          o_led       : out   std_logic_vector (3 downto 0); -- vers DELs de la carte Zybo
          o_led6_r    : out   std_logic;                     -- vers DEL rouge de la carte Zybo
          o_pmodled   : out   std_logic_vector (7 downto 0)  -- vers connecteur pmod 8 DELs
          );
end AppCombi_top;

architecture BEHAVIORAL of AppCombi_top is

   constant nbreboutons     : integer := 4;    -- Carte Zybo Z7
   constant freq_sys_MHz    : integer := 125;  -- 125 MHz 
   
   signal d_s_1Hz           : std_logic;
   signal clk_5MHz          : std_logic;
   --
   signal d_opa             : std_logic_vector (3 downto 0):= "0000";   -- operande A
   signal d_opb             : std_logic_vector (3 downto 0):= "0000";   -- operande B
   signal d_cin             : std_logic := '0';                         -- retenue entree
   signal d_sum             : std_logic_vector (3 downto 0):= "0000";   -- somme
   signal d_cout            : std_logic := '0';                         -- retenue sortie
   --
   signal d_AFF0            : std_logic_vector (3 downto 0):= "0000";
   signal d_AFF1            : std_logic_vector (3 downto 0):= "0000";
 
   
   component synchro_module_v2 is
   generic (const_CLK_syst_MHz: integer := freq_sys_MHz);
      Port ( 
           clkm        : in  STD_LOGIC;  -- Entrée  horloge maitre
           o_CLK_5MHz  : out STD_LOGIC;  -- horloge divise utilise pour le circuit             
           o_S_1Hz     : out  STD_LOGIC  -- Signal temoin 1 Hz
            );
      end component;  

    component septSegments_Top is
    Port (   clk          : in   STD_LOGIC;                      -- horloge systeme, typique 100 MHz (preciser par le constante)
             i_AFF0       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0
             i_AFF1       : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 8 bits : chiffre hexa position 1 et 0     
             o_AFFSSD_Sim : out string(1 to 2);
             o_AFFSSD     : out  STD_LOGIC_VECTOR (7 downto 0)  
           );
   end component;
   
   --À FAIRE
   component decodeur3_8 is
   Port (   A2_3          : in  STD_LOGIC_VECTOR (2 downto 0);
            LED           : out STD_LOGIC_VECTOR (7 downto 0)
           );
   end component;
   
   component Fct2_3 is
   Port ( ADCbin          : in  STD_LOGIC_VECTOR (3 downto 0);
           A2_3           : out STD_LOGIC_VECTOR (2 downto 0)
           );
    end component;
    
    component Parite is
    Port ( S1             : in STD_LOGIC;
           ADCbin         : in STD_LOGIC_VECTOR (3 downto 0);
           parite         : out STD_LOGIC
           );
    end component;
    
    component Add4bits is
    Port ( A_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_4 : in STD_LOGIC;
           Sum_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_4 : out STD_LOGIC);
    end component;
    
    component Bin2DualBCD is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
begin
  
    inst_synch : synchro_module_v2
     generic map (const_CLK_syst_MHz => freq_sys_MHz)
         port map (
            clkm         => sysclk,
            o_CLK_5MHz   => clk_5MHz,
            o_S_1Hz      => d_S_1Hz
        );  

   inst_aff :  septSegments_Top 
       port map (
           clk    => clk_5MHz,
           -- donnee a afficher definies sur 8 bits : chiffre hexa position 1 et 0
           i_AFF1  => d_AFF1, 
           i_AFF0  => d_AFF0,
           o_AFFSSD_Sim   => open,   -- ne pas modifier le "open". Ligne pour simulations seulement.
           o_AFFSSD       => o_SSD   -- sorties directement adaptees au connecteur PmodSSD
       );
    
    
    --À FAIRE
--    inst_add : Add4bits
--    port map(   A_4 => d_opa,
--                B_4 => d_opb,
--                Cin_4 => '0',
--                Sum_4 => d_sum,
--                Cout_4 => d_cout
--             );
    
    inst_Bin2DualBCD : Bin2DualBCD
        Port map(
                ADCbin => d_opa,
                Dizaines => open,
                Unites_ns => open,
                Code_signe => d_AFF1,
                Unite_s => d_AFF0
                );
    
   -- inst_deco : decodeur3_8;
    
   -- inst_2_3 : Fct2_3;
    
    -- inst_parite : Parite;
             
   d_opa               <=  i_sw;                        -- operande A sur interrupteurs
   d_opb               <=  i_btn;                       -- operande B sur boutons
   d_cin               <=  '0';                     -- la retenue d'entrée alterne 0 1 a 1 Hz
      
   --d_AFF0              <=  d_sum(3 downto 0);           -- Le resultat de votre additionneur affiché sur PmodSSD(0)
   --d_AFF1              <=  '0' & '0' & '0' & d_Cout;    -- La retenue de sortie affichée sur PmodSSD(1) (0 ou 1)
   o_led6_r            <=  d_Cout;                      -- La led couleur représente aussi la retenue en sortie  Cout
   o_pmodled           <=  d_opa & d_opb;               -- Les opérandes d'entrés reproduits combinés sur Pmod8LD
   o_led (3 downto 0)  <=  '0' & '0' & '0' & d_S_1Hz;   -- La LED0 sur la carte représente la retenue d'entrée        
   
   
end BEHAVIORAL;


