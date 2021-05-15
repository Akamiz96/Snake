----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY debouncer_controller IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				sw					:	IN		STD_LOGIC;
				max_tick			:	IN		STD_LOGIC;
				ena_counter		:	OUT	STD_LOGIC;
				syn_clr			:	OUT	STD_LOGIC;
				deb_sw			:	OUT	STD_LOGIC
	);
END ENTITY debouncer_controller;
----------------------------------------------------------------
ARCHITECTURE fsm OF debouncer_controller IS
	TYPE state IS (zero, wait1_1, wait1_2, wait1_3,wait1_4,wait1_5, wait0_1,wait0_2,wait0_3,wait0_4,wait0_5,one_out, one);
	SIGNAL pr_state, nx_state	:	state;
BEGIN
	-------------------------------------------------------------
	--                 LOWER SECTION OF FSM                    --
	-------------------------------------------------------------
	sequential: PROCESS(clk)
	BEGIN
		IF (rst = '1') THEN
			pr_state	<=	zero;
		ELSIF (rising_edge(clk)) THEN
			pr_state	<=	nx_state;
		END IF;
	END PROCESS sequential;
	
	-------------------------------------------------------------
	--                 UPPER SECTION OF FSM                    --
	-------------------------------------------------------------
	combinational: PROCESS(pr_state, sw, max_tick)
	BEGIN
		CASE pr_state IS
			WHEN zero	=>
				deb_sw <= '0';
				ena_counter <= '0';
				syn_clr <= '1';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSE
					nx_state <= wait1_1;
				END IF;
			WHEN wait1_1	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait1_2;
				ELSE
					nx_state <= wait1_1;
				END IF;
			WHEN wait1_2	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait1_3;
				ELSE
					nx_state <= wait1_2;
				END IF;
			WHEN wait1_3	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait1_4;
				ELSE
					nx_state <= wait1_3;
				END IF;
			WHEN wait1_4	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait1_5;
				ELSE
					nx_state <= wait1_4;
				END IF;
			WHEN wait1_5	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '0') THEN 
					nx_state <= zero;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= one;
				ELSE
					nx_state <= wait1_5;
				END IF;
------------------------------------------------
			WHEN one	=>
				deb_sw <= '0';
				ena_counter <= '0';
				syn_clr <= '1';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSE
					nx_state <= wait0_1;
				END IF;
			WHEN wait0_1	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait0_2;
				ELSE
					nx_state <= wait0_1;
				END IF;
			WHEN wait0_2	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait0_3;
				ELSE
					nx_state <= wait0_2;
				END IF;
			WHEN wait0_3	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= one_out;
				ELSE
					nx_state <= wait0_3;
				END IF;
			WHEN wait0_4	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= wait0_5;
				ELSE
					nx_state <= wait0_4;
				END IF;
			WHEN wait0_5	=>
				deb_sw <= '0';
				ena_counter <= '1';
				syn_clr <= '0';
				IF (sw = '1') THEN 
					nx_state <= one;
				ELSIF (max_tick = '1') THEN 
					syn_clr <= '1';
					nx_state <= one_out;
				ELSE
					nx_state <= wait0_5;
				END IF;
---------------------------------------------
			WHEN one_out	=>
				deb_sw <= '1';
				ena_counter <= '0';
				syn_clr <= '1'; 
				nx_state <= zero;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;