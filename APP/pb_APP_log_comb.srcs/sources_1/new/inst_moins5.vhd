----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 04:23:55 PM
-- Design Name: 
-- Module Name: Moins5 - Behavioral
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

entity Moins_5 is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Moins5 : out STD_LOGIC_VECTOR (3 downto 0));
end Moins_5;

architecture Behavioral of Moins_5 is

component Add4bits is
    Port ( A_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_4 : in STD_LOGIC;
           Sum_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_4 : out STD_LOGIC);
end component;
 --1011 c'est notre -5 parce que 0101 est 5 et on fait complement 2
 
begin

inst_Add4bits : Add4bits
Port map(
        A_4 => ADCbin,
        B_4 => "1011",
        Cin_4 => '0',
        Sum_4 => Moins5,
        Cout_4 => open
        );       
    
end Behavioral;
