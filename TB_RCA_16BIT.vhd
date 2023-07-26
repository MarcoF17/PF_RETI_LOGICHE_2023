
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_RCA_16BIT IS
END TB_RCA_16BIT;
 
ARCHITECTURE behavior OF TB_RCA_16BIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RCA_16BIT
    PORT(
         X : IN  std_logic_vector(15 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         COUT : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(15 downto 0);


 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal COUT : std_logic;	
	-- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RCA_16BIT PORT MAP (
          X => X,
          S => S,
          COUT => COUT
        );
		  
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		X <= "0011000000111111";

      wait;
   end process;

END;
