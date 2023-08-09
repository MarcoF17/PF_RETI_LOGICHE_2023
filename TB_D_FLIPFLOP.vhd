
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY TB_D_FLIPFLOP IS
END TB_D_FLIPFLOP;
 
ARCHITECTURE behavior OF TB_D_FLIPFLOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT D_FLIPFLOP_10BIT
    PORT(
         D: in std_logic_vector(9 downto 0);
			Q: out std_logic_vector(9 downto 0);
			CLK: in std_logic;
			RST: in std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(9 downto 0);
   signal CLK : std_logic;
   signal RST : std_logic;

 	--Outputs
   signal Q : std_logic_vector(9 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 35 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: D_FLIPFLOP_10BIT PORT MAP (
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

		RST <= '1';
		
      wait for 105 ns;	
		
		RST <= '0';
		D <= "0101010101";

      wait for 45 ns;
		
		D <= "1111111110";

      -- insert stimulus here 

      wait;
   end process;

END;
