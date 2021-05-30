-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY imagen_final IS
	PORT	(	clk 					:  IN 	STD_LOGIC;
				x, y	 				: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				unidades 			:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas 				:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				centenas 			:  IN  	STD_LOGIC_VECTOR(3 downto 0);
				miles 				:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas_miles 		:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				tablero_snake		:	IN		STD_LOGIC;
				food_x			  :	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_y			  :	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				tablero_food		:	IN		STD_LOGIC;
				selector_tablero 		:  IN 	STD_LOGIC_VECTOR(1 downto 0)
	);
END ENTITY imagen_final;
ARCHITECTURE structural OF imagen_final IS

 SIGNAL x_pos : INTEGER RANGE 0 to 800;
 SIGNAL y_pos : INTEGER RANGE 0 to 525;
 
 SIGNAL R_comienzo 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL G_comienzo 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
 SIGNAL B_comienzo 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
 
 BEGIN 
	R<=R_comienzo;
	G<=G_comienzo;
	B<=B_comienzo;
	COMIENZO:  ENTITY work.pantalla_comienzo
		   PORT MAP(	clk 	=> clk,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_comienzo,
							G 	=> G_comienzo,
							B 	=> B_comienzo,
							tablero_snake	=> tablero_snake,
							tablero_food	=> tablero_food,
							unidades => unidades,
							decenas => decenas,
							centenas => centenas,
							miles => miles,
							decenas_miles => decenas_miles,
							food_x			=> food_x,
							food_y			=> food_y,
							selector_tablero	=> selector_tablero);
	
END ARCHITECTURE structural;