---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY snake IS
	GENERIC (N				      :	INTEGER	:=	9;
				DATA_WIDTH			: 	INTEGER	:=	119;
				ADDR_WIDTH			:  INTEGER	:=	79;
				DATA_WIDTH2			:	INTEGER	:=	13);
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				max_tick				:  IN 	STD_LOGIC;
				buttonUp, buttonDown, buttonLeft, buttonRight : IN STD_LOGIC;
				pintar_x				: 	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				pintar_y				: 	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_x				: 	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_y 				:  IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				comida 				:  OUT 	STD_LOGIC;
				dato_pintar			:  OUT 	STD_LOGIC;
				dato_comida			:  OUT 	STD_LOGIC
				
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
	SIGNAL comida_sig	 : STD_LOGIC;
	

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
	GENERIC MAP(N			 =>   N);
	PORT MAP(clk			 =>   clk,
				rst			 =>	rst,	
				max_tick		 => 	max_tick,	
				selX			 =>	selector_x,
				selY			 =>	selector_y,
				food_x		 =>   food_x,
				food_y		 => 	food_y,
				x_in			 =>   head_x,	
				y_in			 =>   head_y,	
				x_out			 =>	x_signal,	
				y_out	       =>	y_signal,
				comida		 => 	comida_sig);
	
	mem : ENTITY work.memoria_snake
	GENERIC MAP(DATA_WIDTH  =>   DATA_WIDTH,
				   ADDR_WIDTH  =>	  ADDR_WIDTH);
	PORT MAP( clk			 =>	clk,				
				 rst			 =>	rst,			
				 max_tick	 =>	max_tick,		
				 x_in 		 =>	x_signal,			
				 y_in 		 =>	y_signal,		
				 comida		 =>	comida,						
				 data_in		 =>   data_rd,	
				 dato_x		 =>	pintar_x,		
				 dato_y		 =>	pintar_y,	
				 food_x		 =>	food_x,
				 food_y      =>	food_y,
				 rd			 =>	rd_signal,			
				 wr			 =>	wr_signal,
				 cabeza_x	 => 	head_x,
				 cabeza_y	 =>   head_y,
				 data_out	 =>   data_wr,
				 dato_pintar => 	dato_pintar,
				 dato_comida =>   dato_comida);
	
	memCir : ENTITY work.circular
	GENERIC MAP(DATA_WIDTH => DATA_WIDTH2,
				   ADDR_WIDTH => DATA_WIDTH2);
	PORT MAP( clk			 =>	clk,	
				 rst			 =>	rst,
				 rd		    =>   rd_signal,	
				 wr			 =>   wr_signal,
				 w_data		 =>	data_wr,
				 r_data		 =>	data_rd
				 full			 =>	ef,
				 empty       =>	ef);
	
	
END ARCHITECTURE structural;