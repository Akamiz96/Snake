---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY score_tb IS
END ENTITY score_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF score_tb IS
	SIGNAL			clk_tb				: 	 	STD_LOGIC := '0';
	SIGNAL			rst_tb				: 	 	STD_LOGIC:= '1';  
	SIGNAL			ena_score_tb			:   	STD_LOGIC;
	SIGNAL			mem_unidades_tb			:  	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL			mem_decenas_tb			:  	STD_LOGIC_VECTOR(3	DOWNTO 0);
	SIGNAL			mem_centenas_tb			: 		STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL			mem_unidades_miles_tb				:  	STD_LOGIC_VECTOR(3 DOWNTO 0);
---------------------------------------------------------
BEGIN 

		--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst_tb <= '0' after 15ns;

	DUT: ENTITY work.score
		  PORT MAP(  	clk => clk_tb,
							rst => rst_tb,
							ena_score => ena_score_tb,
							mem_unidades => mem_unidades_tb,
							mem_decenas => mem_decenas_tb,
							mem_centenas => mem_centenas_tb,
							mem_unidades_miles => mem_unidades_miles_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		ena_score_tb <= '1';
		WAIT;
	END PROCESS tesVectorGenerator;
END ARCHITECTURE testbench;