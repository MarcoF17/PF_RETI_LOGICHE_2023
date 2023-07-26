
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
		RESET: out std_logic
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
	


	TIN <= (STWMIN(0) and COUNTER_OUT(0)) and
			 (STWMIN(1) and COUNTER_OUT(1)) and
			 (STWMIN(2) and COUNTER_OUT(2)) and
			 (STWMIN(3) and COUNTER_OUT(3)) and
			 (STWMIN(4) and COUNTER_OUT(4)) and
			 (STWMIN(5) and COUNTER_OUT(5)) and
			 (STWMIN(6) and COUNTER_OUT(6)) and
			 (STWMIN(7) and COUNTER_OUT(7)) and
			 (STWMIN(8) and COUNTER_OUT(8)) and
			 (STWMIN(9) and COUNTER_OUT(9)) and
			 (STWMIN(10) and COUNTER_OUT(10)) and
			 (STWMIN(11) and COUNTER_OUT(11)) and
			 (STWMIN(12) and COUNTER_OUT(12)) and
			 (STWMIN(13) and COUNTER_OUT(13)) and
			 (STWMIN(14) and COUNTER_OUT(14)) and
			 (STWMIN(15) and COUNTER_OUT(15));
			 
	NMI <= (STNMI(0) and COUNTER_OUT(0)) and
			 (STNMI(1) and COUNTER_OUT(1)) and
			 (STNMI(2) and COUNTER_OUT(2)) and
			 (STNMI(3) and COUNTER_OUT(3)) and
			 (STNMI(4) and COUNTER_OUT(4)) and
			 (STNMI(5) and COUNTER_OUT(5)) and
			 (STNMI(6) and COUNTER_OUT(6)) and
			 (STNMI(7) and COUNTER_OUT(7)) and
			 (STNMI(8) and COUNTER_OUT(8)) and
			 (STNMI(9) and COUNTER_OUT(9)) and
			 (STNMI(10) and COUNTER_OUT(10)) and
			 (STNMI(11) and COUNTER_OUT(11)) and
			 (STNMI(12) and COUNTER_OUT(12)) and
			 (STNMI(13) and COUNTER_OUT(13)) and
			 (STNMI(14) and COUNTER_OUT(14)) and
			 (STNMI(15) and COUNTER_OUT(15));
			 
	RESET <= (CLEAR and (not TOUT)) or
			   ((STWMAX(0) and COUNTER_OUT(0)) and
				 (STWMAX(1) and COUNTER_OUT(1)) and
				 (STWMAX(2) and COUNTER_OUT(2)) and
				 (STWMAX(3) and COUNTER_OUT(3)) and
				 (STWMAX(4) and COUNTER_OUT(4)) and
				 (STWMAX(5) and COUNTER_OUT(5)) and
				 (STWMAX(6) and COUNTER_OUT(6)) and
				 (STWMAX(7) and COUNTER_OUT(7)) and
				 (STWMAX(8) and COUNTER_OUT(8)) and
				 (STWMAX(9) and COUNTER_OUT(8)) and
				 (STWMAX(10) and COUNTER_OUT(9)) and
				 (STWMAX(11) and COUNTER_OUT(10)) and
				 (STWMAX(12) and COUNTER_OUT(11)) and
				 (STWMAX(13) and COUNTER_OUT(12)) and
				 (STWMAX(14) and COUNTER_OUT(13)) and
				 (STWMAX(15) and COUNTER_OUT(14)));	

end RTL;

