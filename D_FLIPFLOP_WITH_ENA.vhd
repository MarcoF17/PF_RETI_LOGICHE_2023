
library ieee;
use ieee.std_logic_1164.all;


entity D_FLIPFLOP_WITH_ENA is
	port(
		D: in std_logic_vector(15 downto 0);
		Q: out std_logic_vector (15 downto 0);
		CLK: in std_logic;
		RST: in std_logic;
		ENABLE: in std_logic
	);
end D_FLIPFLOP_WITH_ENA;

architecture RTL of D_FLIPFLOP_WITH_ENA is

begin
	ff: process(CLK, RST)
		begin
			if(RST = '1') then
				Q <= (others => '0');
			else
				if(ENABLE = '1') then
					if(CLK'event and CLK = '1') then
						Q <= D;
					end if;
				end if;
			end if;
		end process;

end RTL;

