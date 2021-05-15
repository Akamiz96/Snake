----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY teclado IS
	PORT	(	clk				:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				input1			:	IN		STD_LOGIC;
				input2			:	IN		STD_LOGIC;
				input3			:	IN		STD_LOGIC;
				input4			:	IN		STD_LOGIC;
				column1			:	OUT	STD_LOGIC;
				column2			:	OUT	STD_LOGIC;
				column3			:	OUT	STD_LOGIC;
				column4			:	OUT	STD_LOGIC;
				new_data			:	OUT	STD_LOGIC;
				but_value		:	OUT	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY teclado;
----------------------------------------------------------------
ARCHITECTURE structural OF teclado IS
	SIGNAL deb_in1_s		:	STD_LOGIC;
	SIGNAL deb_in2_s		:	STD_LOGIC;
	SIGNAL deb_in3_s		:	STD_LOGIC;
	SIGNAL deb_in4_s		:	STD_LOGIC;
	SIGNAL max_tick_s		:	STD_LOGIC;
	SIGNAL syn_clr_s		:	STD_LOGIC;
	SIGNAL ena_counter_s	:	STD_LOGIC;
	SIGNAL new_data_s		:	STD_LOGIC;
	SIGNAL min_tick_s		:	STD_LOGIC;
	SIGNAL clk_10			:	STD_LOGIC;
	SIGNAL counter_s		:	STD_LOGIC_VECTOR(16 DOWNTO 0);
	SIGNAL but_value_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL q_s				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN

--	pll: ENTITY work.pll_test
--	PORT MAP ( 	inclk0		=> clk,
--					c0				=> clk_10);
	clk_10 <= clk;
	
	new_data <= new_data_s;
	but_value <= q_s;
	
	DB1: ENTITY work.debouncer
		  PORT MAP(  	clk			=> clk_10,
							rst			=> rst,
							sw				=> input1,
							deb_sw		=> deb_in1_s);	
							
	DB2: ENTITY work.debouncer
		  PORT MAP(  	clk			=> clk_10,
							rst			=> rst,
							sw				=> input2,
							deb_sw		=> deb_in2_s);
							
	DB3: ENTITY work.debouncer
		  PORT MAP(  	clk			=> clk_10,
							rst			=> rst,
							sw				=> input3,
							deb_sw		=> deb_in3_s);
							
	DB4: ENTITY work.debouncer
		  PORT MAP(  	clk			=> clk_10,
							rst			=> rst,
							sw				=> input4,
							deb_sw		=> deb_in4_s);
								
	COL: 		ENTITY work.columns_controller
				PORT MAP(  	clk => clk_10,
								rst => rst,
								max_tick => max_tick_s,
								inp1 => deb_in1_s,
								inp2 => deb_in2_s,
								inp3 => deb_in3_s,
								inp4 => deb_in4_s,
								ena_counter	 => ena_counter_s,
								syn_clr => syn_clr_s,
								col_1 => column1,
								col_2 => column2,
								col_3 => column3,
								col_4 => column4,
								new_data	 => new_data_s,
								but_value => but_value_s);
								
								
	TMR: 		ENTITY work.timer10ms
				PORT MAP(  	clk	=> clk_10,
								rst	=> rst,
								ena	=> ena_counter_s, 
								syn_clr	=> syn_clr_s,
								max_tick	=> max_tick_s,
								min_tick	=> min_tick_s,
								counter	=> counter_s);
								
	DFF: 		ENTITY work.my_dff
				PORT MAP(  	clk	=> clk_10,
								rst	=> rst,
								ena	=> new_data_s, 
								d		=> but_value_s,
								q		=> q_s);


END ARCHITECTURE structural;