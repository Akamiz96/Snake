 ----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY game_fsm IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				new_data			: 	IN 	STD_LOGIC;
				but_value		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				buttonUp, buttonDown, buttonLeft, buttonRight : OUT STD_LOGIC
	);
END ENTITY game_fsm;
----------------------------------------------------------------
ARCHITECTURE fsm OF game_fsm IS
	TYPE state IS (generar_comida,playing,score);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	generar_comida;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state, but_value, new_data)
	BEGIN
		CASE pr_state IS
			WHEN generar_comida =>
				--Mirar si la comida esta bien puesta
				IF(comida='1') THEN
					nx_state <= generar_comida;
				ELSE 
					nx_state <= playing;
				END IF;
			WHEN playing =>
				IF(comer='1') THEN 
					nx_state <= score;
				ELSE 
					nx_state <= playing;
				END IF;
			WHEN score =>
				
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;