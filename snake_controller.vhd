LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY snake_controller IS
	GENERIC (DATA_WIDTH			: 	INTEGER	:=	12;
				ADDR_WIDTH			:  INTEGER	:=	12);
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
	TYPE state IS (inicio, espera, pintar, despintar, arriba, abajo, izquierda, derecha,stop_state,obtener_cola);
	SIGNAL pr_state, nx_state	: state;
	
	SIGNAL direccion : STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL selector_x : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL selector_y : STD_LOGIC_VECTOR(1 DOWNTO 0);
	
	SIGNAL x_signal : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL y_signal : STD_LOGIC_VECTOR(5 DOWNTO 0);
	
	SIGNAL data_wr		 : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL data_rd		 : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL rd_signal   : STD_LOGIC;
	SIGNAL wr_signal   : STD_LOGIC;
	SIGNAL full_s		 : STD_LOGIC;
	SIGNAL empty_s		 : STD_LOGIC;
	
	SIGNAL pos_despintar		 : STD_LOGIC_VECTOR(11 DOWNTO 0);
	SIGNAL pos_x_despintar		 : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL pos_y_despintar		 : STD_LOGIC_VECTOR(5 DOWNTO 0);
 
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
				pintar_x <= "011111"; --31 011111
				pintar_y <= "010100"; --20 010100
				we <= '1';
				pintar_despintar <= '1';
				ena_timer <= '0';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "00";
				data_wr <= "011111" & "010100"; -- X - Y
				wr_signal <= '1';
				rd_signal <= '0';
				nx_state <= espera;
			WHEN espera =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '0';
				selector_x <= "00";
				selector_y <= "00";
				wr_signal <= '0';
				rd_signal <= '0';
				IF(max_tick = '1') THEN 
					-- Derecha
					IF(direccion = "1000") THEN
						nx_state <= derecha;
					-- Izquierda
					ELSIF (direccion = "0100") THEN 
						nx_state <= izquierda;
					-- Abajo
					ELSIF (direccion = "0010") THEN
						nx_state <= abajo;
					-- Arriba
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
				wr_signal <= '0';
				rd_signal <= '0';
				nx_state <= pintar;
			WHEN izquierda	=>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "10";
				selector_y <= "00";
				wr_signal <= '0';
				rd_signal <= '0';
				nx_state <= pintar;
			WHEN arriba =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "01";
				wr_signal <= '0';
				rd_signal <= '0';
				nx_state <= pintar;
			WHEN abajo =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				selector_x <= "00";
				selector_y <= "10";
				wr_signal <= '0';
				rd_signal <= '0';
				nx_state <= pintar;
			WHEN pintar => 
				pintar_x <= x_signal;
				pintar_y <= y_signal;
				we <= '1';
				pintar_despintar <= '1';
				ena_timer <= '0';
				syn_clr_timer <= '0';
				data_wr <= x_signal & y_signal; -- X - Y
				wr_signal <= '1';
				rd_signal <= '0';
				nx_state <= obtener_cola;
			WHEN obtener_cola => 
				we <= '0';
				pintar_despintar <= '0';
				ena_timer <= '0';
				syn_clr_timer <= '0';
				wr_signal <= '0';
				rd_signal <= '1';
				pos_despintar <= data_rd;
				nx_state <= despintar;
			WHEN despintar =>
				pintar_x <= pos_despintar(11 DOWNTO 6);
				pintar_y <= pos_despintar(5 DOWNTO 0);
				we <= '1';
				pintar_despintar <= '0';
				ena_timer <= '0';
				syn_clr_timer <= '1';
				wr_signal <= '0';
				rd_signal <= '0';
				nx_state <= espera;
			WHEN stop_state =>
				we <= '0';
				ena_timer <= '1';
				syn_clr_timer <= '1';
				wr_signal <= '0';
				rd_signal <= '0';
				IF (stop = '1') THEN 
					nx_state <= stop_state;
				ELSE
					nx_state <= espera;
				END IF;	
		END CASE;
	END PROCESS combinational;

	MOV : ENTITY work.movimiento
	PORT MAP(clk			 =>   clk,
				rst			 =>	rst,	
				max_tick		 => 	max_tick,	
				selX			 =>	selector_x,
				selY			 =>	selector_y,	
				x_out			 =>	x_signal,	
				y_out	       =>	y_signal);	
	
	CIRCULAR : ENTITY work.circular
	GENERIC MAP(DATA_WIDTH => DATA_WIDTH,
				   ADDR_WIDTH => ADDR_WIDTH)
	PORT MAP( clk			 =>	clk,	
				 rst			 =>	rst,
				 rd		    =>   rd_signal,	
				 wr			 =>   wr_signal,
				 w_data		 =>	data_wr,
				 r_data		 =>	data_rd,
				 full			 =>	full_s,
				 empty       =>	empty_s);
				 
END ARCHITECTURE fsm;