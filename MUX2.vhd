
library ieee;
use ieee.std_logic_1164.all;


entity MUX2 is
	port(
		A: in std_logic_vector(9 downto 0);
		B: in std_logic_vector(9 downto 0);
		S: in std_logic;
		Y: out std_logic_vector(9 downto 0)
	);
end MUX2;

architecture RTL of MUX2 is
begin
	Y <= A when S = '0' else
		  B;
		
end RTL;

