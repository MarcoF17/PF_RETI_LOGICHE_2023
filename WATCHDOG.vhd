
library ieee;
use ieee.std_logic_1164.all;

entity WATCHDOG is
	port(
		COMMAND: in std_logic_vector(2 downto 0);
		DATA: in std_logic_vector(15 downto 0);
		CLK: in std_logic;
		RST: in std_logic;
		CLEAR: in std_logic;
		NMI: out std_logic;
		RESET: out std_logic;
		COUNT: out std_logic_vector(15 downto 0)
	);
end WATCHDOG;

architecture RTL of WATCHDOG is
	
	component INPUT_HANDLER is
		port(
			DATA: in std_logic_vector(15 downto 0);
			COMMAND: in std_logic_vector(2 downto 0);
			PRESC: out std_logic_vector(15 downto 0);
			TWMIN: out std_logic_vector(15 downto 0);
			TWMAX: out std_logic_vector(15 downto 0);
			TNMI: out std_logic_vector(15 downto 0);
			CLK: in std_logic;
			RST: in std_logic;
			IS_STARTED: out std_logic
		);
	end component;
	
	component COUNTER_16BIT is
			port(
			CLK: in std_logic;
			RST: in std_logic;
			DOUT: out std_logic_vector(15 downto 0);
			ENABLE: in std_logic
		);
	end component;

	component T_FLIPFLOP is
		port(
			T: in std_logic;
			Q: out std_logic;
			RST: in std_logic;
			CLK: in std_logic
		);
	end component;
	
	signal COUNTER_ENABLE: std_logic;
	signal COUNTER_OUT: std_logic_vector(15 downto 0);
	signal STWMIN: std_logic_vector(15 downto 0);
	signal STNMI: std_logic_vector(15 downto 0);
	signal STWMAX: std_logic_vector(15 downto 0);
	signal TOUT: std_logic;
	signal TIN: std_logic;

begin

	UTFF: T_FLIPFLOP port map(
		T => TIN,
		CLK => CLK,
		RST => RST,
		Q => TOUT
	);
		
	UCOUNTER: COUNTER_16BIT port map(
		CLK => CLK,
		RST => RST,
		ENABLE => COUNTER_ENABLE,
		DOUT => COUNTER_OUT
	);
	
	UINHAND: INPUT_HANDLER port map(
		CLK => CLK,
		RST => RST,
		COMMAND => COMMAND,
		DATA => DATA,
		TWMIN => STWMIN,
		TWMAX => STWMAX,
		TNMI => STNMI,
		IS_STARTED => COUNTER_ENABLE
	);
	
	COUNT <= COUNTER_OUT;

	COUNTER_VERIFY: process(COUNTER_OUT, CLEAR, TOUT)
		begin
			if(STWMIN = COUNTER_OUT) then
				TIN <= '1';
			else
				TIN <= '0';
			end if;
			
			if(STNMI = COUNTER_OUT and COUNTER_ENABLE = '1') then
				NMI <= '1';
			else
				NMI <= '0';
			end if;
			
			if(COUNTER_ENABLE = '1' and ((CLEAR = '1' and TOUT = '0') or (STWMAX = COUNTER_OUT))) then
				RESET <= '1';
			else
				RESET <= '0';
			end if;
		end process;
		
end RTL;

