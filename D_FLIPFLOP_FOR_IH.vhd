library ieee;
use ieee.std_logic_1164.all;


entity D_FLIPFLOP_FOR_IH is
	port(
		D: in std_logic_vector(15 downto 0);
		Q: out std_logic_vector (15 downto 0);
		CLK: in std_logic;
		RST: in std_logic;
		ENABLE: in std_logic
	);
end D_FLIPFLOP_FOR_IH;

architecture RTL of D_FLIPFLOP_FOR_IH is

begin
	ff: process(CLK, RST, ENABLE)
		begin
			if(RST = '1') then
				Q <= (others => '1');
			else
				if(ENABLE = '1') then
					if(CLK'event and CLK = '1') then
						Q <= D;
					end if;
				end if;
			end if;
		end process;

end RTL;
