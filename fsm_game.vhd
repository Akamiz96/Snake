LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY fsm_game IS
	GENERIC (DATA_WIDTH			: 	INTEGER	:=	12;
				ADDR_WIDTH			:  INTEGER	:=	12);
	PORT	(	clk					:	IN 	STD_LOGIC;
				rst					:	IN		STD_LOGIC;
				max_tick_tmr :	IN		STD_LOGIC;
				clear_score:	OUT		STD_LOGIC;
				ena_score:	OUT		STD_LOGIC;
				choque:	OUT		STD_LOGIC;
				obstacle :	IN		STD_LOGIC;
				stop :	IN		STD_LOGIC);
				
END ENTITY fsm_game;
----------------------------------------------------------------
ARCHITECTURE fsm OF fsm_game IS
	TYPE state IS (inicio, juego, sumar, fin,stop_st);
	SIGNAL pr_state, nx_state	: state;
	SIGNAL previous_mov	: state;

 
BEGIN
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
	combinational: PROCESS(pr_state,max_tick_tmr,stop,obstacle)
	BEGIN
		CASE pr_state IS
			WHEN inicio => 
				clear_score <= '1';
				ena_score <= '0';
				choque <= '0';
				nx_state <= juego;
			WHEN juego => 
				clear_score <= '0';
				ena_score <= '0';
				choque <= '0';
				IF(max_tick_tmr = '1') THEN 
					nx_state <= sumar;
				ELSIF (obstacle = '1') THEN 
					nx_state <= fin;
				ELSIF( stop = '1') THEN 
					nx_state <= stop_st;
				ELSE
					nx_state <= juego;
				END IF;
			WHEN sumar => 
				clear_score <= '0';
				ena_score <= '1';
				nx_state <= juego;
			WHEN fin => 
				clear_score <= '0';
				ena_score <= '0';
				choque <= '1';
				nx_state <= fin;
			WHEN stop_st => 
				clear_score <= '0';
				ena_score <= '0';
				choque <= '0';
				IF (stop = '1') THEN 
					nx_state <= stop_st;
				ELSE
					nx_state <= juego;	
				END IF;
		END CASE;
	END PROCESS combinational;
END ARCHITECTURE fsm;