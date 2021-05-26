---------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY snake_screen IS
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				input1			:	IN		STD_LOGIC;
				input2			:	IN		STD_LOGIC;
				input3			:	IN		STD_LOGIC;
				input4			:	IN		STD_LOGIC;
				column1			:	OUT	STD_LOGIC;
				column2			:	OUT	STD_LOGIC;
				column3			:	OUT	STD_LOGIC;
				column4			:	OUT	STD_LOGIC;			
				VGA_HS 						:  OUT STD_LOGIC;
				VGA_VS 						:	OUT STD_LOGIC;
				VGA_R, VGA_G, VGA_B 		: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				enter 		:  IN 	STD_LOGIC_VECTOR(3 downto 0)
	);
END ENTITY snake_screen;
ARCHITECTURE structural OF snake_screen IS
	
	SIGNAL new_data_s		:	STD_LOGIC;
	SIGNAL but_value_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL max_tick_s	:	STD_LOGIC;
	SIGNAL ena_tb			:	STD_LOGIC := '1';
	SIGNAL syn_tb			:	STD_LOGIC := '0';
	SIGNAL min_tickRY_s	:	STD_LOGIC;
	SIGNAL counterRY_s	:	STD_LOGIC_VECTOR(16 DOWNTO 0);
	
	SIGNAL buttonUp_s	:	STD_LOGIC;
	SIGNAL buttonDown_s	:	STD_LOGIC;
	SIGNAL buttonLeft_s	:	STD_LOGIC;
	SIGNAL buttonRight_s	:	STD_LOGIC;
	
	SIGNAL pintar_x_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL pintar_y_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL food_x_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL food_y_s	:	STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	SIGNAL comida_s	:	STD_LOGIC;
	SIGNAL dato_pintar_s	:	STD_LOGIC;
	SIGNAL dato_comida_s	:	STD_LOGIC;
	
	SIGNAL mem_unidades_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_decenas_s				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_centenas_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_unidades_miles_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);

 BEGIN 
	
	snake : ENTITY work.snake
	PORT MAP(clk		    	=>	clk,	
				rst			 	=>	rst,
				max_tick			=> max_tick_s,
				buttonUp     	=> buttonUp_s,
				buttonDown   	=> buttonDown_s,
				buttonLeft   	=> buttonLeft_s,
				buttonRight  	=> buttonRight_s,
				pintar_x			=>	pintar_x_s,
				pintar_y	      => pintar_y_s,
				food_x			=> food_x_s,
				food_y			=> food_y_s,
				comida			=> comida_s,
				dato_pintar		=> dato_pintar_s,
				dato_comida		=> dato_comida_s);
				
	CONV: ENTITY work.conv_control
	PORT MAP(		clk 			=> clk,
						rst 			=> rst,
						new_data		=> new_data_s,
						but_value	=> but_value_s,
						max_tick		=> max_tick_s,
						buttonUp		=> buttonUp_s,
						buttonDown	=> buttonDown_s,
						buttonLeft	=> buttonLeft_s,
						buttonRight	=> buttonRight_s);
						
	TECL : ENTITY work.teclado
	PORT MAP(clk 			=> clk,
				rst			=>	rst,
				input1		=> input1,
				input2		=> input2,
				input3		=> input3,
				input4		=> input4,
				column1		=> column1,
				column2		=> column2,
				column3		=> column3,
				column4		=> column4,
				new_data		=> new_data_s,
				but_value	=> but_value_s);
	
	VGA : ENTITY work.prueba_VGA
	PORT MAP(clk 			=> clk,
				rst			=>	rst,
				VGA_HS 		=> VGA_HS,
				VGA_VS 		=> VGA_VS,
				VGA_R 		=> VGA_R,
				VGA_G 		=> VGA_G,
				VGA_B  		=> VGA_B,
				enter 		=> enter);
				
	TMR: 		ENTITY work.timer_mov
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								ena	=> ena_tb, 
								syn_clr	=> syn_tb,
								max_tick	=> max_tick_s,
								min_tick	=> min_tickRY_s,
								counter	=> counterRY_s);
	
	FOOD: 	ENTITY work.FOOD
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								start=> '1',
								alive=>dato_comida_s,
								ena_food=>comida_s,
								food_x=>food_x_s,
								food_y=>food_y_s,
								mem_unidades=>mem_unidades_s,
								mem_decenas=>mem_decenas_s,
								mem_centenas=>mem_centenas_s,
								mem_unidades_miles=>mem_unidades_miles_s);
	
END ARCHITECTURE structural;