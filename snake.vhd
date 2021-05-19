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
	SIGNAL x_signal    : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL y_signal    : STD_LOGIC_VECTOR(1 DOWNTO 0);

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
	PORT MAP(clk			 =>   clk,
				rst			 =>	rst,	
				max_tick		 => 	max_tick,	
				selX			 =>	selector_x,
				selY			 =>	selector_y,
				x_in			 =>,	
				y_in			 =>,	
				x_out			 =>	x_signal,	
				y_out	       =>	y_signal,);
	
	mem : ENTITY work.memoria_snake
	PORT MAP( clk			 =>	clk,				
				 rst			 =>	rst,			
				 max_tick	 =>	max_tick,		
				 x_in 		 =>	x_signal,			
				 y_in 		 =>	y_signal,		
				 comida		 =>	comida,				
				 rd			 =>,			
				 wr			 =>,			
				 data_in		 =>,		
				 data_out	 =>);
	
	
END ARCHITECTURE structural;