
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_MUX11 IS
END TB_MUX11;
 
ARCHITECTURE behavior OF TB_MUX11 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX11
    PORT(
         DIN : IN  std_logic_vector(10 downto 0);
         S : IN  std_logic_vector(15 downto 0);
         Y : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(10 downto 0) := (others => '0');
   signal S : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Y : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX11 PORT MAP (
          DIN => DIN,
          S => S,
          Y => Y
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		DIN <= "01101101101";
		S <= "0000000000000000";
		
		wait for 20 ns;
		
		S <= "0000000000000100";
		
		wait for 20 ns;
		
		S <= "0000000000000001";
		
		wait for 20 ns;
		
		S <= "0000000000001001";
      wait;
   end process;

END;
