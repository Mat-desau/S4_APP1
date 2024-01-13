---------------------------------------------------------------------------------------------
-- labo_adder4b_sol_tb.vhd
---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- Version         : 3.0
-- Nomenclature    : GRAMS
-- Date Révision   : 21 Avril 2020
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle, Marc-André Tétrault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--                   peripheriques: carte Thermo12, Pmod8LD PmodSSD
--
-- Outils          : vivado 2019.1 64 bits
---------------------------------------------------------------------------------------------
-- Description:
-- Banc d'essai pour circuit combinatoire Laboratoire logique combinatoire
-- Version avec entrées toutes combinatoires CIRCUIT COMPLET (TOP)
-- 
-- Revision v1 12 novembre 2018, 3 décembre 2018 D. Dalle 
-- Revision 30 Avril 2021, M-A Tetrault
--
---------------------------------------------------------------------------------------------
-- Notes :
-- L'entrée retenue (i_cin) est générée par l'interrupteur S1 de la carte Thermobin
--
---------------------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- requis pour enoncés de type mem_valeurs_tests(to_integer( unsigned(table_valeurs_adr(9 downto 6) )));
USE ieee.numeric_std.ALL;          -- 
use IEEE.STD_LOGIC_UNSIGNED.ALL;   --


entity Thermo2Bin_TB is
--  Port ( );
end Thermo2Bin_TB;

architecture Behavioral of Thermo2Bin_TB is

COMPONENT verif_show_affhex is
end COMPONENT;

component Thermo2bin is
    Port ( ADCth  : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           Erreur_thermo : out STD_LOGIC := '0'
           );
end COMPONENT;

   signal clk_sim       :  STD_LOGIC := '0';
   signal pmodled_sim   :  STD_LOGIC_VECTOR (7 DOWNTO 0);
   signal led_sim       :  STD_LOGIC_VECTOR (3 DOWNTO 0);
   signal led6_r_sim    :  STD_LOGIC := '0';
   signal SSD_sim       :  STD_LOGIC_VECTOR (7 DOWNTO 0) := "00000000";
   signal sw_sim        :  STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
   signal btn_sim       :  STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000";
   signal cin_sim       :  STD_LOGIC := '0';
   signal vecteur_test_sim   :  STD_LOGIC_VECTOR (11 DOWNTO 0) := (others => '0');
   signal resultat_attendu       :  STD_LOGIC_VECTOR (4 DOWNTO 0) := "00000";

   signal vecteur_Entree_sim   :  STD_LOGIC_VECTOR (11 DOWNTO 0);
   signal vecteur_ADC_sim      :  STD_LOGIC_VECTOR (3 DOWNTO 0);
   signal vecteur_Erreur_sim   :  STD_LOGIC;
       
   constant sysclk_Period  : time := 8 ns;
   


----------------------------------------------------------------------------
-- declaration d'un tableau pour soumettre un vecteur de test  
----------------------------------------------------------------------------  
 type table_valeurs_tests is array (integer range 0 to 63) of std_logic_vector(11 downto 0);
    constant mem_valeurs_tests : table_valeurs_tests := 
    ( 
  --  vecteur de test è modifier selon les besoins
  --  res      op_a     op_b    cin
    "000000000000",
    "000000000001",
    "000000000011",
    "000000000111",
    "000000001111",
    "000000000110",
    "000000011000",
    "000000011111",
    "000000000001",
    
    others => "000000000000"
    );
----------------------------------------------------------------------------

begin


-- Pattes du FPGA Zybo-Z7
inst_Test : Thermo2bin
    Port map ( 
           ADCth  => vecteur_Entree_sim,
           ADCbin => vecteur_ADC_sim,
           Erreur_thermo => vecteur_Erreur_sim
           );
   
   

	-- Section banc de test
    ----------------------------------------
	-- generation horloge 
	----------------------------------------
   process
   begin
       clk_sim <= '1';  -- init
       loop
           wait for sysclk_Period/2;
           clk_sim <= not clk_sim;    -- invert clock value
       end loop;
   end process;  
	----------------------------------------
   
   ----------------------------------------
   -- test bench
   tb : PROCESS
       variable delai_sim : time  := 50 ns;
       variable table_valeurs_adr : integer range 0 to 63;

      BEGIN
         -- Phase 1
         wait for delai_sim;
         table_valeurs_adr := 0;
         -- simuler une sequence de valeurs a l'entree 
         for index in 0 to   mem_valeurs_tests'length-1 loop
         
              vecteur_test_sim <= mem_valeurs_tests(table_valeurs_adr);
              vecteur_Entree_sim  <= vecteur_test_sim;
             
              wait for delai_sim;
			  --assert (resultat_attendu /= (probe_adder_result) ) report "Resultat pas celui prévu." severity warning; 
              table_valeurs_adr := table_valeurs_adr + 1;
			  if(table_valeurs_adr = 63) then
				exit;
			  end if;
         end loop; 
           
         WAIT; -- will wait forever
      END PROCESS;

END Behavioral;
