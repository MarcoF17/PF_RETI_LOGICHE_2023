
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY TB_COUNTER_16BIT IS
END TB_COUNTER_16BIT;
 
ARCHITECTURE behavior OF TB_COUNTER_16BIT IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT COUNTER_16BIT
    PORT(
         CLK : IN  std_logic;
         RST : IN  std_logic;
         DOUT : OUT  std_logic_vector(15 downto 0);
			ENABLE : IN std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic;
   signal RST : std_logic;
	signal ENABLE : std_logic;

 	--Outputs
   signal DOUT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: COUNTER_16BIT PORT MAP (
          CLK => CLK,
          RST => RST,
          DOUT => DOUT,
			 ENABLE => ENABLE
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
		RST <= '1';
		ENABLE <= '0';
		
      wait for 100 ns;	
		
		RST <='0';
		
		wait for 102 ns;
		
		ENABLE <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
