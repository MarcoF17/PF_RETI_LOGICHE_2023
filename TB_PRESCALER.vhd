
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_PRESCALER IS
END TB_PRESCALER;
 
ARCHITECTURE behavior OF TB_PRESCALER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
	component PRESCALER is
		port(
			EXP_VALUE: in std_logic_vector(3 downto 0);
			CLK_ENABLE: out std_logic;
			CLK: in std_logic;
			RST: in std_logic
		);
	end component;
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
	signal EXP_VALUE : std_logic_vector(3 downto 0);

 	--Outputs
   signal CLK_ENABLE: std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PRESCALER PORT MAP (
				EXP_VALUE => EXP_VALUE,
				CLK => CLK,
				RST => RST,
				CLK_ENABLE => CLK_ENABLE
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
		EXP_VALUE <= "0000";
      wait for 100 ns;	
		
		RST <= '0';


      wait;
   end process;

END;
