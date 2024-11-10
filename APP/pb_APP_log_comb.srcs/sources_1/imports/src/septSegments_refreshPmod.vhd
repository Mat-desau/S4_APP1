---------------------------------------------------------------------------------------------
-- circuit affhex_pmodssd.vhd
---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- APP de circuits logiques
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle, Marc-André Tétrault
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--
---------------------------------------------------------------------------------------------
-- Description:
-- Séparation du décodage 7-segments pour faciliter un affichage en simulation
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity septSegments_refreshPmod is
    generic(const_CLK_MHz : integer := 100); -- horloge en MHz, typique 100 MHz 
    Port(
        clk    : in  STD_LOGIC;         -- horloge systeme, typique 100 MHz (preciser par le constante)
        i_SSD0 : in  STD_LOGIC_VECTOR(6 downto 0); -- donnee a afficher sur 1er chiffre
        i_SSD1 : in  STD_LOGIC_VECTOR(6 downto 0); -- donnee a afficher sur 2e chiffre     
        JPmod  : out STD_LOGIC_VECTOR(7 downto 0) -- sorties directement adaptees au connecteur PmodSSD
    );
end septSegments_refreshPmod;

architecture Behavioral of septSegments_refreshPmod is

    -- realisation compteur division horloge pour multiplexer affichage SSD
    -- constante pour ajuster selon l horloge pilote du controle des afficheurs
    constant CLK_SSD_KHz_des   : integer                       := 5; --Khz   -- horloge desiree pour raffraichir afficheurs 7 segment
    constant const_div_clk_SSD : integer                       := (const_CLK_MHz * 1000 / CLK_SSD_KHz_des - 1);
    constant cdvia             : std_logic_vector(15 downto 0) := conv_std_logic_vector(const_div_clk_SSD, 16); -- donne 5 KHz soit 200 us

    signal counta : std_logic_vector(15 downto 0) := (others => '0');
    signal segm   : std_logic_vector(6 downto 0);
    signal SEL    : std_logic                     := '0';

begin

    -- selection chiffre pour affichage
    local_CLK_proc : process(clk)
    begin
        if (clk'event and clk = '1') then
            counta <= counta + 1;
            if (counta = cdvia) then    -- devrait se produire aux 200 us approx
                counta <= (others => '0');
                SEL    <= not SEL;      -- bascule de la selection du chiffre (0 ou 1)
                                        -- SEL devrait avoir periode de 400 us approx

                -- l'ordre n'est pas important pour l'affichage physique
                if (SEL = '1') then
                    segm(6 downto 0) <= i_SSD0;
                else
                    segm(6 downto 0) <= i_SSD1;
                end if;
            end if;
        end if;
    end process;

    JPmod <= SEL & segm;

end Behavioral;

