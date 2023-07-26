
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_DECODER_3BIT IS
END TB_DECODER_3BIT;
 
ARCHITECTURE behavior OF TB_DECODER_3BIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECODER_3BIT
    PORT(
         COMMAND : IN  std_logic_vector(2 downto 0);
         DEC_OUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal COMMAND : std_logic_vector(2 downto 0);

 	--Outputs
   signal DEC_OUT : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECODER_3BIT PORT MAP (
          COMMAND => COMMAND,
          DEC_OUT => DEC_OUT
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			
			COMMAND <= "000";
			
			wait for 50 ns;
			
			COMMAND <= "001";
			
			wait for 50 ns;
			
			COMMAND <= "010";
			
			wait for 50 ns;
			
			COMMAND <= "011";
			
			wait for 50 ns;
			
			COMMAND <= "110";

      -- insert stimulus here 

      wait;
   end process;

END;
