
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_DEMUX_1_4 IS
END TB_DEMUX_1_4;
 
ARCHITECTURE behavior OF TB_DEMUX_1_4 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DEMUX_1_4
    PORT(
         DIN : IN  std_logic_vector(15 downto 0);
         COMMAND : IN  std_logic_vector(2 downto 0);
         TO_PS : OUT  std_logic_vector(15 downto 0);
         TO_TWMIN : OUT  std_logic_vector(15 downto 0);
         TO_TWMAX : OUT  std_logic_vector(15 downto 0);
         TO_TNMI : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(15 downto 0);
   signal COMMAND : std_logic_vector(2 downto 0);

 	--Outputs
   signal TO_PS : std_logic_vector(15 downto 0);
   signal TO_TWMIN : std_logic_vector(15 downto 0);
   signal TO_TWMAX : std_logic_vector(15 downto 0);
   signal TO_TNMI : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DEMUX_1_4 PORT MAP (
          DIN => DIN,
          COMMAND => COMMAND,
          TO_PS => TO_PS,
          TO_TWMIN => TO_TWMIN,
          TO_TWMAX => TO_TWMAX,
          TO_TNMI => TO_TNMI
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

			DIN <= "0101010101010111";
			COMMAND <= "000";

      wait for 100 ns;
		
			COMMAND <= "001";
			
		wait for 100 ns;
		
			COMMAND <= "010";
			
		wait for 100 ns;
		
			COMMAND <= "011";
		
		wait for 100 ns;
		
			COMMAND <= "100";

      -- insert stimulus here 

      wait;
   end process;

END;
