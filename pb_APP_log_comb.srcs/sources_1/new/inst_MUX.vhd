----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2024 04:43:43 PM
-- Design Name: 
-- Module Name: MUX - Behavioral
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

--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
    Port ( Dizaine : in STD_LOGIC_VECTOR (3 downto 0);
           Unites_ns : in STD_LOGIC_VECTOR (3 downto 0);
           Code_signe : in STD_LOGIC_VECTOR (3 downto 0);
           Unites_s : in STD_LOGIC_VECTOR (3 downto 0);
           ADCbin : in STD_LOGIC_VECTOR (3 downto 0);
           erreur : in STD_LOGIC;
           BTN : in STD_LOGIC_VECTOR (1 downto 0);
           S2 : in STD_LOGIC;
           DAFF0 : out STD_LOGIC_VECTOR (3 downto 0);
           DAFF1 : out STD_LOGIC_VECTOR (3 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
    process (Dizaine, Unites_ns, Code_signe, Unites_s, ADCbin, erreur, BTN, S2)
        begin
            case BTN is
             when "00" => DAFF1 <= Dizaine ; DAFF0 <= Unites_ns;
             when "01" => DAFF1 <= "0000" ; DAFF0 <= ADCbin;
             when "10" => DAFF1 <= Code_signe ; DAFF0 <= Unites_s;
             when "11" => DAFF1 <= "1110" ; DAFF0 <= "1111";
             when others => DAFF1 <= "0000" ; DAFF0 <= "0000";   
            end case;
            
            if S2 = '1' or erreur = '1' then
             DAFF1 <= "1110" ; 
             DAFF0 <= "1111";
            end if;
            
            
            
            
             
        end process;

end Behavioral;
