 ----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY conv_control IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				new_data			: 	IN 	STD_LOGIC;
				but_value		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				buttonUp, buttonDown, buttonLeft, buttonRight : OUT STD_LOGIC
	);
END ENTITY conv_control;
----------------------------------------------------------------
ARCHITECTURE fsm OF conv_control IS
	TYPE state IS (waiting,arriba,abajo,izquierda,derecha);
	SIGNAL pr_state, nx_state	:	state;
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
	combinational: PROCESS(pr_state, but_value, new_data)
	BEGIN
		CASE pr_state IS
			WHEN waiting =>
				buttonUp <= '1';
				buttonDown <= '0';
				buttonLeft <= '0';
				buttonRight <= '0';
				IF (new_data='1') THEN
					IF (but_value = "1000") THEN
						nx_state <= arriba;
					ELSIF (but_value = "1010") THEN
						nx_state <= abajo;
					ELSIF (but_value = "1101") THEN
						nx_state <= izquierda;
					ELSIF (but_value = "0101") THEN
						nx_state <= derecha;
					ELSE	
						nx_state <= waiting;
					END IF;
				ELSE
					nx_state <= waiting;
				END IF;
			WHEN arriba =>
				buttonUp <= '1';
				buttonDown <= '0';
				buttonLeft <= '0';
				buttonRight <= '0';
				IF (new_data='1') THEN
					IF (but_value = "1000") THEN
						nx_state <= arriba;
					ELSIF (but_value = "1010") THEN
						nx_state <= abajo;
					ELSIF (but_value = "1101") THEN
						nx_state <= izquierda;
					ELSIF (but_value = "0101") THEN
						nx_state <= derecha;
					ELSE	
						nx_state <= arriba;
					END IF;
				ELSE 
					nx_state <= arriba;
				END IF;
			WHEN abajo =>
				buttonUp <= '0';
				buttonDown <= '1';
				buttonLeft <= '0';
				buttonRight <= '0';
				IF (new_data='1') THEN
					IF (but_value = "1000") THEN
						nx_state <= arriba;
					ELSIF (but_value = "1010") THEN
						nx_state <= abajo;
					ELSIF (but_value = "1101") THEN
						nx_state <= izquierda;
					ELSIF (but_value = "0101") THEN
						nx_state <= derecha;
					ELSE	
						nx_state <= abajo;
					END IF;
				ELSE 
					nx_state <= abajo;
				END IF;
			WHEN izquierda =>
				buttonUp <= '0';
				buttonDown <= '0';
				buttonLeft <= '1';
				buttonRight <= '0';
				IF (new_data='1') THEN
					IF (but_value = "1000") THEN
						nx_state <= arriba;
					ELSIF (but_value = "1010") THEN
						nx_state <= abajo;
					ELSIF (but_value = "1101") THEN
						nx_state <= izquierda;
					ELSIF (but_value = "0101") THEN
						nx_state <= derecha;
					ELSE	
						nx_state <= izquierda;
					END IF;
				ELSE 
					nx_state <= izquierda;
				END IF;
			WHEN derecha =>
				buttonUp <= '0';
				buttonDown <= '0';
				buttonLeft <= '0';
				buttonRight <= '1';
				IF (new_data='1') THEN
					IF (but_value = "1000") THEN
						nx_state <= arriba;
					ELSIF (but_value = "1010") THEN
						nx_state <= abajo;
					ELSIF (but_value = "1101") THEN
						nx_state <= izquierda;
					ELSIF (but_value = "0101") THEN
						nx_state <= derecha;
					ELSE	
						nx_state <= derecha;
					END IF;
				ELSE 
					nx_state <= derecha;
				END IF;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;