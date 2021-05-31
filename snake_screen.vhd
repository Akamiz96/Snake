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
				stop				: 	IN 	STD_LOGIC;
				column1			:	OUT	STD_LOGIC;
				column2			:	OUT	STD_LOGIC;
				column3			:	OUT	STD_LOGIC;
				column4			:	OUT	STD_LOGIC;			
				VGA_HS 						:  OUT STD_LOGIC;
				VGA_VS 						:	OUT STD_LOGIC;
				VGA_R, VGA_G, VGA_B 		: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				selector_tablero 		:  IN 	STD_LOGIC_VECTOR(1 downto 0)
	);
END ENTITY snake_screen;
ARCHITECTURE structural OF snake_screen IS

	SIGNAL pos_x_tablero_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_y_tablero_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL tablero_snake_s		:	STD_LOGIC;
	
	SIGNAL pintar_x_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL pintar_y_s				:  STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL we_s						:	STD_LOGIC;
	SIGNAL pintar_despintar_s	:	STD_LOGIC;
	
	SIGNAL new_data_s		:	STD_LOGIC;
	SIGNAL but_value_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL buttonUp_s		:	STD_LOGIC;
	SIGNAL buttonDown_s	:	STD_LOGIC;
	SIGNAL buttonLeft_s	:	STD_LOGIC;
	SIGNAL buttonRight_s	:	STD_LOGIC;
	
	
	SIGNAL max_tick_s	:	STD_LOGIC;
	SIGNAL dato_pintar_s	:	STD_LOGIC;
	
	SIGNAL mem_unidades_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_decenas_s				:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_centenas_s			:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL mem_unidades_miles_s	:	STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL ena_save_s:	STD_LOGIC;
	SIGNAL obstacle:	STD_LOGIC;
	
	SIGNAL cambio_tablero:	STD_LOGIC;
	SIGNAL rst_cambio_tablero:	STD_LOGIC;
	
	-----------------

 BEGIN 
 
	PROCESS(clk,selector_tablero)
	VARIABLE selector_tablero_anterior : STD_LOGIC_VECTOR(1 downto 0) := "00";
	BEGIN
		IF (rising_edge(clk)) THEN
			IF(selector_tablero /= selector_tablero_anterior) THEN
				cambio_tablero <= '1';
				selector_tablero_anterior := selector_tablero;
			ELSE
				cambio_tablero <= '0';
			END IF;
		END IF;
	END PROCESS;
	
	rst_cambio_tablero <= rst OR cambio_tablero;
	
	VGA : ENTITY work.prueba_VGA
	PORT MAP(clk 				=> clk,
				rst				=>	rst,
				VGA_HS 			=> VGA_HS,
				VGA_VS 			=> VGA_VS,
				VGA_R 			=> VGA_R,
				VGA_G 			=> VGA_G,
				VGA_B  			=> VGA_B,
				unidades 		=> mem_unidades_s,
				decenas 			=> mem_decenas_s,
				centenas 		=> mem_centenas_s,
				miles 			=> mem_unidades_miles_s,
				decenas_miles 	=> "0000",
				pos_x_tablero 	=> pos_x_tablero_s,
				pos_y_tablero 	=> pos_y_tablero_s,
				tablero_snake 	=> tablero_snake_s,
				selector_tablero	=> selector_tablero);
				
	MEM_SNAKE : ENTITY work.memoria_snake
	PORT MAP( clk			 		=>	clk,				
				 rst			 		=>	rst_cambio_tablero,			
				 pintar_x	 		=>	pintar_x_s,		
				 pintar_y 			=>	pintar_y_s,			
				 pantalla_x 		=>	pos_x_tablero_s,		
				 pantalla_y			=>	pos_y_tablero_s,								
				 we		 			=>	we_s,
				 pintar_despintar => pintar_despintar_s,
				 pantalla_dato		=>	tablero_snake_s);
						
	TECL : ENTITY work.teclado
	PORT MAP(clk 			=> clk,
				rst			=>	rst_cambio_tablero,
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
				
	CONV: ENTITY work.conv_control
	PORT MAP(		clk 			=> clk,
						rst 			=> rst_cambio_tablero,
						new_data		=> new_data_s,
						but_value	=> but_value_s,
						buttonUp		=> buttonUp_s,
						buttonDown	=> buttonDown_s,
						buttonLeft	=> buttonLeft_s,
						buttonRight	=> buttonRight_s);

	snake : ENTITY work.snake
	PORT MAP(clk		    	=>	clk,	
				rst			 	=>	rst_cambio_tablero,
				stop				=> stop,
				pintar_x	 		=>	pintar_x_s,		
				pintar_y 		=>	pintar_y_s,
				we		 			=>	we_s,
				pintar_despintar => pintar_despintar_s,
				buttonUp     	=> buttonUp_s,
				buttonDown   	=> buttonDown_s,
				buttonLeft   	=> buttonLeft_s,
				buttonRight  	=> buttonRight_s,
				mem_unidades=>mem_unidades_s,
				mem_decenas=>mem_decenas_s,
				mem_centenas=>mem_centenas_s,
				mem_unidades_miles=>mem_unidades_miles_s,
				selector_tablero	=> selector_tablero);
				
END ARCHITECTURE structural;