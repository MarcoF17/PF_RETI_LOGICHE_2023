
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_MUX2 IS
END TB_MUX2;
 
ARCHITECTURE behavior OF TB_MUX2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MUX2
    PORT(
         A : IN  std_logic_vector(9 downto 0);
         B : IN  std_logic_vector(9 downto 0);
         S : IN  std_logic;
         Y : OUT  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(9 downto 0);
   signal B : std_logic_vector(9 downto 0);
   signal S : std_logic;

 	--Outputs
   signal Y : std_logic_vector(9 downto 0);

 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX2 PORT MAP (
          A => A,
          B => B,
          S => S,
          Y => Y
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		A <= "0101010101";
		B <= (others => '0');
		
		S <= '0';

      wait for 10 ns;
		
		S <= '1';
		A <= "1010101010";
		
		wait for 10 ns;
		
		S <= '0';
		
		wait for 10 ns;
		
		A <= (others => '1');

      -- insert stimulus here 

      wait;
   end process;

END;
