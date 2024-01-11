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
-- Affichage sur module de 2 chiffes (7 segments) sur PmodSSD 
-- reference https://reference.digilentinc.com/reference/pmod/pmodssd/start 
--           PmodSSD™ Reference Manual Doc: 502-126 Digilent, Inc.
--
-- Revisions
-- mise a jour D Dalle 22 octobre 2018 corrections, simplifications
-- mise a jour D Dalle 15 octobre documentation affhex_pmodssd_sol_v0.vhd
-- mise a jour D Dalle 12 septembre pour eviter l'usage d'une horloge interne
-- mise a jour D Dalle 7 septembre, calcul des constantes.
-- mise a jour D Dalle 5 septembre 2018, nom affhexPmodSSD, 6 septembre :division horloge
-- module de commande le l'afficheur 2 segments 2 digits sur pmod
-- Daniel Dalle revision pour sortir les signaux du connecteur Pmod directement
-- Daniel Dalle 30 juillet 2018:
-- revision pour une seule entre sur 8 bits affichee sur les deux chiffres Hexa
--
-- Creation selon affhex7segx4v3.vhd 
-- (Daniel Dalle, Réjean Fontaine Universite de Sherbrooke, Departement GEGI)
-- 26 septembre 2011, revision 12 juin 2012, 25 janvier 2013, 7 mai 2015
-- Contrôle de l'afficheur a sept segment (BASYS2 - NEXYS2)
-- horloge 100MHz et diviseur interne
---------------------------------------------------------------------------------------------
-- À faire :
-- 
-- 
-- 
---------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity septSegments_Top is
generic (const_CLK_MHz: integer := 100);                     -- horloge en MHz, typique 100 MHz 
    Port (   clk            : in   STD_LOGIC;                      -- horloge systeme, typique 100 MHz (preciser par le constante)
             i_AFF0         : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 4 bits : chiffre hexa position 0
             i_AFF1         : in   STD_LOGIC_VECTOR (3 downto 0);  -- donnee a afficher sur 4 bits : chiffre hexa position 1
             o_AFFSSD_Sim   : out string(2 downto 1);
             o_AFFSSD       : out  STD_LOGIC_VECTOR (7 downto 0)  
           );
end septSegments_Top; -- sorties directement adaptees au connecteur PmodSSD

architecture Behavioral of septSegments_Top is

component septSegments_encodeur is
Port(
         i_AFF : in  STD_LOGIC_VECTOR(3 downto 0); -- caractère à afficher
         o_CharacterePourSim : out string(1 to 1);        -- pour simulation seulement
         o_Seg : out STD_LOGIC_VECTOR(6 downto 0) -- encodage 7-segments
    );
end component;

component septSegments_refreshPmod is
generic(const_CLK_MHz : integer := 100); -- horloge en MHz, typique 100 MHz 
Port(
    clk    : in  STD_LOGIC;         -- horloge systeme, typique 100 MHz (preciser par le constante)
    i_SSD0 : in  STD_LOGIC_VECTOR(6 downto 0); -- donnee a afficher sur 1er chiffre
    i_SSD1 : in  STD_LOGIC_VECTOR(6 downto 0); -- donnee a afficher sur 2e chiffre     
    JPmod  : out STD_LOGIC_VECTOR(7 downto 0) -- sorties directement adaptees au connecteur PmodSSD
);
end component;


signal s_segment_lsb :  STD_LOGIC_VECTOR (6 downto 0);
signal s_segment_msb :  STD_LOGIC_VECTOR (6 downto 0);

begin


inst_segm_lsb : septSegments_encodeur
Port map(
     i_AFF  => i_AFF0,
     o_CharacterePourSim => o_AFFSSD_Sim(1 downto 1),
     o_Seg  => s_segment_lsb
    );

inst_segm_msb : septSegments_encodeur
Port map(
     i_AFF  => i_AFF1,
     o_CharacterePourSim => o_AFFSSD_Sim(2 downto 2),
     o_Seg  => s_segment_msb
    );

inst_refresh : septSegments_refreshPmod
--generic(const_CLK_MHz : integer := 100); -- horloge en MHz, typique 100 MHz 
Port map(
    clk    => clk,
    i_SSD0 => s_segment_lsb,
    i_SSD1 => s_segment_msb,
    JPmod  => o_AFFSSD
);

end Behavioral;

