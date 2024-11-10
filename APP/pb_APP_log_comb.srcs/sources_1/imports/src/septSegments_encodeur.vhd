---------------------------------------------------------------------------------------------
-- circuit affhex_pmodssd.vhd
---------------------------------------------------------------------------------------------
-- Université de Sherbrooke - Département de GEGI
-- Version         : 2.0
-- Nomenclature    : 0.8 GRAMS
-- Date            : revision 23 octobre 2018
-- Auteur(s)       : Réjean Fontaine, Daniel Dalle
-- Technologies    : FPGA Zynq (carte ZYBO Z7-10 ZYBO Z7-20)
--
-- Outils          : vivado 2016.1 64 bits, vivado 2018.2
---------------------------------------------------------------------------------------------
-- Description:
-- Affichage sur module de 2 chiffes (7 o_Segents) sur PmodSSD 
-- reference https://reference.digilentinc.com/reference/pmod/pmodssd/start 
--           PmodSSD™ Reference Manual Doc: 502-126 Digilent, Inc.
--
-- Revisions
-- mise a jour D Dalle 22 octobre 2018 corrections, simplifications
-- mise a jour D Dalle 15 octobre documentation affhex_pmodssd_sol_v0.vhd
-- mise a jour D Dalle 12 septembre pour eviter l'usage d'une horloge interne
-- mise a jour D Dalle 7 septembre, calcul des constantes.
-- mise a jour D Dalle 5 septembre 2018, nom affhexPmodSSD, 6 septembre :division horloge
-- module de commande le l'afficheur 2 o_Segents 2 digits sur pmod
-- Daniel Dalle revision pour sortir les signaux du connecteur Pmod directement
-- Daniel Dalle 30 juillet 2018:
-- revision pour une seule entre sur 8 bits affichee sur les deux chiffres Hexa
--
-- Creation selon affhex7segx4v3.vhd 
-- (Daniel Dalle, Réjean Fontaine Universite de Sherbrooke, Departement GEGI)
-- 26 septembre 2011, revision 12 juin 2012, 25 janvier 2013, 7 mai 2015
-- Contrôle de l'afficheur a sept o_Segent (BASYS2 - NEXYS2)
-- horloge 100MHz et diviseur interne
---------------------------------------------------------------------------------------------
-- À faire :
-- 
-- 
-- 
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity septSegments_encodeur is
    Port(
         i_AFF : in  STD_LOGIC_VECTOR(3 downto 0); -- caractère à afficher
         o_CharacterePourSim : out string(1 to 1);        -- pour simulation seulement  
         o_Seg : out STD_LOGIC_VECTOR(6 downto 0) -- encodage 7-segments
        );
end septSegments_encodeur;

architecture Behavioral of septSegments_encodeur is


-- fonction réservée pour l'affichage en simulation seulement
function segment2String(display : std_logic_vector( 6 downto 0))
              return string is
		variable v_ReturnString : string(1 to 1);
	begin
		case display is
            when "0111111" => v_ReturnString := "0"; -- 0
            when "0000110" => v_ReturnString := "1"; -- 1
            when "1011011" => v_ReturnString := "2"; -- 2
            when "1001111" => v_ReturnString := "3"; -- 3
            when "1100110" => v_ReturnString := "4"; -- 4
            when "1101101" => v_ReturnString := "5"; -- 5 
            when "1111101" => v_ReturnString := "6"; -- 6 
            when "0000111" => v_ReturnString := "7"; -- 7 
            when "1111111" => v_ReturnString := "8"; -- 8
            when "1101111" => v_ReturnString := "9"; -- 9 
            when "1110111" => v_ReturnString := "A"; -- A
            when "1111100" => v_ReturnString := "B"; -- b 
            when "0111001" => v_ReturnString := "C"; -- C 
            when "1011110" => v_ReturnString := "D"; -- d 
            when "1111001" => v_ReturnString := "E"; -- E
            when "1110001" => v_ReturnString := "F"; -- F 
            when "1000000" => v_ReturnString := "-"; -- négatif
			when "1010000" => v_ReturnString := "r"; -- r pour erreur
            when others    => v_ReturnString := "_"; -- code non reconnu
		end case;
		return v_ReturnString;
	end segment2String; 
	-- fin de la fonction
	
	
    signal s_Seg : STD_LOGIC_VECTOR(6 downto 0);

begin

-- correspondance des o_Segents des afficheurs
o_Segent:  process (i_AFF)
    begin   
      case i_AFF is
            --                      "gfedcba"
            when "0000" => s_Seg  <= "0111111"; -- 0
            when "0001" => s_Seg  <= "0000110"; -- 1
            when "0010" => s_Seg  <= "1011011"; -- 2
            when "0011" => s_Seg  <= "1001111"; -- 3
            when "0100" => s_Seg  <= "1100110"; -- 4
            when "0101" => s_Seg  <= "1101101"; -- 5 
            when "0110" => s_Seg  <= "1111101"; -- 6 
            when "0111" => s_Seg  <= "0000111"; -- 7 
            when "1000" => s_Seg  <= "1111111"; -- 8
            when "1001" => s_Seg  <= "1101111"; -- 9 
            when "1010" => s_Seg  <= "1110111"; -- A
            when "1011" => s_Seg  <= "1111100"; -- B 
            when "1100" => s_Seg  <= "0111001"; -- C 
            when "1101" => s_Seg  <= "1000000"; -- - 
            when "1110" => s_Seg  <= "1111001"; -- E
            when "1111" => s_Seg  <= "1010000"; -- r 
            when others => s_Seg  <= "0000000";
       end case;
    end process;
    
    
    o_CharacterePourSim <= segment2String(s_Seg);
    o_Seg <= s_Seg ;

end Behavioral;

