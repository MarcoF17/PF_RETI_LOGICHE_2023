
library ieee;
use ieee.std_logic_1164.all;

entity T_FLIPFLOP_WITH_ENA is
	port(
		T: in std_logic;
		Q: out std_logic;
		E: in std_logic;
		CLK: in std_logic;
		RST: in std_logic;
		CLR: in std_logic
	);
end T_FLIPFLOP_WITH_ENA;

architecture RTL of T_FLIPFLOP_WITH_ENA is
	signal QINTERNAL: std_logic;
begin
	ff: process(CLK, RST, E, CLR)
		begin
			if(RST = '1') then
				QINTERNAL <= '0';
			else
				if(E = '1') then
					if(CLK'event and CLK = '1') then
						if(CLR = '1') then
							QINTERNAL <= '0';
						else
							if(T = '1') then
								QINTERNAL <= not QINTERNAL;
							end if;
						end if;
					end if;
				end if;
			end if;
		end process;
		
		Q <= QINTERNAL;

end RTL;
