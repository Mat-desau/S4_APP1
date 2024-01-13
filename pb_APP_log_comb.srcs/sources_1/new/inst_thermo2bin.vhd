----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/12/2024 06:10:36 PM
-- Design Name: 
-- Module Name: inst_thermo2bin - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Thermo2bin is
    Port ( ADCth  : in STD_LOGIC_VECTOR (11 downto 0);
           ADCbin : out STD_LOGIC_VECTOR (3 downto 0);
           Erreur_thermo : out STD_LOGIC := '0'
           );
end Thermo2bin;

architecture Behavioral of Thermo2bin is

component Thermo2 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           Erreur : out STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (3 downto 0));
    end component; 
    
component Add4bits is
    Port ( A_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_4 : in STD_LOGIC;
           Sum_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_4 : out STD_LOGIC);
end component; 
    
    signal sum1, sum2 : Std_logic_vector (3 downto 0) := "0000";
    signal Rep1, Rep2, Rep3, Rep4 : std_logic_vector (3 downto 0) := "0000";
    signal Erreur_temp1, Erreur_temp2, Erreur_temp3, Erreur_temp4  : std_logic := '0';
    
begin

  inst_Thermo2_1 : Thermo2
   port map(
            a => ADCth(2 downto 0),
            erreur => Erreur_temp1, 
            Sortie => Rep1        
    );
    
    inst_Thermo2_2 : Thermo2
   port map(
            a => ADCth(5 downto 3),
            erreur => Erreur_temp2, 
            Sortie => Rep2        
    );
    
    inst_Thermo2_3 : Thermo2
   port map(
            a => ADCth(8 downto 6),
            erreur => Erreur_temp3, 
            Sortie => Rep3        
    );
    
    inst_Thermo2_4 : Thermo2
   port map(
            a => ADCth(11 downto 9),
            erreur => Erreur_temp4, 
            Sortie => Rep4        
    );
 
 inst_Add4_1 : Add4bits
    port map
        (
        A_4 => Rep1,
        B_4 => Rep2,
        Cin_4 => '0',
        Sum_4 => Sum1,
        Cout_4 => open
        );   
    
inst_Add4_2 : Add4bits
    port map
        (
        A_4 => Sum1,
        B_4 => Rep3,
        Cin_4 => '0',
        Sum_4 => Sum2,
        Cout_4 => open
        ); 
         
inst_Add4_3 : Add4bits
    port map
        (
        A_4 => Sum2,
        B_4 => Rep4,
        Cin_4 => '0',
        Sum_4 => ADCbin,
        Cout_4 => open
        );
        
Erreur_thermo <= erreur_temp1 or erreur_temp2 or erreur_temp3 or erreur_temp4 ;
        


end Behavioral;
