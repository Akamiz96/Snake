---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY FOOD_tb IS
END ENTITY FOOD_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF FOOD_tb IS
	SIGNAL			clk_tb				: 	 	STD_LOGIC := '0';
	SIGNAL			rst_tb				: 	 	STD_LOGIC:= '1';  
	SIGNAL			start_tb				  :		STD_LOGIC;
	SIGNAL			comer_tb				  :		STD_LOGIC;
	SIGNAL			alive_tb				  :		STD_LOGIC;
	SIGNAL			ena_food_tb			  :		STD_LOGIC;
	SIGNAL			food_x_tb			  :		STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL			food_y_tb			  :		STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL			mem_unidades_tb		:     STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL			mem_decenas_tb				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL			mem_centenas_tb				:  STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL			mem_unidades_miles_tb		:  STD_LOGIC_VECTOR(3 DOWNTO 0);
---------------------------------------------------------
BEGIN 

		--CLOCK GENERATION:------------------------
	clk_tb <= not clk_tb after 10ns; -- 50MHz clock generation
	--RESET GENERATION:------------------------
	rst_tb <= '0' after 15ns;

	DUT: ENTITY work.FOOD
		  PORT MAP(  	clk => clk_tb,
							rst => rst_tb,
							start	=> start_tb,
							alive	=> alive_tb,
							ena_food		=>  ena_food_tb,
							ena_save		=> comer_tb,
							food_x		=> food_x_tb,
							food_y		=> food_y_tb,
							mem_unidades		=> mem_unidades_tb,
							mem_decenas			=> mem_decenas_tb,
							mem_centenas		=> mem_centenas_tb,
							mem_unidades_miles	=> mem_unidades_miles_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		start_tb <= '1';
		alive_tb <= '1';
		ena_food_tb <= '1';
		WAIT FOR 150ns;
		start_tb <= '1';
		alive_tb <= '0';
		ena_food_tb <= '1';
		WAIT FOR 50ns;
		start_tb <= '1';
		alive_tb <= '1';
		ena_food_tb <= '1';
		WAIT FOR 50ns;
		start_tb <= '1';
		alive_tb <= '0';
		ena_food_tb <= '1';
		WAIT FOR 50ns;
		start_tb <= '1';
		alive_tb <= '0';
		ena_food_tb <= '0';
		WAIT;
	END PROCESS tesVectorGenerator;
END ARCHITECTURE testbench;