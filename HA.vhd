
library ieee;
use ieee.std_logic_1164.all;

entity HA is
	port(
		X: in std_logic;
		Y: in std_logic;
		S: out std_logic;
		C: out std_logic
	);
end HA;

architecture RTL of HA is

begin
	S <= X xor Y;
	C <= X and Y;

end RTL;

