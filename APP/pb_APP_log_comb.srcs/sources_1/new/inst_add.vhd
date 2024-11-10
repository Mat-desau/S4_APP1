----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2024 12:22:29 PM
-- Design Name: 
-- Module Name: additioneur - Behavioral
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

entity Add1bit is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Cin : in STD_LOGIC;
           Cout : out STD_LOGIC;
           Sum : out STD_LOGIC);
end Add1bit;

architecture Behavioral of Add1bit is

begin


--    process(A, B, Cin)
--    begin
--        case A is
--            when '0' =>
--                case B is
--                    when '0' => 
--                        case Cin is
--                            when '0' => 
--                            --000
--                                Sum <= '0';
--                                Cout <= '0';
--                            when others =>
--                            --001
--                                Sum <= '1';
--                                Cout <= '0';
--                        end case;
--                    when others => 
--                        case Cin is
--                            when '0' => 
--                            --010
--                                Sum <= '1';
--                                Cout <= '0';
--                            when others =>
--                            --011
--                                Sum <= '0';
--                                Cout <= '1';
--                    end case;
--                end case;
--            when others =>
--                case B is
--                    when '0' => 
--                        case Cin is
--                            when '0' => 
--                            --100
--                                Sum <= '1';
--                                Cout <= '0';
--                            when others =>
--                            --101
--                                Sum <= '0';
--                                Cout <= '1';
--                        end case;
--                    when others => 
--                        case Cin is
--                            when '0' => 
--                            --110
--                                Sum <= '0';
--                                Cout <= '1';
--                            when others =>
--                            --111
--                                Sum <= '1';
--                                Cout <= '1';
--                    end case;
--                end case;
--        end case;
--    end process;


  Sum <= A xor B xor Cin;
  Cout <= (A and B) or (Cin and B) or (Cin and A);

end Behavioral;
