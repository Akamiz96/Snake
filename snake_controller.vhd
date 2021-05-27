LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY snake_controller IS
	PORT	(	clk					:	IN 	STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				stop					: 	IN 	STD_LOGIC;
				pintar_x				:  OUT 	STD_LOGIC_VECTOR(5 DOWNTO 0);
				pintar_y				:  OUT  	STD_LOGIC_VECTOR(5 DOWNTO 0);
				we						:  OUT  	STD_LOGIC;
				pintar_despintar	: 	OUT	STD_LOGIC;
				ena_timer		:	OUT		STD_LOGIC;
				syn_clr_timer	:	OUT		STD_LOGIC;
				max_tick			:  IN 	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC);
				
END ENTITY snake_controller;
----------------------------------------------------------------
ARCHITECTURE fsm OF snake_controller IS
	TYPE state IS (inicio, espera, pintar, despintar, arriba, abajo, izquierda, derecha,stop_state);
	SIGNAL pr_state, nx_state	: state;
	
	SIGNAL direccion : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL selector_x : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL selector_y : STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	SIGNAL x_signal : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL y_signal : STD_LOGIC_VECTOR(5 DOWNTO 0);
 
BEGIN
	direccion <= (buttonRight & buttonLeft & buttonUp & buttonDown);
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	inicio;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state, max_tick,direccion,stop)
	BEGIN
		CASE pr_state IS
			WHEN inicio =>
				pintar_x <= "111101"; --31 011111
				pintar_y <= "101000"; --20 010100
				we <= '1';
				pintar_despintar <= '1';
				ena_timer <= '0';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "00";
				nx_state <= espera;
			WHEN espera =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '0';
				selector_x <= "00";
				selector_y <= "00";
				IF(max_tick = '1') THEN 
					IF(direccion = "1000") THEN
						nx_state <= derecha;
					ELSIF (direccion = "0100") THEN 
						nx_state <= izquierda;
					ELSIF (direccion = "0010") THEN
						nx_state <= abajo;
					ELSIF (direccion = "0001") THEN 
						nx_state <= arriba;
					ELSE 
						nx_state <= espera;
					END IF;
				ELSE
					IF (stop = '1') THEN 
						nx_state <= stop_state;
					ELSE
						nx_state <= espera;
					END IF;	
				END IF;
			WHEN derecha =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "01";
				selector_y <= "00";
				nx_state <= pintar;
			WHEN izquierda	=>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "10";
				selector_y <= "00";
				nx_state <= pintar;
			WHEN arriba =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "01";
				nx_state <= pintar;
			WHEN abajo =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "10";
				nx_state <= pintar;
			WHEN pintar => 
				pintar_x <= x_signal;
				pintar_y <= y_signal;
				we <= '1';
				pintar_despintar <= '1';
				ena_timer <= '0';
				syn_clr_timer <= '0';
				nx_state <= espera;
			WHEN despintar =>
				pintar_x <= x_signal;
				pintar_y <= y_signal;
				we <= '1';
				pintar_despintar <= '0';
				ena_timer <= '0';
				syn_clr_timer <= '1';
				nx_state <= espera;
			WHEN stop_state =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				IF (stop = '1') THEN 
					nx_state <= stop_state;
				ELSE
					nx_state <= espera;
				END IF;	
		END CASE;
	END PROCESS combinational;
	
--	PROCESS(x,y,food_x, food_y)
--	BEGIN
--		IF (x = food_x AND y = food_y) THEN
--			comida <= '1';
--		ELSE 
--			comida <= '0';
--		END IF;
--	END PROCESS;

	MOV : ENTITY work.movimiento
	PORT MAP(clk			 =>   clk,
				rst			 =>	rst,	
				max_tick		 => 	max_tick,	
				selX			 =>	selector_x,
				selY			 =>	selector_y,	
				x_out			 =>	x_signal,	
				y_out	       =>	y_signal);	
END ARCHITECTURE fsm;