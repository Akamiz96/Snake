----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY fsm_snake_food IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				counter_rand_one		:	IN 	STD_LOGIC_VECTOR(N_rand_one-1 DOWNTO 0);
				counter_rand_two		:	IN 	STD_LOGIC_VECTOR(N_rand_two-1 DOWNTO 0);


				new_data			: 	IN 	STD_LOGIC;
				but_value		:	IN		STD_LOGIC_VECTOR(3 DOWNTO 0);
				ena				: 	OUT	STD_LOGIC;
				x_add				: 	OUT	STD_LOGIC;
				x_sub				: 	OUT	STD_LOGIC;
				y_add				: 	OUT	STD_LOGIC;
				y_sub				: 	OUT	STD_LOGIC
	);
END ENTITY fsm_snake_food;
----------------------------------------------------------------
ARCHITECTURE fsm OF fsm_snake_food IS
	TYPE state IS (waiting,add_x,sub_x,add_y,sub_y,newdata,waiting_down);
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
				x_add <= '0';
				x_sub <= '0';
				y_add <= '0';
				y_sub <= '0';
				ena 	<= '0';
				IF (new_data='1') THEN
					nx_state <= newdata;
				ELSE 
					nx_state <= waiting;
				END IF;
			WHEN newdata =>
				IF (but_value = "1000") THEN
					nx_state <= add_y;
				ELSIF (but_value = "1010") THEN
					nx_state <= sub_y;
				ELSIF (but_value = "1101") THEN
					nx_state <= sub_x;
				ELSIF (but_value = "0101") THEN
					nx_state <= add_x;
				ELSE 
					nx_state <= waiting_down;
				END IF;
			WHEN add_x => 
				x_add <= '1';
				x_sub <= '0';
				y_add <= '0';
				y_sub <= '0';
				ena 	<= '1';
				nx_state <= waiting_down;
			WHEN add_y => 
				x_add <= '0';
				x_sub <= '0';
				y_add <= '1';
				y_sub <= '0';
				ena 	<= '1';
				nx_state <= waiting_down;
			WHEN sub_x => 
				x_add <= '0';
				x_sub <= '1';
				y_add <= '0';
				y_sub <= '0';
				ena 	<= '1';
				nx_state <= waiting_down;
			WHEN sub_y => 
				x_add <= '0';
				x_sub <= '0';
				y_add <= '0';
				y_sub <= '1';
				ena 	<= '1';
				nx_state <= waiting_down;
			WHEN waiting_down =>
				x_add <= '0';
				x_sub <= '0';
				y_add <= '0';
				y_sub <= '0';
				ena 	<= '0';
				IF (new_data='1') THEN
					nx_state <= waiting_down;
				ELSE	
					nx_state <= waiting;
				END IF;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;