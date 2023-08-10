
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_PRESCALER IS
END TB_PRESCALER;
 
ARCHITECTURE behavior OF TB_PRESCALER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PRESCALER
    PORT(
		CLK_IN: in std_logic;
		CLK_BASE_OUT: out std_logic;
		CLK_DIVIDED_OUT: out std_logic_vector(9 downto 0);
		RST: in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK_IN : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal CLK_DIVIDED_OUT: std_logic_vector(9 downto 0);
	signal CLK_BASE_OUT: std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PRESCALER PORT MAP (
          CLK_IN => CLK_IN,
          RST => RST,
          CLK_DIVIDED_OUT => CLK_DIVIDED_OUT,
			 CLK_BASE_OUT => CLK_BASE_OUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK_IN <= '0';
		wait for CLK_period/2;
		CLK_IN <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '1';
      wait for 100 ns;	
		
		RST <= '0';

      wait;
   end process;

END;
