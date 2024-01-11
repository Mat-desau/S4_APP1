----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 12:34:08 PM
-- Design Name: 
-- Module Name: Additionneur_4bits - Behavioral
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

entity Add4bits is
    Port ( A_4 : in STD_LOGIC_VECTOR (3 downto 0);
           B_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Cin_4 : in STD_LOGIC;
           Sum_4 : out STD_LOGIC_VECTOR (3 downto 0);
           Cout_4 : out STD_LOGIC);
end Add4bits;

architecture Behavioral of Add4bits is
    component Add1bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC);
    end component;
    
    signal C1 : std_logic;
    signal C2 : std_logic;
    signal C3 : std_logic;
    signal C4 : std_logic;
    
begin
    inst_addA : Add1bit
    Port map(
        A => A_4(0),
        B => B_4(0),
        Cin => Cin_4,
        Cout => C1,
        Sum => Sum_4(0)
        );
    
    inst_addB : Add1bit
    Port map(
        A => A_4(1),
        B => B_4(1),
        Cin => C1,
        Cout => C2,
        Sum => Sum_4(1)
        );
    
    inst_addC : Add1bit
    Port map(
        A => A_4(2),
        B => B_4(2),
        Cin => C2,
        Cout => C3,
        Sum => Sum_4(2)
        );
     
     inst_addD : Add1bit
    Port map(
        A => A_4(3),
        B => B_4(3),
        Cin => C3,
        Cout => Cout_4,
        Sum => Sum_4(3)
        );

end Behavioral;
