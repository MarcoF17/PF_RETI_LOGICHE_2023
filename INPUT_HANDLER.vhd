
library ieee;
use ieee.std_logic_1164.all;

entity INPUT_HANDLER is
	port(
		DATA: in std_logic_vector(15 downto 0);
		COMMAND: in std_logic_vector(2 downto 0);
		PRESC: out std_logic_vector(15 downto 0);
		TWMIN: out std_logic_vector(15 downto 0);
		TWMAX: out std_logic_vector(15 downto 0);
		TNMI: out std_logic_vector(15 downto 0);
		CLK: in std_logic;
		RST: in std_logic;
		IS_STARTED: out std_logic;
		ERR: in std_logic
	);
end INPUT_HANDLER;

architecture Behavioral of INPUT_HANDLER is
	
	signal TO_PS: std_logic_vector(15 downto 0);
	signal TO_TWMIN: std_logic_vector(15 downto 0);
	signal TO_TWMAX: std_logic_vector(15 downto 0);
	signal TO_TNMI: std_logic_vector(15 downto 0);
	signal ENABLE: std_logic_vector(3 downto 0);
	signal T_FF_ENABLE: std_logic;
	signal E: std_logic_vector(3 downto 0);
	signal STEMP: std_logic;
	signal SINVTEMP: std_logic;
	--signal SPRESC: std_logic_vector(15 downto 0);

	
	component DEMUX_1_4 is
		port(
			DIN: in std_logic_vector(15 downto 0);
			COMMAND: in std_logic_vector(2 downto 0);
			TO_PS: out std_logic_vector(15 downto 0);
			TO_TWMIN: out std_logic_vector(15 downto 0);
			TO_TWMAX: out std_logic_vector(15 downto 0);
			TO_TNMI: out std_logic_vector(15 downto 0)
		);
	end component;
	
	component DECODER_3BIT is
		port(
			COMMAND: in std_logic_vector(2 downto 0);
			DEC_OUT: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component D_FLIPFLOP_WITH_ENA is
		port(
			D: in std_logic_vector(15 downto 0);
			Q: out std_logic_vector (15 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			ENABLE: in std_logic
		);
	end component;
	
	component T_FLIPFLOP_WITH_ENA is
		port(
			T: in std_logic;
			Q: out std_logic;
			E: in std_logic;
			CLK: in std_logic;
			RST: in std_logic;
			CLR: in std_logic
		);
	end component;
		
begin
	UDEMUX: DEMUX_1_4 port map(
		DIN => DATA,
		COMMAND => COMMAND,
		TO_PS => TO_PS,
		TO_TWMIN => TO_TWMIN,
		TO_TWMAX => TO_TWMAX,
		TO_TNMI => TO_TNMI
	);
				
	UDECODER: DECODER_3BIT port map(
		COMMAND => COMMAND,
		DEC_OUT => E
	);
	
	UPRESCALER: D_FLIPFLOP_WITH_ENA port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(0),
		D => TO_PS,
		Q => PRESC
	);
	
	UTWMIN: D_FLIPFLOP_WITH_ENA port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(1),
		D => TO_TWMIN,
		Q => TWMIN
	);
	
	UTWMAX: D_FLIPFLOP_WITH_ENA port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(2),
		D => TO_TWMAX,
		Q => TWMAX
	);
	
	UTNMI: D_FLIPFLOP_WITH_ENA port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(3),
		D => TO_TNMI,
		Q => TNMI
	);

	UT_FF: T_FLIPFLOP_WITH_ENA port map(
		RST => RST,
		CLK => CLK,
		Q => T_FF_ENABLE,
		E => '1',
		T => STEMP,
		CLR => ERR
	);
	
	IS_STARTED <= T_FF_ENABLE;
	--PRESC <= SPRESC;
	
	p: process(E, T_FF_ENABLE, COMMAND)
		begin
			ENABLE(0) <= E(0) and (not T_FF_ENABLE);
			ENABLE(1) <= E(1) and (not T_FF_ENABLE);
			ENABLE(2) <= E(2) and (not T_FF_ENABLE);
			ENABLE(3) <= E(3) and (not T_FF_ENABLE);
			
			STEMP <= (not COMMAND(0)) and (not COMMAND(1)) and (COMMAND(2));
			
			SINVTEMP <= (not T_FF_ENABLE);
		end process;
		
end Behavioral;

