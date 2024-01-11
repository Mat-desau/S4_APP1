----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 04:57:29 PM
-- Design Name: 
-- Module Name: Bin2DualBCD_NS - Behavioral
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

entity Bin2DualBCD_NS is
    Port ( ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           Dizaines : out STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : out STD_LOGIC_VECTOR (3 downto 0));
end Bin2DualBCD_NS;

architecture Behavioral of Bin2DualBCD_NS is
 
begin
    process(ADCbin)
    begin
        case ADCbin is
            when "0000" => 
                Dizaines <= "0000";
                Unites_ns <= "0000";   
            when "0001" => 
                Dizaines <= "0000";
                Unites_ns <= "0001";
            when "0010" => 
                Dizaines <= "0000";
                Unites_ns <= "0010";
            when "0011" => 
                Dizaines <= "0000";
                Unites_ns <= "0011";
            when "0100" => 
                Dizaines <= "0000";
                Unites_ns <= "0100";
            when "0101" => 
                Dizaines <= "0000";
                Unites_ns <= "0101";
            when "0110" => 
                Dizaines <= "0000";
                Unites_ns <= "0110";
            when "0111" => 
                Dizaines <= "0000";
                Unites_ns <= "0111";
            when "1000" => 
                Dizaines <= "0000";
                Unites_ns <= "1000";
            when "1001" => 
                Dizaines <= "0000";
                Unites_ns <= "1001";
            when "1010" => 
                Dizaines <= "0001";
                Unites_ns <= "0000";
            when "1011" => 
                Dizaines <= "0001";
                Unites_ns <= "0001";
            when "1100" => 
                Dizaines <= "0001";
                Unites_ns <= "0010";
            when "1101" => 
                Dizaines <= "0001";
                Unites_ns <= "0011";
            when "1110" => 
                Dizaines <= "0001";
                Unites_ns <= "0100";
            when "1111" => 
                Dizaines <= "0001";
                Unites_ns <= "0101";
            when others => 
                Dizaines <= "0000";
                Unites_ns <= "0000";
        end case;
     end process;
     
end Behavioral;
