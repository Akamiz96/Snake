---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY univ_bin_counter_tb IS
END ENTITY univ_bin_counter_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF univ_bin_counter_tb IS
	SIGNAL	clk_tb				: 	 	STD_LOGIC := '0';
	SIGNAL	rst_tb				: 	 	STD_LOGIC:= '1';    
	SIGNAL	ena_tb				: 	 	STD_LOGIC;
	SIGNAL	syn_clr_tb			: 	 	STD_LOGIC;
	SIGNAL	load_tb				: 	 	STD_LOGIC;
	SIGNAL	up_tb					: 	 	STD_LOGIC;
	SIGNAL	d_tb					:		STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL	max_tick_tb			: 	 	STD_LOGIC;
	SIGNAL	min_tick_tb			: 	 	STD_LOGIC;
	SIGNAL	counter_tb			:		STD_LOGIC_VECTOR(3 DOWNTO 0);
---------------------------------------------------------
BEGIN 
	--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst_tb <= '0' after 50ns;
	DUT: ENTITY work.univ_bin_counter
		  GENERIC  MAP (N	=> 4)
		  PORT MAP(  	clk	=> clk_tb,
							rst	=> rst_tb,
							ena	=> ena_tb, 
							syn_clr	=> syn_clr_tb,
							load	=> load_tb,
							up	=> up_tb,
							d	=> d_tb,
							max_tick	=> max_tick_tb,
							min_tick	=> min_tick_tb,
							counter	=> counter_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		
		-- TEST VECTOR 1
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		load_tb		<= '0';
		up_tb			<= '1';
		d_tb			<= "0000";
		WAIT FOR 450 ns;
		-- TEST VECTOR 2
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '1';
		load_tb		<= '0';
		up_tb			<= '1';
		d_tb			<= "0000";
		WAIT FOR 100 ns;
		-- TEST VECTOR 3
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		load_tb		<= '0';
		up_tb			<= '1';
		d_tb			<= "0101";
		WAIT FOR 100 ns;
		-- TEST VECTOR 5
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		load_tb		<= '0';
		up_tb			<= '1';
		d_tb			<= "0101";
		WAIT FOR 150 ns;
		-- TEST VECTOR 2
		ena_tb    	<= '1'; 
		syn_clr_tb  <= '0';
		load_tb		<= '0';
		up_tb			<= '0';
		d_tb			<= "0101";
		WAIT FOR 150 ns;
		WAIT;
	END PROCESS tesVectorGenerator;
	
END ARCHITECTURE testbench;

