
library ieee;
use ieee.std_logic_1164.all;

entity MUX11 is
	port(
		DIN: in std_logic_vector(10 downto 0);
		S: in std_logic_vector(15 downto 0);
		Y: out std_logic
	);
end MUX11;

architecture RTL of MUX11 is

begin
	Y <= DIN(0) when S = "0000000000000000" else
		  DIN(1) when S = "0000000000000001" else
		  DIN(2) when S = "0000000000000010" else
		  DIN(3) when S = "0000000000000011" else
		  DIN(4) when S = "0000000000000100" else
		  DIN(5) when S = "0000000000000101" else
		  DIN(6) when S = "0000000000000110" else
		  DIN(7) when S = "0000000000000111" else
		  DIN(8) when S = "0000000000001000" else
		  DIN(9) when S = "0000000000001001" else
		  DIN(10);

end RTL;

