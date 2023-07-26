
library ieee;
use ieee.std_logic_1164.all;

entity DECODER_3BIT is
	port(
		COMMAND: in std_logic_vector(2 downto 0);
		DEC_OUT: out std_logic_vector(3 downto 0)
	);
end DECODER_3BIT;

architecture RTL of DECODER_3BIT is

begin
	with COMMAND select
		DEC_OUT <= "0001" when "000",
					  "0010" when "001",
					  "0100" when "010",
					  "1000" when "011",
					  "0000" when others;

end RTL;

