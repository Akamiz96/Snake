---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY snake IS
	GENERIC (N				      :	INTEGER	:=	9;
				DATA_WIDTH			: 	INTEGER	:=	119;
				ADDR_WIDTH			:  INTEGER	:=	7;
				DATA_WIDTH2			:	INTEGER	:=	14);
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				stop					: 	IN 	STD_LOGIC;
				pintar_x				:  OUT 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				pintar_y				:  OUT  	STD_LOGIC_VECTOR(5 DOWNTO 0);
				we						:  OUT  	STD_LOGIC;
				pintar_despintar	: 	OUT	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC;
				food_x			  :	IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				food_y			  :	IN 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				comida			  :	OUT 	STD_LOGIC;
				mem_unidades		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_decenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_centenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_unidades_miles		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				selector_tablero 		:  IN 	STD_LOGIC_VECTOR(1 downto 0)
);
END ENTITY snake;
ARCHITECTURE structural OF snake IS

	--
	SIGNAL pintar_x_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL pintar_y_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL we_s						:	STD_LOGIC;
	SIGNAL pintar_despintar_s	:	STD_LOGIC;
	
	SIGNAL max_tick_s		:	STD_LOGIC;
	SIGNAL ena_tb			:	STD_LOGIC := '1';
	SIGNAL syn_tb			:	STD_LOGIC := '0';
	SIGNAL min_tickRY_s	:	STD_LOGIC;
	SIGNAL counterRY_s	:	STD_LOGIC_VECTOR(26 DOWNTO 0);
	--
	
	SIGNAL x_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL y_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_x      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_y      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_wr		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL data_rd		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL rd_signal   : STD_LOGIC;
	SIGNAL wr_signal   : STD_LOGIC;
	SIGNAL ef			 : STD_LOGIC;
	SIGNAL comida_sig	 : STD_LOGIC;
	
	SIGNAL clear_s	 : STD_LOGIC;
	SIGNAL ena_score_s	 : STD_LOGIC;
	
	SIGNAL max_tick_tmr		:	STD_LOGIC;
	SIGNAL ena_tmr			:	STD_LOGIC := '1';
	SIGNAL syn_tmr			:	STD_LOGIC := '0';
	SIGNAL min_tick_tmr	:	STD_LOGIC;
	SIGNAL counter_tmr	:	STD_LOGIC_VECTOR(25 DOWNTO 0);
	
	SIGNAL obstacle	: STD_LOGIC;
	SIGNAL obstacle_1	: STD_LOGIC;
	SIGNAL obstacle_2	: STD_LOGIC;
	SIGNAL obstacle_3	: STD_LOGIC;
	
	SIGNAL stop_snake		:	STD_LOGIC;
	SIGNAL choque		:	STD_LOGIC;
	
	SIGNAL sel_timer	:	STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	SIGNAL timer_mov_counter	:	STD_LOGIC_VECTOR(26 DOWNTO 0);
	
	SIGNAL mem_unidades_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_decenas_s				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_centenas_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_unidades_miles_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL puntaje	:	STD_LOGIC_VECTOR(15 DOWNTO 0);
	--CONSTANTES 
	CONSTANT CERO 	:  STD_LOGIC_VECTOR(3 downto 0):= "0000";
	CONSTANT UNO	:  STD_LOGIC_VECTOR(3 downto 0):= "0001";
	CONSTANT DOS	:  STD_LOGIC_VECTOR(3 downto 0):= "0010";
	CONSTANT TRES	:  STD_LOGIC_VECTOR(3 downto 0):= "0011";
	CONSTANT CUATRO:  STD_LOGIC_VECTOR(3 downto 0):= "0100";
	CONSTANT CINCO :  STD_LOGIC_VECTOR(3 downto 0):= "0101";
	CONSTANT SEIS	:  STD_LOGIC_VECTOR(3 downto 0):= "0110";
	CONSTANT SIETE :  STD_LOGIC_VECTOR(3 downto 0):= "0111";
	CONSTANT OCHO	:  STD_LOGIC_VECTOR(3 downto 0):= "1000";
	CONSTANT NUEVE	:  STD_LOGIC_VECTOR(3 downto 0):= "1001";
	--
	
	SIGNAL syn_timer_mov		:	STD_LOGIC;
	SIGNAL syn_change_time		:	STD_LOGIC;

 BEGIN 
 
	pintar_x <= pintar_x_s;
	pintar_y <= pintar_y_s;
	
	
		
	stop_snake <= stop OR choque; 
	
	syn_timer_mov <= syn_tb OR syn_change_time;
	
	obstacle <= obstacle_1 WHEN selector_tablero = "00" ELSE 
					obstacle_2 WHEN selector_tablero = "01" ELSE
					obstacle_3 WHEN selector_tablero = "10" ELSE
					obstacle_1 WHEN selector_tablero = "11";
					
	mem_unidades <= mem_unidades_s;
	mem_decenas <= mem_decenas_s;
	mem_centenas <= mem_centenas_s;
	mem_unidades_miles <= mem_unidades_miles_s;
	puntaje <= mem_unidades_miles_s & mem_centenas_s & mem_decenas_s & mem_unidades_s;
	PROCESS(puntaje)
	VARIABLE selector_timer_anterior : STD_LOGIC_VECTOR(2 downto 0) := "000";
	BEGIN
		IF (rising_edge(clk)) THEN
			IF(puntaje < CERO&CERO&DOS&CERO) THEN
				IF("000" /= selector_timer_anterior) THEN
					syn_change_time <= '1';
					sel_timer <= "000";
					selector_timer_anterior := "000";
				ELSE
					syn_change_time <= '0';
					sel_timer <= "000";
				END IF;
			ELSIF (puntaje < CERO&CERO&CUATRO&CERO) THEN
				IF("001" /= selector_timer_anterior) THEN
					syn_change_time <= '1';
					sel_timer <= "001";
					selector_timer_anterior := "001";
				ELSE
					syn_change_time <= '0';
					sel_timer <= "001";
				END IF;
			ELSIF(puntaje < CERO&CERO&CINCO&CERO) THEN
				IF("011" /= selector_timer_anterior) THEN
					syn_change_time <= '1';
					sel_timer <= "011";
					selector_timer_anterior := "011";
				ELSE
					syn_change_time <= '0';
					sel_timer <= "011";
				END IF;
			ELSE
				IF("100" /= selector_timer_anterior) THEN
					syn_change_time <= '1';
					sel_timer <= "100";
					selector_timer_anterior := "100";
				ELSE
					syn_change_time <= '0';
					sel_timer <= "100";
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	fsm : ENTITY work.snake_controller
	PORT MAP(clk		    	=>	clk,	
				rst			 	=>	rst,
				stop				=> stop_snake,
				max_tick		 	=>	max_tick_s,
				pintar_x	 		=>	pintar_x_s,		
				pintar_y 		=>	pintar_y_s,
				we		 			=>	we,
				pintar_despintar => pintar_despintar,
				ena_timer		=> ena_tb,
				syn_clr_timer	=> syn_tb,
				buttonUp     =>   buttonUp,
				buttonDown   =>   buttonDown,
				buttonLeft   =>   buttonLeft,
				buttonRight  =>   buttonRight,
				food_x		=> food_x,
				food_y		=> food_y,
				comida		=> comida);
				
	TMR: 		ENTITY work.timer_mov
			PORT MAP(  	clk	=> clk,
							rst	=> rst,
							ena	=> ena_tb, 
							syn_clr	=> syn_change_time,
							max_tick	=> max_tick_s,
							min_tick	=> min_tickRY_s,
							counter	=> counterRY_s,
							max_count => timer_mov_counter);
	
	TMR_SCORE: 		ENTITY work.timer_score
			PORT MAP(  	clk	=> clk,
							rst	=> rst,
							ena	=> ena_tmr, 
							syn_clr	=> syn_tmr,
							max_tick	=> max_tick_tmr,
							min_tick	=> min_tick_tmr,
							counter	=> counter_tmr);
							
	GAME: 		ENTITY work.fsm_game
			PORT MAP(  	clk	=> clk,
							rst	=> rst,
							max_tick_tmr => max_tick_tmr,
							clear_score=> clear_s,
							ena_score=> ena_score_s,
							obstacle => obstacle,
							choque => choque,
							stop => stop);
	
	MEM_TMR:  ENTITY work.mem_timer
		   PORT MAP(	pos_x 		=> sel_timer,
							max_tiempo	=> timer_mov_counter);
							
	ScoreGame: ENTITY	work.score
		PORT MAP	(	clk	=> clk,
						rst	=> rst,
						clear => clear_s,
						ena_score		=>	ena_score_s,
						mem_unidades	=>	mem_unidades_s,
						mem_decenas		=>		mem_decenas_s,
						mem_centenas	=>			mem_centenas_s,
						mem_unidades_miles	=>	mem_unidades_miles_s);
						
	OBTACLE3:  ENTITY work.obstacle_image_ref
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(0,6)),
							limite_y => std_logic_vector(to_unsigned(0,6)),
							pos_x 	=> pintar_x_s,
							pos_y 	=> pintar_y_s,
							obstacle => obstacle_3);
	
	OBTACLE1:  ENTITY work.obstacle_image_1_ref
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(0,6)),
							limite_y => std_logic_vector(to_unsigned(0,6)),
							pos_x 	=> pintar_x_s,
							pos_y 	=> pintar_y_s,
							obstacle => obstacle_1);
							
							
	OBTACLE2:  ENTITY work.obstacle_image_2_ref
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(0,6)),
							limite_y => std_logic_vector(to_unsigned(0,6)),
							pos_x 	=> pintar_x_s,
							pos_y 	=> pintar_y_s,
							obstacle => obstacle_2);
	
END ARCHITECTURE structural;