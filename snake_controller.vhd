LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY snake_controller IS
	PORT	(	clk				:	IN 	STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				max_tick			:  IN 	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC;
				selX				:  OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				selY				:  OUT 	STD_LOGIC_VECTOR(1 DOWNTO 0));
				
END ENTITY snake_controller;
----------------------------------------------------------------
ARCHITECTURE fsm OF snake_controller IS
	TYPE state IS (arriba, abajo, izquierda, derecha);
	SIGNAL pr_state, nx_state	: state;
	
	SIGNAL direccion : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	
BEGIN
	direccion <= (buttonRight & buttonLeft & buttonUp & buttonDown);
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	derecha;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(direccion, max_tick)
	BEGIN
			
		CASE pr_state IS
			WHEN derecha =>
				IF(max_tick = '1') THEN
					selX <= "01";
					selY <= "11";
					IF(direccion = "0010") THEN
						nx_state <= arriba;
					ELSIF(direccion = "0001") THEN
						nx_state <= abajo;
					ELSE
						nx_state <= derecha;
					END IF;
				ELSE
					--
					nx_state <= derecha;
				END IF;
			WHEN izquierda	=>
				IF(max_tick = '1') THEN
					selX <= "10";
					selY <= "11";
					IF(direccion = "0010") THEN
						nx_state <= arriba;
					ELSIF(direccion = "0001") THEN
						nx_state <= abajo;
					ELSE
						nx_state <= izquierda;
					END IF;
				ELSE
					--
					nx_state <= izquierda;
				END IF;
			WHEN arriba =>
				IF(max_tick = '1') THEN
					selX <= "11";
					selY <= "10";
					IF(direccion = "1000") THEN
						nx_state <= derecha;
					ELSIF(direccion = "0100") THEN
						nx_state <= izquierda;
					ELSE
						nx_state <= arriba;
					END IF;
				ELSE
					--
					nx_state <= arriba;
				END IF;
			WHEN abajo =>
				IF(max_tick = '1') THEN
					selX <= "11";
					selY <= "01";
					IF(direccion = "1000") THEN
						nx_state <= derecha;
					ELSIF(direccion = "0100") THEN
						nx_state <= izquierda;
					ELSE
						nx_state <= abajo;
					END IF;
				ELSE
					--
					nx_state <= abajo;
				END IF;
		END CASE;
	END PROCESS combinational;	
END ARCHITECTURE fsm;