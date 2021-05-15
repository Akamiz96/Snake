---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY timer10ms_tb IS
END ENTITY timer10ms_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF timer10ms_tb IS
	SIGNAL	clk_tb				: 	 	STD_LOGIC := '0';
	SIGNAL	rst_tb				: 	 	STD_LOGIC:= '1';    
	SIGNAL	ena_tb				: 	 	STD_LOGIC;
	SIGNAL	syn_clr_tb			: 	 	STD_LOGIC;
	SIGNAL	max_tick_tb			: 	 	STD_LOGIC;
	SIGNAL	min_tick_tb			: 	 	STD_LOGIC;
	SIGNAL	counter_tb			:		STD_LOGIC_VECTOR(3 DOWNTO 0);
---------------------------------------------------------
BEGIN 
	--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst_tb <= '0' after 50ns;
	DUT: ENTITY work.timer10ms
		  GENERIC  MAP (N_50	=> 4)
		  PORT MAP(  	clk	=> clk_tb,
							rst	=> rst_tb,
							ena	=> ena_tb, 
							syn_clr	=> syn_clr_tb,
							max_tick	=> max_tick_tb,
							min_tick	=> min_tick_tb,
							counter	=> counter_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		
		-- TEST VECTOR 1
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		WAIT FOR 450 ns;
		-- TEST VECTOR 2
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '1';
		WAIT FOR 100 ns;
		-- TEST VECTOR 3
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		WAIT FOR 100 ns;
		-- TEST VECTOR 5
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		WAIT FOR 150 ns;
		-- TEST VECTOR 2
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		WAIT FOR 150 ns;
		WAIT;
	END PROCESS tesVectorGenerator;
	
END ARCHITECTURE testbench;

