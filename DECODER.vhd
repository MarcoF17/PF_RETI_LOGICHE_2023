
library ieee;
use ieee.std_logic_1164.all;

entity DECODER is
	port(
		X: in std_logic_vector(3 downto 0);
		Y: out std_logic_vector(10 downto 0)
	);
end DECODER;

architecture RTL of DECODER is

begin
	with X select
		Y <= "00000000001" when "0000",
			  "00000000010" when "0001",
			  "00000000100" when "0010",
			  "00000001000" when "0011",
			  "00000010000" when "0100",
			  "00000100000" when "0101",
			  "00001000000" when "0110",
			  "00010000000" when "0111",
			  "00100000000" when "1000",
			  "01000000000" when "1001",
			  "10000000000" when "1010";
			  

end RTL;

