----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY columns_controller IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				max_tick			:	IN		STD_LOGIC;
				inp1				: 	IN 	STD_LOGIC;
				inp2				: 	IN 	STD_LOGIC;
				inp3				: 	IN 	STD_LOGIC;
				inp4				: 	IN 	STD_LOGIC;
				ena_counter		:	OUT	STD_LOGIC;
				syn_clr			:	OUT	STD_LOGIC;
				col_1				:	OUT	STD_LOGIC;
				col_2				:	OUT	STD_LOGIC;
				col_3				:	OUT	STD_LOGIC;
				col_4				:	OUT	STD_LOGIC;
				new_data			:	OUT 	STD_LOGIC;
				but_value		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY columns_controller;
----------------------------------------------------------------
ARCHITECTURE fsm OF columns_controller IS
	TYPE state IS (col1, col2, col3, col4,wait_col1,wait_col2,wait_col3,wait_col4);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk,rst)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	col1;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state, max_tick, inp1, inp2, inp3, inp4)
	BEGIN
		CASE pr_state IS
			WHEN col1	=>
				col_1 <= '0';
				col_2 <= '1';
				col_3 <= '1';
				col_4 <= '1';
				ena_counter <= '1';
				
				syn_clr <= '0';
				new_data <= '0';
				but_value <= "0000";
				IF (inp1 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '1';
					but_value(1) <= '0';
					but_value(0) <= '0';
					nx_state <= wait_col1;
				END IF;
				IF (inp2 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '1';
					but_value(1) <= '0';
					but_value(0) <= '1';
					nx_state <= wait_col1;
				END IF;
				IF (inp3 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '1';
					but_value(1) <= '1';
					but_value(0) <= '0';
					nx_state <= wait_col1;
				END IF;
				IF (inp4 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '1';
					but_value(1) <= '1';
					but_value(0) <= '1';
					nx_state <= wait_col1;
				END IF;
				IF (max_tick = '0') THEN 
					nx_state <= col1;
				ELSE
					nx_state <= wait_col1;
					IF (inp1 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '1';
						but_value(1) <= '0';
						but_value(0) <= '0';
					END IF;
					IF (inp2 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '1';
						but_value(1) <= '0';
						but_value(0) <= '1';
					END IF;
					IF (inp3 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '1';
						but_value(1) <= '1';
						but_value(0) <= '0';
					END IF;
					IF (inp4 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '1';
						but_value(1) <= '1';
						but_value(0) <= '1';
					END IF;
				END IF;
			WHEN wait_col1 =>
				nx_state <= col2;
				syn_clr <= '1';
			WHEN col2	=>
				col_1 <= '1';
				col_2 <= '0';
				col_3 <= '1';
				col_4 <= '1';
				ena_counter <= '1';
				
				syn_clr <= '0';
				new_data <= '0';
				but_value <= "0000";
				IF (inp1 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '0';
					but_value(1) <= '0';
					but_value(0) <= '0';
					nx_state <= wait_col2;
				END IF;
				IF (inp2 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '0';
					but_value(1) <= '0';
					but_value(0) <= '1';
					nx_state <= wait_col2;
				END IF;
				IF (inp3 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '0';
					but_value(1) <= '1';
					but_value(0) <= '0';
					nx_state <= wait_col2;
				END IF;
				IF (inp4 = '1') THEN
					new_data <= '1';
					but_value(3) <= '1';
					but_value(2) <= '0';
					but_value(1) <= '1';
					but_value(0) <= '1';
					nx_state <= wait_col2;
				END IF;
				IF (max_tick = '0') THEN 
					nx_state <= col2;
				ELSE
					nx_state <= wait_col2;
					IF (inp1 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '0';
						but_value(1) <= '0';
						but_value(0) <= '0';
					END IF;
					IF (inp2 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '0';
						but_value(1) <= '0';
						but_value(0) <= '1';
					END IF;
					IF (inp3 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '0';
						but_value(1) <= '1';
						but_value(0) <= '0';
					END IF;
					IF (inp4 = '1') THEN
						new_data <= '1';
						but_value(3) <= '1';
						but_value(2) <= '0';
						but_value(1) <= '1';
						but_value(0) <= '1';
					END IF;
				END IF;
			WHEN wait_col2 =>
				nx_state <= col3;
				syn_clr <= '1';
			WHEN col3	=>
				col_1 <= '1';
				col_2 <= '1';
				col_3 <= '0';
				col_4 <= '1';
				ena_counter <= '1';
				
				syn_clr <= '0';
				new_data <= '0';
				but_value <= "0000";
				IF (inp1 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '1';
					but_value(1) <= '0';
					but_value(0) <= '0';
					nx_state <= wait_col3;
				END IF;
				IF (inp2 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '1';
					but_value(1) <= '0';
					but_value(0) <= '1';
					nx_state <= wait_col3;
				END IF;
				IF (inp3 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '1';
					but_value(1) <= '1';
					but_value(0) <= '0';
					nx_state <= wait_col3;
				END IF;
				IF (inp4 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '1';
					but_value(1) <= '1';
					but_value(0) <= '1';
					nx_state <= wait_col3;
				END IF;
				IF (max_tick = '0') THEN 
					nx_state <= col3;
				ELSE
					nx_state <= wait_col3;
					IF (inp1 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '1';
						but_value(1) <= '0';
						but_value(0) <= '0';
					END IF;
					IF (inp2 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '1';
						but_value(1) <= '0';
						but_value(0) <= '1';
					END IF;
					IF (inp3 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '1';
						but_value(1) <= '1';
						but_value(0) <= '0';
					END IF;
					IF (inp4 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '1';
						but_value(1) <= '1';
						but_value(0) <= '1';
					END IF;
				END IF;
			WHEN wait_col3 =>
				nx_state <= col4;
				syn_clr <= '1';
			WHEN col4	=>
				col_1 <= '1';
				col_2 <= '1';
				col_3 <= '1';
				col_4 <= '0';
				ena_counter <= '1';
				
				syn_clr <= '0';
				new_data <= '0';
				but_value <= "0000";
				IF (inp1 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '0';
					but_value(1) <= '0';
					but_value(0) <= '0';
					nx_state <= wait_col4;
				END IF;
				IF (inp2 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '0';
					but_value(1) <= '0';
					but_value(0) <= '1';
					nx_state <= wait_col4;
				END IF;
				IF (inp3 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '0';
					but_value(1) <= '1';
					but_value(0) <= '0';
					nx_state <= wait_col4;
				END IF;
				IF (inp4 = '1') THEN
					new_data <= '1';
					but_value(3) <= '0';
					but_value(2) <= '0';
					but_value(1) <= '1';
					but_value(0) <= '1';
					nx_state <= wait_col4;
				END IF;
				IF (max_tick = '0') THEN 
					nx_state <= col4;
				ELSE
					nx_state <= wait_col4;
					IF (inp1 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '0';
						but_value(1) <= '0';
						but_value(0) <= '0';
					END IF;
					IF (inp2 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '0';
						but_value(1) <= '0';
						but_value(0) <= '1';
					END IF;
					IF (inp3 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '0';
						but_value(1) <= '1';
						but_value(0) <= '0';
					END IF;
					IF (inp4 = '1') THEN
						new_data <= '1';
						but_value(3) <= '0';
						but_value(2) <= '0';
						but_value(1) <= '1';
						but_value(0) <= '1';
					END IF;
				END IF;
			WHEN wait_col4 =>
				nx_state <= col1;
				syn_clr <= '1';
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;