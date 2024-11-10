----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 04:59:25 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_S - Behavioral
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

entity Bin2DualBCD_S is
    Port ( Moins5 : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : out STD_LOGIC_VECTOR (3 downto 0);
           Unite_s : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD_S;

architecture Behavioral of Bin2DualBCD_S is

begin
    process(Moins5)
    begin
        case Moins5 is
            when "0000" => 
                Code_signe <= "0000";
                Unite_s <= "0000";   
            when "0001" => 
                Code_signe <= "0000";
                Unite_s <= "0001";
            when "0010" => 
                Code_signe <= "0000";
                Unite_s <= "0010";
            when "0011" => 
                Code_signe <= "0000";
                Unite_s <= "0011";
            when "0100" => 
                Code_signe <= "0000";
                Unite_s <= "0100";
            when "0101" => 
                Code_signe <= "0000";
                Unite_s <= "0101";
            when "0110" => 
                Code_signe <= "0000";
                Unite_s <= "0110";
            when "0111" => 
                Code_signe <= "0000";
                Unite_s <= "0111";
            when "1000" => 
                Code_signe <= "1101";
                Unite_s <= "1000";
            when "1001" => 
                Code_signe <= "1101";
                Unite_s <= "0111";
            when "1010" => 
                Code_signe <= "1101";
                Unite_s <= "0110";
            when "1011" => 
                Code_signe <= "1101";
                Unite_s <= "0101";
            when "1100" => 
                Code_signe <= "1101";
                Unite_s <= "0100";
            when "1101" => 
                Code_signe <= "1101";
                Unite_s <= "0011";
            when "1110" => 
                Code_signe <= "1101";
                Unite_s <= "0010";
            when "1111" => 
                Code_signe <= "1101";
                Unite_s <= "0001";
            when others => 
                Code_signe <= "0000";
                Unite_s <= "0000";
        end case;
     end process;
end Behavioral;
