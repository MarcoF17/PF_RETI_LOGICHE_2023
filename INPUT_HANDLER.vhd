
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
		ERR: in std_logic;
		CLK_ENABLE: in std_logic
	);
end INPUT_HANDLER;

architecture Behavioral of INPUT_HANDLER is
	
	signal ENABLE: std_logic_vector(3 downto 0);
	signal IN_ENABLE: std_logic;
	signal E: std_logic_vector(3 downto 0);
	signal STEMP: std_logic;
	signal SINVTEMP: std_logic;
	signal SDATA: std_logic_vector(15 downto 0);
	signal SCOMMAND: std_logic_vector(2 downto 0);
		
	component DECODER_3BIT is
		port(
			COMMAND: in std_logic_vector(2 downto 0);
			DEC_OUT: out std_logic_vector(3 downto 0)
		);
	end component;
	
	component D_FLIPFLOP_WITH_ENA is
		generic(
			N: integer
		);
		port(
			D: in std_logic_vector(N-1 downto 0);
			Q: out std_logic_vector (N-1 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			ENABLE: in std_logic
		);
	end component;
	
	component SR_FLIPFLOP is
		port(
			S: in std_logic;
			R: in std_logic;
			Q: out std_logic;
			CLK: in std_logic
		);
	end component;
		
begin
	UDECODER: DECODER_3BIT port map(
		COMMAND => SCOMMAND,
		DEC_OUT => E
	);
	
	UPRESCALER: D_FLIPFLOP_WITH_ENA
	generic map(
		N => 16
	)
	port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(0),
		D => SDATA,
		Q => PRESC
	);
	
	UTWMIN: D_FLIPFLOP_WITH_ENA
	generic map(
		N => 16
	)
	port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(1),
		D => SDATA,
		Q => TWMIN
	);
	
	UTWMAX: D_FLIPFLOP_WITH_ENA 
	generic map(
		N => 16
	)
	port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(2),
		D => SDATA,
		Q => TWMAX
	);
	
	UTNMI: D_FLIPFLOP_WITH_ENA
	generic map(
		N => 16
	)
	port map(
		RST => RST,
		CLK => CLK,
		ENABLE => ENABLE(3),
		D => SDATA,
		Q => TNMI
	);

	USR_FF: SR_FLIPFLOP port map(
		R => RST or ERR,
		CLK => CLK,
		Q => IN_ENABLE,
		S => STEMP
	);
	
	UDATA: D_FLIPFLOP_WITH_ENA
	generic map(
		N => 16
	)
	port map(
		D => DATA,
		Q => SDATA,
		CLK => CLK,
		RST => RST,
		ENABLE => SINVTEMP
	);
	
	UCOMMAND: D_FLIPFLOP_WITH_ENA
	generic map(
		N => 3
	)
	port map(
		D => COMMAND,
		Q => SCOMMAND,
		CLK => CLK,
		RST => RST,
		ENABLE => '1'
	);
	
	IS_STARTED <= IN_ENABLE;
	
	p: process(E, IN_ENABLE, SCOMMAND, CLK_ENABLE)
		begin
			ENABLE(0) <= E(0) and (not IN_ENABLE);-- and CLK_ENABLE;
			ENABLE(1) <= E(1) and (not IN_ENABLE);-- and CLK_ENABLE;
			ENABLE(2) <= E(2) and (not IN_ENABLE);-- and CLK_ENABLE;
			ENABLE(3) <= E(3) and (not IN_ENABLE);-- and CLK_ENABLE;
			
			STEMP <= (not SCOMMAND(0)) and (not SCOMMAND(1)) and (SCOMMAND(2));
			
			SINVTEMP <= (not IN_ENABLE);
		end process;
		
end Behavioral;

