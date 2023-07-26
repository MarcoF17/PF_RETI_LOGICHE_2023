
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_HA IS
END TB_HA;
 
ARCHITECTURE behavior OF TB_HA IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HA
    PORT(
         X : IN  std_logic;
         Y : IN  std_logic;
         S : OUT  std_logic;
         C : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic;
   signal Y : std_logic;

 	--Outputs
   signal S : std_logic;
   signal C : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: HA PORT MAP (
          X => X,
          Y => Y,
          S => S,
          C => C
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

			X <= '0';
			Y <= '0';

      wait for 20 ns;
		
			X <= '1';
			
		wait for 20 ns;
		
			Y <= '1';
			
		wait for 20 ns;
		
			X <= '0';
		
		wait;
   end process;

END;
