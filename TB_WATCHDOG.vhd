
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY TB_WATCHDOG IS
END TB_WATCHDOG;
 
ARCHITECTURE behavior OF TB_WATCHDOG IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WATCHDOG
    PORT(
         COMMAND : IN  std_logic_vector(2 downto 0);
         DATA : IN  std_logic_vector(15 downto 0);
         CLK : IN  std_logic;
         RST : IN  std_logic;
         CLEAR : IN  std_logic;
         NMI : OUT  std_logic;
         RESET : OUT  std_logic
			);
    END COMPONENT;
    

   --Inputs
   signal COMMAND : std_logic_vector(2 downto 0);
   signal DATA : std_logic_vector(15 downto 0);
   signal CLK : std_logic;
   signal RST : std_logic;
   signal CLEAR : std_logic;

 	--Outputs
   signal NMI : std_logic;
   signal RESET : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WATCHDOG PORT MAP (
          COMMAND => COMMAND,
          DATA => DATA,
          CLK => CLK,
          RST => RST,
          CLEAR => CLEAR,
          NMI => NMI,
          RESET => RESET
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
      --no clear
      
		RST <= '1';
		DATA <= (others => '0');
		COMMAND <= "111";
		CLEAR <= '0';
		
		wait for 100 ns;
		RST <= '0';
		COMMAND <= "010";
		wait for 5 ns;
		DATA <= "0000000000001111";		
		wait for 20 ns;		
		COMMAND <= "001";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "011";
		wait for 5 ns;
		DATA <= "0000000000000111";		
		wait for 20 ns;		
		COMMAND <= "000";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "100";
		wait for 20 ns;
		COMMAND <= "111";
		
		wait for 700 ns;
		
		
		--clear in window
		
		RST <= '1';
		--DATA <= (others => '0');
		--COMMAND <= "111";
		CLEAR <= '0';
		
		wait for 100 ns;
		RST <= '0';
		COMMAND <= "010";
		wait for 5 ns;
		DATA <= "0000000000001111";		
		wait for 20 ns;		
		COMMAND <= "001";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "011";
		wait for 5 ns;
		DATA <= "0000000000000111";		
		wait for 20 ns;		
		COMMAND <= "000";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "100";
		wait for 20 ns;
		COMMAND <= "111";
		wait for 200 ns;
		CLEAR <= '1';
		wait for 12 ns;
		CLEAR <= '0';

		wait for 1000 ns;
		
		
		--clear before window
		
		RST <= '1';
		--DATA <= (others => '0');
		--COMMAND <= "111";
		CLEAR <= '0';
		
		wait for 100 ns;
		RST <= '0';
		COMMAND <= "010";
		wait for 5 ns;
		DATA <= "0000000000001111";		
		wait for 20 ns;		
		COMMAND <= "001";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "011";
		wait for 5 ns;
		DATA <= "0000000000000111";		
		wait for 20 ns;		
		COMMAND <= "000";
		wait for 5 ns;
		DATA <= "0000000000000001";		
		wait for 20 ns;		
		COMMAND <= "100";
		wait for 20 ns;
		COMMAND <= "111";
		wait for 25 ns;
		CLEAR <= '1';
		wait for 12 ns;
		CLEAR <= '0';
		
		wait for 50 ns;
		RST <= '1';

      wait;
   end process;

END;
