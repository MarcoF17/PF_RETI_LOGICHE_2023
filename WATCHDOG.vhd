
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
		CLK_ENABLE: out std_logic--;
		--COUNTENA: out std_logic
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
			ERR: in std_logic;
			CLK_ENABLE: in std_logic
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

	component SR_FLIPFLOP is
		port(
			S: in std_logic;
			R: in std_logic;
			Q: out std_logic;
			CLK: in std_logic
		);
	end component;
	
	component PRESCALER is
		port(
			EXP_VALUE: in std_logic_vector(3 downto 0);
			CLK_ENABLE: out std_logic;
			CLK: in std_logic;
			RST: in std_logic
		);
	end component;
	
	signal COUNTER_ENABLE: std_logic;
	signal COUNTER_OUT: std_logic_vector(15 downto 0);
	signal STWMIN: std_logic_vector(15 downto 0);
	signal STNMI: std_logic_vector(15 downto 0);
	signal STWMAX: std_logic_vector(15 downto 0);
	signal SROUT: std_logic;
	signal SRIN: std_logic;
	signal SPRESC: std_logic_vector(15 downto 0);
	signal SRESET: std_logic;
	signal CLK_ENA: std_logic;
	signal SCLEAR: std_logic;
	signal NEED_CLEAR: std_logic;

begin

	UFFMIN: SR_FLIPFLOP port map(
		CLK => CLK,
		R => RST or NEED_CLEAR,
		S => SRIN,
		Q => SROUT
	);
		
	UCOUNTER: COUNTER_16BIT port map(
		CLK => CLK,
		RST => RST,
		ENABLE => COUNTER_ENABLE and CLK_ENA,
		DOUT => COUNTER_OUT,
		CLR => NEED_CLEAR
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
		ERR => SRESET,
		CLK_ENABLE => CLK_ENA
	);

	UPRESC: PRESCALER port map(
		EXP_VALUE => SPRESC(3 downto 0),
		CLK_ENABLE => CLK_ENA,
		CLK => CLK,
		RST => RST
	);
	
	UFFCLEAR: SR_FLIPFLOP port map(
		CLK => CLK,
		R => RST or NEED_CLEAR,
		S => CLEAR,
		Q => SCLEAR
	);
		
	PTWMIN: process(COUNTER_OUT, COUNTER_ENABLE, CLK)
		begin
			if(COUNTER_ENABLE = '1') then
				if(COUNTER_OUT = STWMIN) then
					SRIN <= '1';
				else
					SRIN <= '0';
				end if;
			else
				SRIN <= '0';
			end if;
		end process;
		
	PTNMI: process(COUNTER_OUT, COUNTER_ENABLE, CLK)
		begin
			if(COUNTER_ENABLE = '1') then
				if(COUNTER_OUT = STNMI) then
					NMI <= '1';
				else
					NMI <= '0';
				end if;
			--else
				--NMI <= '0';
			end if;
		end process;
		
	PRESET: process(COUNTER_OUT, SCLEAR, CLK)
		begin
			if(COUNTER_ENABLE = '1') then
				if((COUNTER_OUT = STWMAX) or (SCLEAR = '1' and SROUT = '0')) then
					SRESET <= '1';
				--else
					--SRESET <= '0';
				end if;
				
				if(SCLEAR = '1' and SROUT = '1') then
					NEED_CLEAR <= '1';
				else
					NEED_CLEAR <= '0';
				end if;
			else
				SRESET <= '0';
			end if;
		end process;
		
	RESET <= SRESET;
	CLK_ENABLE <= CLK_ENA;
	--COUNTENA <= COUNTER_ENABLE;
		
end RTL;

