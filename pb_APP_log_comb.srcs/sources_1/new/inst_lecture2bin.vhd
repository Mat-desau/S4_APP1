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
           Erreur : out STD_LOGIC := '0';
           Sortie : out STD_LOGIC_VECTOR (3 downto 0));
end Thermo2;

architecture Behavioral of Thermo2 is
    signal temp, temp2 : STD_logic;
    signal IF_OK : std_logic := '0' ;
begin

process (A)
    begin
    Sortie(0) <= A(0) or (A(2) and A(1));
   -- Sortie(0) <= A(0) xnor A(1) xnor A(2);
--    Sortie(1) <= A(1) and A(2);
    Sortie(1) <= A(1);
    Sortie(2) <= '0';
    Sortie(3) <= '0';
   
    IF_OK <= (not A(2) and A(1)) or (A(0) and not A(1));
    
    if IF_OK = '1' then
        Erreur <= '1';
     else 
        Erreur <= '0';
    end if;
end process;
   
end Behavioral;
