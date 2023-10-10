
library ieee;
use ieee.std_logic_1164.all;

entity COUNTER_16BIT is
	port(
		CLK: in std_logic;
		RST: in std_logic;
		DOUT: out std_logic_vector(15 downto 0);
		ENABLE: in std_logic;
		CLR: in std_logic
	);
end COUNTER_16BIT;

architecture RTL of COUNTER_16BIT is

	component RCA_GENERIC is
		generic(
			N: integer
		);
		port(
			X: in std_logic_vector(15 downto 0);
			S: out std_logic_vector(15 downto 0);
			COUT: out std_logic
		);
	end component;
	
	component D_FLIPFLOP_WITH_ENA is
		generic(
			N: integer
		);
		port(
			D: in std_logic_vector(15 downto 0);
			Q: out std_logic_vector (15 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			ENABLE: in std_logic
		);
	end component;
	
	signal TDOUT: std_logic_vector(15 downto 0);
	signal TLOOP: std_logic_vector(15 downto 0);
	--signal NEW_COUNT: std_logic;

begin
	U0: RCA_GENERIC
	generic map(
		N => 16
	)
	port map(
		X => TDOUT,
		S => TLOOP
	);
	
	U1: D_FLIPFLOP_WITH_ENA 
	generic map(
		N => 16
	)
	port map(
		D => TLOOP,
		Q => TDOUT,
		CLK => CLK,
		RST => RST or CLR,
		ENABLE => ENABLE
	);
	
	DOUT <= TDOUT;
	--NEW_COUNT <= RST;-- or CLR;
			
end RTL;

