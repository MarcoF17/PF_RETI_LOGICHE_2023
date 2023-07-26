LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_T_FLIPFLOP IS
END TB_T_FLIPFLOP;
 
ARCHITECTURE behavior OF TB_T_FLIPFLOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT T_FLIPFLOP
    PORT(
         T : IN  std_logic;
         Q : OUT  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal T : std_logic;
   signal RST : std_logic;
   signal CLK : std_logic;

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: T_FLIPFLOP PORT MAP (
          T => T,
          Q => Q,
          RST => RST,
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
		--RST <= '0';
		
		--wait for 20 ns;
		
		RST <= '1';
		
      wait for 100 ns;	

		RST <= '0';
		
		T <= '0';
		
		wait for 10 ns;
		
		T <= '1';
		
		wait for 10 ns;
		
		T <= '0';
		
		wait for 10 ns;
		
		T <= '1';
		
		wait for 50 ns;
		
		T <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
