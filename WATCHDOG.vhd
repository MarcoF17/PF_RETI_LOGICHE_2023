
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
		IS_STARTED: out std_logic;
		COUNTER: out std_logic_vector(15 downto 0);
		TFFOUT: out std_logic
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
			IS_STARTED: out std_logic;
			ERR: in std_logic
		);
	end component;
	
	component COUNTER_16BIT is
			port(
			CLK: in std_logic;
			RST: in std_logic;
			DOUT: out std_logic_vector(15 downto 0);
			ENABLE: in std_logic;
			CLR: in std_logic
		);
	end component;

	component T_FLIPFLOP_WITH_ENA is
		port(
			T: in std_logic;
			Q: out std_logic;
			RST: in std_logic;
			CLK: in std_logic;
			E: in std_logic;
			CLR: in std_logic
		);
	end component;
	
	component PRESCALER is
		port(
			CLK_IN: in std_logic;
			CLK_BASE_OUT: out std_logic;
			CLK_DIVIDED_OUT: out std_logic_vector(9 downto 0);
			RST: in std_logic
		);
	end component;
	
	component MUX11 is
		port(
			DIN: in std_logic_vector(10 downto 0);
			S: in std_logic_vector(15 downto 0);
			Y: out std_logic
		);
	end component;
	
	component T_FLIPFLOP is
		port(
			T: in std_logic;
			Q: out std_logic;
			CLK: in std_logic;
			RST: in std_logic;
			CLR: in std_logic
		);
	end component;
	
	signal COUNTER_ENABLE: std_logic;
	signal COUNTER_OUT: std_logic_vector(15 downto 0);
	signal STWMIN: std_logic_vector(15 downto 0);
	signal STNMI: std_logic_vector(15 downto 0);
	signal STWMAX: std_logic_vector(15 downto 0);
	signal TOUT: std_logic;
	signal TIN: std_logic;
	signal SCLK: std_logic_vector(10 downto 0);
	signal SPRESC: std_logic_vector(15 downto 0);
	signal CLK_FROM_PRESCALER: std_logic;
	signal SRESET: std_logic;
	signal COUNTER_CLR: std_logic;
	signal TFF_CLR: std_logic;
	signal HANDLER_CLR: std_logic;

begin

	UTFFCLEAR: T_FLIPFLOP port map(
		T => CLEAR,
		CLK => CLK,
		CLR => '0',
		--Q => '0',
		RST => RST
	);

	UTFF: T_FLIPFLOP_WITH_ENA port map(
		T => TIN,
		CLK => CLK_FROM_PRESCALER,
		RST => RST,
		Q => TOUT,
		E => COUNTER_ENABLE,
		CLR => TFF_CLR
	);
		
	UCOUNTER: COUNTER_16BIT port map(
		CLK => CLK_FROM_PRESCALER,
		RST => RST,
		ENABLE => COUNTER_ENABLE,
		DOUT => COUNTER_OUT,
		CLR => COUNTER_CLR
	);
	
	UINHAND: INPUT_HANDLER port map(
		CLK => CLK,
		RST => RST,
		COMMAND => COMMAND,
		DATA => DATA,
		TWMIN => STWMIN,
		TWMAX => STWMAX,
		TNMI => STNMI,
		IS_STARTED => COUNTER_ENABLE,
		PRESC => SPRESC,
		ERR => SRESET
	);

	UPRESC: PRESCALER port map(
		CLK_IN => CLK,
		CLK_BASE_OUT => SCLK(0),
		CLK_DIVIDED_OUT => SCLK(10 downto 1),
		RST => RST
	);
	
	UMUX11: MUX11 port map(
		DIN => SCLK,
		S => SPRESC,
		Y => CLK_FROM_PRESCALER
	);	
	
	COUNTER_VERIFY: process(COUNTER_OUT, CLEAR, TOUT, CLK, COUNTER_ENABLE, STWMIN, STNMI, STWMAX)
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
			--if((CLEAR = '1' and TOUT = '0') or (STWMAX = COUNTER_OUT)) then
				SRESET <= '1';
			else
				SRESET <= '0';
			end if;
		end process;
		

		--COUNTER_CLR <= CLEAR;-- or SRESET;
		--TFF_CLR <= SRESET;
		IS_STARTED <= COUNTER_ENABLE;
		COUNTER <= COUNTER_OUT;
		TFFOUT <= TOUT;
		
		RESET <= SRESET;
		COUNTER_CLR <= CLEAR and (not SRESET);
		TFF_CLR <= SRESET or CLEAR;
		
end RTL;

