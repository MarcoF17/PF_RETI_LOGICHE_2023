
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_PRESCALER IS
END TB_PRESCALER;
 
ARCHITECTURE behavior OF TB_PRESCALER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PRESCALER
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DOUT : OUT  std_logic_vector(9 downto 0);
			CLK_BASE : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal RST : std_logic := '0';

 	--Outputs
   signal DOUT : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PRESCALER PORT MAP (
          CLK => CLK,
          RST => RST,
          DOUT => DOUT,
			 CLK_BASE => CLK
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
      wait for 100 ns;	
		
		RST <= '0'; 

      wait;
   end process;

END;
