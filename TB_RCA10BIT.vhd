
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_RCA10BIT IS
END TB_RCA10BIT;
 
ARCHITECTURE behavior OF TB_RCA10BIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RCA_10BIT
    PORT(
         X : IN  std_logic_vector(9 downto 0);
         S : OUT  std_logic_vector(9 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(9 downto 0);

 	--Outputs
   signal S : std_logic_vector(9 downto 0);
   signal COUT : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
  
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RCA_10BIT PORT MAP (
          X => X,
          S => S,
          COUT => COUT
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.		
		X <= "0010111111";
		
		wait for 20 ns;
		
		X <= "1111111111";

      -- insert stimulus here 

      wait;
   end process;

END;
