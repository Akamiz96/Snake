-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY prueba_VGA IS
	PORT	(	clk 				:	IN  STD_LOGIC;
				rst 				:	IN  STD_LOGIC;
				VGA_HS 						:  OUT STD_LOGIC;
				VGA_VS 						:	OUT STD_LOGIC;
				VGA_R, VGA_G, VGA_B 		: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				unidades 			:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas 				:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				centenas 			:  IN  	STD_LOGIC_VECTOR(3 downto 0);
				miles 				:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas_miles 		:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				pos_x_tablero		: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_y_tablero		: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				tablero_snake		:	IN		STD_LOGIC;
				food_x			  :	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_y			  :	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				tablero_food		:	IN		STD_LOGIC;
				enter 		:  IN 	STD_LOGIC_VECTOR(3 downto 0)
				
	);
END ENTITY prueba_VGA;

ARCHITECTURE structural OF prueba_VGA IS
	SIGNAL x_add_s 		: STD_LOGIC;
	SIGNAL y_add_s 		: STD_LOGIC;
	SIGNAL x_sub_s 		: STD_LOGIC;
	SIGNAL y_sub_s 		: STD_LOGIC;
	
	SIGNAL button_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL x_out_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_out_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);

	SIGNAL pos_out_x_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_out_y_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);

	SIGNAL R_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL pos_x_divided_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_y_divided_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
BEGIN	

	pos_x_tablero 	<= pos_x_divided_s;
	pos_y_tablero	<= pos_y_divided_s;
	
	VGA: ENTITY work.VGA
	PORT MAP(		clk 			=> clk,
						R_in 			=> R_in_s,
						G_in 			=> G_in_s,
						B_in 			=> B_in_s,
						VGA_HS 		=> VGA_HS,
						VGA_VS 		=> VGA_VS,
						VGA_R 		=> VGA_R,
						VGA_G 		=> VGA_G,
						VGA_B  		=> VGA_B,
						pos_out_x	=> pos_out_x_s,
						pos_out_y	=> pos_out_y_s);	
		
	IMG_FINAL: ENTITY work.imagen_final
	PORT MAP(		clk 				=> clk,
						x 					=> x_out_s,
						y 					=> y_out_s,
						pos_x 			=> pos_out_x_s,
						pos_y 			=> pos_out_y_s,
						R 					=> R_in_s,
						G 					=> G_in_s,
						B 					=> B_in_s,
						unidades 		=> unidades,
						decenas 			=> decenas,
						centenas 		=> centenas,
						miles 			=> miles,
						decenas_miles 	=> decenas_miles,
						tablero_snake	=> tablero_snake,
						tablero_food	=> tablero_food,
						food_x			=> food_x,
						food_y			=> food_y);
						
	DIVIDED: ENTITY work.pos_divided
	PORT MAP(	limite_x => std_logic_vector(to_unsigned(10,10)),
					limite_y => std_logic_vector(to_unsigned(60,10)),
					pos_x 	=> pos_out_x_s,
					pos_y 	=> pos_out_y_s,
					pos_x_divided 	=> pos_x_divided_s,
					pos_y_divided 	=> pos_y_divided_s);
	
	
	
END ARCHITECTURE structural;
