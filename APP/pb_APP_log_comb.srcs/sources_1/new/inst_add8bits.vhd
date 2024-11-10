----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/11/2024 04:36:57 PM
-- Design Name: 
-- Module Name: Add8bit - Behavioral
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

entity Add12bit is
    Port ( A : in STD_LOGIC_VECTOR (11 downto 0);
           B : in STD_LOGIC_VECTOR (11 downto 0);
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC_VECTOR (11 downto 0));
end Add12bit;

architecture Behavioral of Add12bit is

signal Carry1, Carry2: std_logic;

component Add4bits is
    Port ( A_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_4 : in STD_LOGIC;
           Sum_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_4 : out STD_LOGIC);
end component;

begin

inst_Add4_1 : Add4bits
port map
    (
    A_4 => A (3 downto 0),
    B_4 => B (3 downto 0),
    Cin_4 => '0',
    Sum_4 => Sum (3 downto 0),
    Cout_4 => Carry1
    );
    
inst_Add4_2 : Add4bits
port map
    (
    A_4 => A (7 downto 4),
    B_4 => B (7 downto 4),
    Cin_4 => Carry1,
    Sum_4 => Sum (7 downto 4),
    Cout_4 => Carry2
    );

inst_Add4_3 : Add4bits
port map
    (
    A_4 => A (11 downto 8),
    B_4 => B (11 downto 8),
    Cin_4 => Carry2,
    Sum_4 => Sum (11 downto 8),
    Cout_4 => Cout
    );

end Behavioral;
