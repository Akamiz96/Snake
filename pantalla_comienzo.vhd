-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY pantalla_comienzo IS
	PORT	(	clk 					:  IN 	STD_LOGIC;
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				tablero_snake		:	IN		STD_LOGIC;
--				tablero_food		:	IN		STD_LOGIC;
				unidades 			:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas 				:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				centenas 			:  IN  	STD_LOGIC_VECTOR(3 downto 0);
				miles 				:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas_miles 		:  IN 	STD_LOGIC_VECTOR(3 downto 0)
	);
END ENTITY pantalla_comienzo;
ARCHITECTURE structural OF pantalla_comienzo IS
	SIGNAL x_1 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL x_2 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_1 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_2 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL y_titulo 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_juego 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL x_juego_1 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL x_juego_2 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL y_titulo_5	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_juego_5 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL x_juego_1_5 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL x_juego_2_5 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL y_letras_superior 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_letras_inferior 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL R_score 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_score 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_score 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL R_heart 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_heart 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_heart 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL R_number 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_number 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_number 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL R_tablero 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_tablero 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_tablero 	: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
 BEGIN 
	--
	x_1 <= std_logic_vector(to_unsigned(10,10));
	x_2 <= std_logic_vector(to_unsigned(630,10));
	
	y_1 <= std_logic_vector(to_unsigned(470,10));
	y_2 <= std_logic_vector(to_unsigned(10,10));
	
	--	
	y_titulo <= std_logic_vector(to_unsigned(60,10));
	y_titulo_5 <= std_logic_vector(to_unsigned(55,10));
	
	y_juego <= std_logic_vector(to_unsigned(460,10));
	x_juego_1 <= std_logic_vector(to_unsigned(20,10));
	x_juego_2 <= std_logic_vector(to_unsigned(620,10));
	
	y_juego_5 <= std_logic_vector(to_unsigned(455,10));
	x_juego_1_5 <= std_logic_vector(to_unsigned(15,10));
	x_juego_2_5 <= std_logic_vector(to_unsigned(615,10));
	
	-- Espacio letras
	y_letras_superior <= std_logic_vector(to_unsigned(20,10));
	y_letras_inferior <= std_logic_vector(to_unsigned(45,10));
	
	PROCESS(clk, pos_x, pos_y)
	BEGIN
		IF (rising_edge(clk)) THEN
			-- Borde izquierdo
			IF (pos_x<=x_juego_1 AND pos_x>=x_juego_1_5 AND pos_y>=y_titulo_5 AND pos_y<=y_juego) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Borde derecho
			ELSIF (pos_x<=x_juego_2 AND pos_x>=x_juego_2_5 AND pos_y>=y_titulo_5 AND pos_y<=y_juego) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Borde superior
			ELSIF (pos_x<=x_juego_2 AND pos_x>=x_juego_1_5 AND pos_y>=y_juego_5 AND pos_y<=y_juego) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Borde inferior
			ELSIF (pos_x<=x_juego_2 AND pos_x>=x_juego_1_5 AND pos_y>=y_titulo_5 AND pos_y<=y_titulo) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Borde exterior	
			ELSIF (pos_y>y_1 OR pos_y<y_2 OR pos_x<x_1 OR pos_x>x_2) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Área de juego
			ELSIF (pos_x>x_juego_1 AND pos_x<x_juego_2_5 AND pos_y>y_titulo AND pos_y<y_juego_5) THEN 
				R <= R_tablero;
				G <= G_tablero;
				B <= B_tablero;
			-- Espacio titulo
			ELSIF (pos_x<=x_juego_2 AND pos_x>=x_juego_1_5 AND pos_y>=y_2 AND pos_y<y_titulo_5) THEN 
			-- Espacio letras
				IF (pos_y>=y_letras_superior AND pos_y<=y_letras_inferior) THEN 
					IF(pos_x <= std_logic_vector(to_unsigned(140,10))) THEN 
						R <= R_score;
						G <= G_score;
						B <= B_score;
					ELSIF (pos_x>=std_logic_vector(to_unsigned(590,10))) THEN
						R <= R_heart;
						G <= G_heart;
						B <= B_heart;
					ELSIF (pos_x>std_logic_vector(to_unsigned(145,10)) AND pos_x<=std_logic_vector(to_unsigned(240,10)) ) THEN
						R <= R_number;
						G <= G_number;
						B <= B_number;
					ELSE
						R <= "0000";
						G <= "0000";
						B <= "0000";
					END IF;
				END IF;
			ELSE
				R <= "0000";
				G <= "0000";
				B <= "0000";
			END IF;
		END IF;
	END PROCESS;
	
	SCORE:  ENTITY work.score_image
		   PORT MAP(	limite_x => x_juego_1_5,
							limite_y => y_letras_superior,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_score,
							G 	=> G_score,
							B 	=> B_score);
	
	HEART:  ENTITY work.heart_image
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(500,10)),
							limite_y => y_letras_superior,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_heart,
							G 	=> G_heart,
							B 	=> B_heart);
							
	NUMBER:  ENTITY work.number_image
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(145,10)),
							limite_y => y_letras_superior,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_number,
							G 	=> G_number,
							B 	=> B_number,
							unidades => unidades,
							decenas => decenas,
							centenas => centenas,
							miles => miles,
							decenas_miles => decenas_miles);
							
	TABLERO:  ENTITY work.play_image
		   PORT MAP(	tablero_snake 	=> tablero_snake,
							R 	=> R_tablero,
							G 	=> G_tablero,
							B 	=> B_tablero);
							
END ARCHITECTURE structural;