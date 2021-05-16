---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY score_tb IS
END ENTITY score_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF score_tb IS
	SIGNAL			puntaje_tb			:   	STD_LOGIC_VECTOR(17 DOWNTO 0);
	SIGNAL			clk_tb				: 	 	STD_LOGIC := '0';
	SIGNAL			rst_tb				: 	 	STD_LOGIC:= '1';  
	SIGNAL			ena_score_tb			:   	STD_LOGIC;
	SIGNAL			unidades_tb			:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			decenas_tb			:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			centenas_tb			: 		STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			unidades_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			decenas_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			centenas_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
---------------------------------------------------------
BEGIN 

		--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst_tb <= '0' after 15ns;

	DUT: ENTITY work.score
		  PORT MAP(  	puntaje => puntaje_tb,
							clk => clk_tb,
							rst => rst_tb,
							ena_score => ena_score_tb,
							unidades => unidades_tb,
							decenas => decenas_tb,
							centenas => centenas_tb,
							unidades_miles => unidades_miles_tb,
							decenas_miles => decenas_miles_tb,
							centenas_miles => centenas_miles_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		puntaje_tb <= "110101110011101101";
		ena_score_tb <= '0';
		WAIT FOR 50ns;
		ena_score_tb <= '1';
		WAIT FOR 20ns;
		ena_score_tb <= '0';
		WAIT FOR 40ns;
		ena_score_tb <= '1';
		WAIT FOR 40ns;
		ena_score_tb <= '0';
		WAIT;
	END PROCESS tesVectorGenerator;
END ARCHITECTURE testbench;