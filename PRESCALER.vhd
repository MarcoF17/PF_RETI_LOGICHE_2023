
library ieee;
use ieee.std_logic_1164.all;

entity PRESCALER is
	port(
		CLK: in std_logic;
		RST: in std_logic;
		DOUT: out std_logic_vector(9 downto 0);
		ENABLE: in std_logic
	);
end PRESCALER;

architecture RTL of PRESCALER is

	component RCA_10BIT is
		port(
			X: in std_logic_vector(9 downto 0);
			S: out std_logic_vector(9 downto 0);
			COUT: out std_logic
		);
	end component;
	
	component D_FLIPFLOP_10BIT is
		port(
			D: in std_logic_vector(9 downto 0);
			Q: out std_logic_vector(9 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			ENABLE: in std_logic
		);
	end component;
	
	signal TDOUT: std_logic_vector(9 downto 0);
	signal TLOOP: std_logic_vector(9 downto 0);

begin
	U0: RCA_10BIT port map(
		X => TDOUT,
		S => TLOOP
	);
	
	U1: D_FLIPFLOP_10BIT port map(
		D => TLOOP,
		Q => TDOUT,
		CLK => CLK,
		RST => RST,
		ENABLE => ENABLE
	);
	
	DOUT <= TDOUT;
	
	--reset_process: process(RST)
		--begin
			--if(RST = '1') then
				--DOUT <= (others => '0');
			--end if;
		--end process;
end RTL;


