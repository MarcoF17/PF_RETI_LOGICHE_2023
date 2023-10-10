
library ieee;
use ieee.std_logic_1164.all;

entity DEC_3_8 is
	port(
		DECIN: in std_logic_vector(0 to 2);
		DECOUT: out std_logic_vector(0 to 7)
	);
end DEC_3_8;

architecture RTL of DEC_3_8 is

begin
	with DECIN select
		DECOUT <= "00000001" when "000",
					 "00000010" when "001",
					 "00000100" when "010",
					 "00001000" when "011",
					 "00010000" when "100",
					 "00100000" when "101",
					 "01000000" when "110",
					 "10000000" when "111",
					 "--------" when others;

end RTL;

