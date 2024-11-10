----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 02:19:48 PM
-- Design Name: 
-- Module Name: Fct2_3 - Behavioral
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

entity Fct2_3 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           A2_3 : out STD_LOGIC_VECTOR (2 downto 0));
end Fct2_3;

architecture Behavioral of Fct2_3 is

signal D1, D3, D5, D7 : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
signal Sum1, Sum2, SumFinale : STD_LOGIC_VECTOR (11 downto 0);



component Add12bit is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (11 downto 0));
end component;

begin
    D1 (10 downto 7) <= ADCbin;
    D3 (8 downto 5) <= ADCbin;
    D5 (6 downto 3) <= ADCbin;
    D7 (4 downto 1) <= ADCbin;
    
inst_add12bit_1 : Add12bit 
port map
    ( A => D1,
      B => D3,
      Cin => '0',
      Cout => open,
      Sum => Sum1
    );

inst_add12bit_2 : Add12bit 
port map
    ( A => Sum1,
      B => D5,
      Cin => '0',
      Cout => open,
      Sum => Sum2
    );

inst_add12bit_3 : Add12bit 
port map
    ( A => Sum2,
      B => D7,
      Cin => '0',
      Cout => open,
      Sum => SumFinale
    );
 
 A2_3 <= SumFinale (10 downto 8) ;
 
end Behavioral;
