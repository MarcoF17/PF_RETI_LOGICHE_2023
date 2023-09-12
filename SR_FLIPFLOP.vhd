
library ieee;
use ieee.std_logic_1164.all;


entity SR_FLIPFLOP is
	port(
		S: in std_logic;
		R: in std_logic;
		Q: out std_logic;
		CLK: in std_logic;
		ENABLE: in std_logic
	);
end SR_FLIPFLOP;

architecture RTL of SR_FLIPFLOP is
	
begin
	ff: process(CLK)
	begin
		if(CLK'event and CLK='1') then
			if(ENABLE = '1') then
				if(S = '1' and R = '0') then
					Q <= '1';
				elsif(S = '0' and R = '1') then
					Q <= '0';
				elsif(S = '0' and R = '0') then
					null;	--condizione di memoria
				elsif(S = '1' and R = '1') then
					Q <= 'X';	--configurazione ingressi non ammessa
				end if;
			end if;
		end if;
	end process;

end RTL;

