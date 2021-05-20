-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY snake IS
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				max_tick				:  IN 	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC;
				comida				:  IN 	STD_LOGIC;
				
	);
END ENTITY snake;
ARCHITECTURE structural OF snake IS
	SIGNAL selector_x  : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL selector_y  : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL x_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL y_signal    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_x      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL head_y      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL data_wr		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL data_rd		 : STD_LOGIC_VECTOR(13 DOWNTO 0);
	SIGNAL rd_signal   : STD_LOGIC;
	SIGNAL wr_signal   : STD_LOGIC;
	SIGNAL ef			 : STD_LOGIC;
	

 BEGIN 
	
	fsm : ENTITY work.snake_controller
	PORT MAP(clk		    =>	clk,	
				rst			 =>	rst,
				max_tick		 =>	max_tick,
				buttonUp     =>   buttonUp,
				buttonDown   =>   buttonDown,
				buttonLeft   =>   buttonLeft,
				buttonRight  =>   buttonRight,
				selX			 =>	selector_x,
				selY	       =>   selector_y);
	
	mov : ENTITY work.movimiento
	GENERIC MAP(N			 =>   9);
	PORT MAP(clk			 =>   clk,
				rst			 =>	rst,	
				max_tick		 => 	max_tick,	
				selX			 =>	selector_x,
				selY			 =>	selector_y,
				x_in			 =>   head_x,	
				y_in			 =>   head_y,	
				x_out			 =>	x_signal,	
				y_out	       =>	y_signal,);
	
	mem : ENTITY work.memoria_snake
	GENERIC MAP(DATA_WIDTH  =>   119
				   ADDR_WIDTH  =>	   79);
	PORT MAP( clk			 =>	clk,				
				 rst			 =>	rst,			
				 max_tick	 =>	max_tick,		
				 x_in 		 =>	x_signal,			
				 y_in 		 =>	y_signal,		
				 comida		 =>	comida,						
				 data_in		 =>   data_rd,		
				 rd			 =>	rd_signal,			
				 wr			 =>	wr_signal,
				 cabeza_x	 => 	head_x,
				 cabeza_y	 =>   head_y,
				 data_out	 =>   data_wr);
	
	memCir : ENTITY work.circular
	GENERIC MAP(DATA_WIDTH => 13;
				   ADDR_WIDTH => 13);
	PORT MAP( clk			 =>	clk,	
				 rst			 =>	rst,
				 rd		    =>   rd_signal,	
				 wr			 =>   wr_signal,
				 w_data		 =>	data_wr,
				 r_data		 =>	data_rd
				 full			 =>	ef,
				 empty       =>	ef);
	
	
END ARCHITECTURE structural;