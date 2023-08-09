
library ieee;
use ieee.std_logic_1164.all;

entity PRESCALER is
	port(
		CLK_IN: in std_logic;
		CLK_BASE_OUT: out std_logic;
		CLK_DIVIDED_OUT: out std_logic_vector(9 downto 0);
		RST: in std_logic
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
			RST: in std_logic
		);
	end component;
	
	component MUX2 is
		port(
			A: in std_logic_vector(9 downto 0);
			B: in std_logic_vector(9 downto 0);
			S: in std_logic;
			Y: out std_logic_vector(9 downto 0)
		);
	end component;
	
	signal TDOUT: std_logic_vector(9 downto 0);
	signal TLOOP: std_logic_vector(9 downto 0);
	signal TO_MUXA: std_logic_vector(9 downto 0);
	signal TO_MUXB: std_logic_vector(9 downto 0);
	signal MUX_CONTROL: std_logic;
	
begin
	URCA: RCA_10BIT port map(
		X => TDOUT,
		S => TO_MUXA
	);
	
	UFF: D_FLIPFLOP_10BIT port map(
		D => TLOOP,
		Q => TDOUT,
		CLK => CLK_IN,
		RST => RST
	);
	
	UMUX: MUX2 port map(
		A => TO_MUXA,
		B => TO_MUXB,
		S => MUX_CONTROL,
		Y => TLOOP
	);
		
	CLK_BASE_OUT <= CLK_IN;
	CLK_DIVIDED_OUT <= TDOUT;
	
	p: process(TDOUT)
		begin
			if(TDOUT = "1111111111") then
				MUX_CONTROL <= '1';
			else
				MUX_CONTROL <= '0';
			end if;
		end process;

end RTL;


