
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY TB_INPUT_HANDLER IS
END TB_INPUT_HANDLER;
 
ARCHITECTURE behavior OF TB_INPUT_HANDLER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT INPUT_HANDLER
    PORT(
         DATA : IN  std_logic_vector(15 downto 0);
         COMMAND : IN  std_logic_vector(2 downto 0);
         PRESC : OUT  std_logic_vector(15 downto 0);
         TWMIN : OUT  std_logic_vector(15 downto 0);
         TWMAX : OUT  std_logic_vector(15 downto 0);
         TNMI : OUT  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic;
			IS_STARTED : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DATA : std_logic_vector(15 downto 0);
   signal COMMAND : std_logic_vector(2 downto 0);
   signal CLK : std_logic;
   signal RST : std_logic;

 	--Outputs
   signal PRESC : std_logic_vector(15 downto 0);
   signal TWMIN : std_logic_vector(15 downto 0);
   signal TWMAX : std_logic_vector(15 downto 0);
   signal TNMI : std_logic_vector(15 downto 0);
	signal IS_STARTED : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: INPUT_HANDLER PORT MAP (
          DATA => DATA,
          COMMAND => COMMAND,
          PRESC => PRESC,
          TWMIN => TWMIN,
          TWMAX => TWMAX,
          TNMI => TNMI,
          CLK => CLK,
          RST => RST,
			 IS_STARTED => IS_STARTED
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
      wait for 100 ns;	
		
		RST <= '0';		
		COMMAND <= "000";
		
		wait for 5 ns;
		
		DATA <= "0011001100110011";

      wait for 50 ns;
		
		COMMAND <= "001";
		
		wait for 5 ns;
		
		DATA <= "0000000000000001";
		
		wait for 50 ns;
		
		COMMAND <= "010";
		
		wait for 5 ns;
		
		DATA <= "1111111100000000";
		
		wait for 50 ns;
		
		COMMAND <= "011";
		
		wait for 5 ns;
		
		DATA <= "1010101010101010";
		
		wait for 50 ns;
		
		COMMAND <= "100";
		
      -- insert stimulus here 

      wait;
   end process;

END;
