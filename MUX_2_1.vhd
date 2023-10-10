
library ieee;
use ieee.std_logic_1164.all;

entity MUX_2_1 is
	port(
		A: in std_logic_vector(10 downto 0);
		B: in std_logic_vector(10 downto 0);
		S: in std_logic;
		Y: out std_logic_vector(10 downto 0)
	);
end MUX_2_1;

architecture RTL of MUX_2_1 is

begin
	Y <= A when S = '0' else
		  B;

end RTL;

