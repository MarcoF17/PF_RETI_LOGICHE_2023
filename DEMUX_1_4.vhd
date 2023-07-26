
library ieee;
use ieee.std_logic_1164.all;

entity DEMUX_1_4 is
	port(
		DIN: in std_logic_vector(15 downto 0);
		COMMAND: in std_logic_vector(2 downto 0);
		TO_PS: out std_logic_vector(15 downto 0);
		TO_TWMIN: out std_logic_vector(15 downto 0);
		TO_TWMAX: out std_logic_vector(15 downto 0);
		TO_TNMI: out std_logic_vector(15 downto 0)
	);
end DEMUX_1_4;

architecture RTL of DEMUX_1_4 is

begin
	TO_PS <= DIN when COMMAND = "000" else (others => '-');
	TO_TWMIN <= DIN when COMMAND = "001" else (others => '-');
	TO_TWMAX <= DIN when COMMAND = "010" else (others => '-');
	TO_TNMI <= DIN when COMMAND = "011" else (others => '-');
end RTL;

