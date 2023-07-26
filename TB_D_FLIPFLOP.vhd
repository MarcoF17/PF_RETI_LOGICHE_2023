
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_D_FLIPFLOP IS
END TB_D_FLIPFLOP;
 
ARCHITECTURE behavior OF TB_D_FLIPFLOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT D_FLIPFLOP
    PORT(
         D : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(15 downto 0);
   signal CLK : std_logic;
   signal RST : std_logic;

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: D_FLIPFLOP PORT MAP (
          D => D,
          Q => Q,
          CLK => CLK,
          RST => RST
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
      wait for 105 ns;	
		
		D <= "0101010101010101";

      wait for 20 ns;
		
		D <= "1111111111111110";

      -- insert stimulus here 

      wait;
   end process;

END;
