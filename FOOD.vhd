-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY FOOD IS
	PORT	(	clk              :	IN		STD_LOGIC;    
            rst              :	IN		STD_LOGIC;
				start				  :	IN		STD_LOGIC;
				alive				  :	IN		STD_LOGIC;
				ena_food			  :	IN		STD_LOGIC;
				food_x			  :	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_y			  :	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				mem_unidades		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_decenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_centenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_unidades_miles		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY FOOD;
-------------------------------------------------------------------------------
ARCHITECTURE structural OF FOOD IS
	SIGNAL save_value_x_s	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL save_value_y_s	: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ena_save_s			: STD_LOGIC;
	SIGNAL ena_rand_s			: STD_LOGIC;
	SIGNAL max_tick_s			: STD_LOGIC;
	SIGNAL min_tick_s			: STD_LOGIC;
	SIGNAL counter_rand_one_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL counter_rand_two_s : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL ena_score_s		: STD_LOGIC;

BEGIN	
	MemPosFood: ENTITY	work.mem_pos_food
		PORT MAP	(	clk	=> clk,
						rst	=> rst,
						ena	=> ena_save_s,
						d_x	=> save_value_x_s,
						d_y	=> save_value_y_s,
						q_x	=> food_x,
						q_y	=> food_y);

	
	FoodController: ENTITY	work.fsm_snake_food
		PORT MAP	(	clk	=> clk,
						rst	=> rst,
						start	=> start,
						ena_food	=> ena_food,
						alive		=> alive,
						counter_rand_one		=> counter_rand_one_s,
						counter_rand_two		=>counter_rand_two_s,
						ena_rand			=> ena_rand_s,
						ena_score		=>	ena_score_s,
						ena_save				=>	ena_save_s,
						save_value_x		=> save_value_x_s,
						save_value_y		=> save_value_y_s);
	
	Random: ENTITY	work.rand
		PORT MAP	(	clk	=> clk,
						rst	=> rst,
						ena	=> ena_rand_s,
						syn_clr		=> '0',
						max_tick		=> max_tick_s,
						min_tick		=> min_tick_s,
						counter_rand_one		=> counter_rand_one_s,
						counter_rand_two		=>counter_rand_two_s);
	
	ScoreGame: ENTITY	work.score
		PORT MAP	(	clk	=> clk,
						rst	=> rst,
						ena_score		=>	ena_score_s,
						mem_unidades	=>	mem_unidades,
						mem_decenas		=>		mem_decenas,
						mem_centenas	=>			mem_centenas,
						mem_unidades_miles	=>	mem_unidades_miles);
			

END ARCHITECTURE structural;
------------------------------------------------------------------------------