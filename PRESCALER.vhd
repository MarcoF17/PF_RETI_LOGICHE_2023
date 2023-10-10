
library ieee;
use ieee.std_logic_1164.all;

entity PRESCALER is
	port(
		EXP_VALUE: in std_logic_vector(3 downto 0);
		CLK_ENABLE: out std_logic;
		CLK: in std_logic;
		RST: in std_logic
	);
end PRESCALER;

architecture RTL of PRESCALER is
	
	component RCA_GENERIC is
		generic(
			N: integer
		);
		port(
			X: in std_logic_vector(N-1 downto 0);
			S: out std_logic_vector(N-1 downto 0);
			COUT: out std_logic
		);
	end component;
	
	component DECODER is
		port(
			X: in std_logic_vector(3 downto 0);
			Y: out std_logic_vector(10 downto 0)
			);
	end component;
	
	component MUX_2_1 is
		port(
			A: in std_logic_vector(10 downto 0);
			B: in std_logic_vector(10 downto 0);
			S: in std_logic;
			Y: out std_logic_vector(10 downto 0)
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
	
	signal FF_OUT: std_logic_vector(10 downto 0);
	signal DEC_OUT: std_logic_vector(10 downto 0);
	signal RCA_OUT: std_logic_vector(10 downto 0);
	signal MUX_CONTROL: std_logic;
	signal MUX_OUT: std_logic_vector(10 downto 0);

begin	
	UFF: D_FLIPFLOP_WITH_ENA
		generic map(
			N => 11
		)
		port map(
			CLK => CLK,
			RST => RST,
			ENABLE => '1',
			D => MUX_OUT,
			Q => FF_OUT
		);
		
	UMUX: MUX_2_1
		port map(
			A => RCA_OUT,
			B => "00000000000",
			Y => MUX_OUT,
			S => MUX_CONTROL
		);
		
	UDEC: DECODER
		port map(
			X => EXP_VALUE,
			Y => DEC_OUT
		);
		
	URCA: RCA_GENERIC
		generic map(
			N => 11
		)
		port map(
			X => FF_OUT,
			S => RCA_OUT
		);
		
	control: process(RCA_OUT)
		begin
			if(RCA_OUT = DEC_OUT) then
				MUX_CONTROL <= '1';
			else
				MUX_CONTROL <= '0';
			end if;
		end process;
		
	clkenable: process(FF_OUT)
		begin
			if(FF_OUT = "00000000000") then
				CLK_ENABLE <= '1';
			else
				CLK_ENABLE <= '0';
			end if;
		end process;
		
		--FFOUT <= FF_OUT;
		--MUXOUT <= MUX_OUT;
		--DECOUT <= DEC_OUT;
		--RCAOUT <= RCA_OUT;

end RTL;

