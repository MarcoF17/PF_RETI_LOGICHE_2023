
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
         RESET : OUT  std_logic;
			COUNT : OUT std_logic_vector(15 downto 0)
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
	signal COUNT : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: WATCHDOG PORT MAP (
          COMMAND => COMMAND,
          DATA => DATA,
          CLK => CLK,
          RST => RST,
          CLEAR => CLEAR,
          NMI => NMI,
          RESET => RESET,
			 COUNT => COUNT
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
		
		COMMAND <= "100";
		
		wait for 100 ns;
		
		CLEAR <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
