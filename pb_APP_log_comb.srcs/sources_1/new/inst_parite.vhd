----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 02:31:29 PM
-- Design Name: 
-- Module Name: Parite - Behavioral
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

entity Parite is
    Port ( S1 : in STD_LOGIC;
           ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           parite : out STD_LOGIC);
end Parite;

architecture Behavioral of Parite is

    signal parite_temp : STD_LOGIC;
    
begin
    process(S1, ADCbin)
    begin
        case ADCbin is
            when "0000" => parite_temp <= '0';
            when "0001" => parite_temp <= '1';
            when "0010" => parite_temp <= '1';
            when "0011" => parite_temp <= '0';
            when "0100" => parite_temp <= '1';
            when "0101" => parite_temp <= '0';
            when "0110" => parite_temp <= '0';
            when "0111" => parite_temp <= '1';
            when "1000" => parite_temp <= '1';
            when "1001" => parite_temp <= '0';
            when "1010" => parite_temp <= '0';
            when "1011" => parite_temp <= '1';
            when "1100" => parite_temp <= '0';
            when "1101" => parite_temp <= '1';
            when "1110" => parite_temp <= '1';
            when "1111" => parite_temp <= '0';
            when others => parite_temp <= '0';
        end case;
        
        if S1 = '1' then
            parite <= parite_temp;
        else 
            parite <= not parite_temp; 
        end if;
        
     end process;
    
end Behavioral;
