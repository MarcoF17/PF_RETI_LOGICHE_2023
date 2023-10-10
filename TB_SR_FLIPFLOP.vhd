
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_SR_FLIPFLOP IS
END TB_SR_FLIPFLOP;
 
ARCHITECTURE behavior OF TB_SR_FLIPFLOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SR_FLIPFLOP
    PORT(
         S : IN  std_logic;
         R : IN  std_logic;
         Q : OUT  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal S : std_logic;
   signal R : std_logic;
   signal CLK : std_logic;

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SR_FLIPFLOP PORT MAP (
          S => S,
          R => R,
          Q => Q,
          CLK => CLK
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
		
		R <= '1';
		S <= '0';
      wait for 100 ns;	
		
		R <= '0';

      wait for 10 ns;
		
		S <= '1';
		
		wait for 50 ns;
		
		S <= '0';
		
		wait for 10 ns;
		
		R <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
