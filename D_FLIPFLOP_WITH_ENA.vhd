
library ieee;
use ieee.std_logic_1164.all;


entity D_FLIPFLOP_WITH_ENA is
	generic(
		N: integer := 11
	);

	port(
		D: in std_logic_vector(N-1 downto 0);
		Q: out std_logic_vector (N-1 downto 0);
		CLK: in std_logic;
		RST: in std_logic;
		ENABLE: in std_logic
	);
end D_FLIPFLOP_WITH_ENA;

architecture RTL of D_FLIPFLOP_WITH_ENA is

signal ALL_ZEROS: std_logic_vector(N-1 downto 0);

begin
	ALL_ZEROS <= (others => '0');
	ff: process(CLK)
		begin
			if(CLK'event and CLK = '1') then
				if(RST = '1') then
					Q <= ALL_ZEROS;
				
				elsif(ENABLE = '1') then
					Q <= D;
				end if;
			end if;
		end process;

end RTL;

