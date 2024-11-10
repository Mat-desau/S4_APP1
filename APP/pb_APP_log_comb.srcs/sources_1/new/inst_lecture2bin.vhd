----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/12/2024 06:14:51 PM
-- Design Name: 
-- Module Name: Thermo2 - Behavioral
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

entity Thermo2 is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           Erreur : out STD_LOGIC;
           Sortie : out STD_LOGIC_VECTOR (3 downto 0)
          );
          
end Thermo2;

architecture Behavioral of Thermo2 is
    signal temp, temp2 : STD_logic;
    
 component check_erreur is
     Port (
            entree      : in std_logic_vector (2 downto 0);
            sortie      : out std_logic  
           );
end component;   
    
begin

inst_check_erreur : check_erreur
    port map(
            entree => A,
            sortie => Erreur
            );

-- Sortie(0) <= A(0) or (A(2) and A(1));
Sortie(0) <= A(0) xor (A(1) xor A(2));
Sortie(1) <= A(1);
Sortie(3 downto 2) <= "00"; 
   
end Behavioral;
