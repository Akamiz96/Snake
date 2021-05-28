----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY fsm_snake_food IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				start				:	IN		STD_LOGIC;
				ena_food			:	IN		STD_LOGIC;
				alive				:	IN		STD_LOGIC;
				--Datos del random
				counter_rand_one		:	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				counter_rand_two		:	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				ena_rand			:	OUT		STD_LOGIC;
				--puntaje
				ena_score		:	OUT		STD_LOGIC;
				--Guardar
				ena_save		:	OUT		STD_LOGIC;
				save_value_x			:	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				save_value_y			:	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY fsm_snake_food;
----------------------------------------------------------------
ARCHITECTURE fsm OF fsm_snake_food IS
	TYPE state IS (waiting,validate,save_food);
	SIGNAL pr_state, nx_state	:	state;
	SHARED VARIABLE x_aux, y_aux : 	STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	waiting;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;

	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state,start,ena_food,alive)
	BEGIN
		CASE pr_state IS
			WHEN waiting =>
				ena_score <= '0';
				IF(start='1') THEN
					ena_rand <= '1';
					IF(ena_food='1') THEN
						x_aux := counter_rand_one;
						y_aux := counter_rand_two;
						nx_state <= validate;
					ELSE
						nx_state <= waiting;
					END IF;
				ELSE
					nx_state <= waiting;
				END IF;
			WHEN validate =>
				ena_score <= '0';
				IF(alive='0') THEN
					nx_state <= save_food;
				ELSE
					nx_state <= waiting;
				END IF;
			WHEN save_food =>
				ena_save <= '1';
				save_value_x <= x_aux;
				save_value_y <= y_aux;
				ena_score <= '1';
				nx_state <= waiting;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;