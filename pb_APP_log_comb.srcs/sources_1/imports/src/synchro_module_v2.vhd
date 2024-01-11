---------------------------------------------------------------------------------------------
-- synchro_module_v2.vhd 
---------------------------------------------------------------------------------------------
-- Generation d'horloge et de signaux de synchronisation
---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- 
-- Version        : 2.0
-- Nomenclature   : ref GRAMS
-- Date           : 13 sept. 2018, 4 decembre 2018
-- Auteur(s)      : Daniel Dalle
-- Technologies   : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
-- Outils         : vivado 2018.2 64 bits
-- 
--------------------------------
-- Description
--------------------------------
-- Génération de signaux de synchronisation, incluant des "strobes"
-- Voir les comentaires dans la declaration entity pour le description des signaux
-- revisions
-- 4 decembre 2018  : reduction des signaux de sorties
-- 16 octobre 2018  : documentation
-- 13 septembre 2018: creation 
-- 
--------------------------------
-- À FAIRE:
--------------------------------
--
--
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;     -- requis pour les constantes  etc.
use IEEE.STD_LOGIC_UNSIGNED.ALL;  -- pour les additions dans les compteurs

Library UNISIM;
use UNISIM.vcomponents.all;

entity synchro_module_v2 is
generic (const_CLK_syst_MHz: integer := 100); 
    Port ( 
           clkm        : in STD_LOGIC;      -- Entrée  horloge maitre
           o_clk_5MHz  : out  STD_LOGIC;    -- horloge divisee via bufg  
           o_S_1Hz     : out  STD_LOGIC     -- Signal temoin 1 Hz (0,99952 Hz) 
           );                  
end synchro_module_v2;

architecture Behavioral of synchro_module_v2 is

--   component strb_gen is
--       Port ( 
--           CLK      : in STD_LOGIC;    -- Entrée  horloge maitre 
--           i_don    : in  STD_LOGIC;   -- signal pour generer strobe au front montant          
--           o_stb    : out  STD_LOGIC   -- strobe synchrone resultant
--           );                           
--   end component;
 
 -- constantes pour les diviseurs
 constant CLKp_MHz_des : integer := 5; -- Mhz
 constant constante_diviseur_p: integer  :=(const_CLK_syst_MHz/(2*CLKp_MHz_des));    -- considerant toggle sur le signal Clkp5MHzint
 --constant constante_diviseur_p: integer  :=(const_CLK_syst_MHz/(CLKp_MHz_des)-1);
 constant cdiv1 : std_logic_vector(3  downto 0):= conv_std_logic_vector(constante_diviseur_p, 4);     
 constant cdiv2 : std_logic_vector(4 downto 0) := conv_std_logic_vector   (25, 5) ;  -- overflow a Clkp5MHzint/26 = 192.3 kHz  soit 5.2 us
 constant cdiv3 : std_logic_vector(15 downto 0):= conv_std_logic_vector (1848, 16);  -- overflow a Clk200kHzInt / 1924 = 99.952 = ~100 Hz soit 10.005 ms (t réel)
 constant cdiv4 : std_logic_vector(7 downto 0) := conv_std_logic_vector  (99, 8) ;   -- o_S1Hz = o_clk3 / 100    =  1 Hz soit 1 s
  
 -- 
 signal ValueCounter5MHz   : std_logic_vector(4 downto 0)   := "00000";
 signal ValueCounter200kHz : std_logic_vector(4 downto 0)   := "00000";
 signal ValueCounter100Hz  : std_logic_vector(15 downto 0)  := "0000000000000000";
 signal ValueCounter1Hz    : std_logic_vector(7 downto 0)   := "00000000";

 signal d_s5MHzInt  : std_logic := '0';
 signal clk_5MHzInt : std_logic := '0';
 signal d_s1HzInt   : std_logic := '0' ;
 signal d_s100HzInt : std_logic := '0' ;
 signal d_strobe_100HzInt : std_logic := '0' ;
 

begin

-- buffer d'horloge nécessaire pour implémentation d'un signal d'horloge
-- a distribuer dans tout le circuit
ClockBuffer: bufg    
port map(
   I  => d_s5MHzInt,
   O  => clk_5MHzInt
   );
                          
--inst_strb_100Hz : strb_gen 
--    Port map ( 
--      CLK     =>  clk_5MHzInt,
--      i_don   =>  d_s100HzInt,     
--      o_stb   =>  d_strobe_100HzInt
--      );           

o_clk_5MHz  <= clk_5MHzInt;
--o_S_100Hz   <= d_s100HzInt;
o_S_1Hz     <= d_s1HzInt;
--o_stb_100Hz <= d_strobe_100HzInt;

process(clkm)
begin
   if(clkm'event and clkm = '1') then
       ValueCounter5MHz <= ValueCounter5MHz + 1;
       if (ValueCounter5MHz = cdiv1) then               -- evenement se produit aux 100 approx ns
            ValueCounter5MHz <= "00000";
            d_s5MHzInt <= Not d_s5MHzInt;               -- pour generer horloge a exterieur du module (prevoir bufg)   
            ValueCounter200kHz <= ValueCounter200kHz + 1;
            if (ValueCounter200kHz = cdiv2) then        -- evenement se produit aux 5 us approx
                 ValueCounter200kHz <= "00000";
                 ValueCounter100Hz <= ValueCounter100Hz + 1;
                 if (ValueCounter100Hz = cdiv3) then    -- evenement se produit aux 5 ms  approx
                      ValueCounter100Hz <= "0000000000000000";
                     -- d_s100HzInt <= Not d_s100HzInt;
                      ValueCounter1Hz <= ValueCounter1Hz + 1;
                      if (ValueCounter1Hz = cdiv4) then -- evenement se produit aux 500 ms approx
                          ValueCounter1Hz <= "00000000";
                          d_s1HzInt <= Not d_s1HzInt;
                      end if;
                 end if;
            end if;                 
      end if;
   end if;
end process;


end Behavioral;

