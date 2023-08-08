
library ieee;
use ieee.std_logic_1164.all;

entity RCA_10BIT is
	port(
		X: in std_logic_vector(9 downto 0);
		S: out std_logic_vector(9 downto 0);
		COUT: out std_logic
	);
end RCA_10BIT;

architecture RTL of RCA_10BIT is
	component HA is
		port(
			X: in std_logic;
			Y: in std_logic;
			S: out std_logic;
			C: out std_logic
		);
	end component;
	
	signal C: std_logic_vector(9 downto 0);
	signal TS: std_logic_vector(9 downto 0);
	signal ONE: std_logic;
	
	begin
		ONE <= '1';
		
		U0: HA port map(
			X => X(0),
			Y => ONE,
			C => C(0),
			S => S(0)
		);
		
	GEN: for I in 1 to 9 generate
		U: HA port map(
			X => X(I),
			Y => C(I-1),
			C => C(I),
			S => S(I)
		);
	end generate GEN;
	
	COUT <= C(9);

end RTL;

