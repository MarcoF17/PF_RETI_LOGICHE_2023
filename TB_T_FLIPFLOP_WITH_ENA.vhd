LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_T_FLIPFLOP_WITH_ENA IS
END TB_T_FLIPFLOP_WITH_ENA;
 
ARCHITECTURE behavior OF TB_T_FLIPFLOP_WITH_ENA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT T_FLIPFLOP_WITH_ENA
    PORT(
         T : IN  std_logic;
         Q : OUT  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
			E : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal T : std_logic;
   signal RST : std_logic;
   signal CLK : std_logic;
	signal E : std_logic;

 	--Outputs
   signal Q : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: T_FLIPFLOP_WITH_ENA PORT MAP (
          T => T,
          Q => Q,
          RST => RST,
          CLK => CLK,
			 E => E
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
		E <= '0';
		
      wait for 100 ns;	

		RST <= '0';
		
		T <= '0';
		
		wait for 10 ns;
		
		T <= '1';
		
		wait for 10 ns;
		
		T <= '0';
		E <= '1';
		
		wait for 10 ns;
		
		T <= '1';
		
		wait for 25 ns;
		
		E <= '0';
		
		wait for 45 ns;
		
		T <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;