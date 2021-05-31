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
				unidades 			:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas 				:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				centenas 			:  IN  	STD_LOGIC_VECTOR(3 downto 0);
				miles 				:  IN		STD_LOGIC_VECTOR(3 downto 0);
				decenas_miles 		:  IN 	STD_LOGIC_VECTOR(3 downto 0);
				selector_tablero 		:  IN 	STD_LOGIC_VECTOR(1 downto 0)
	);
END ENTITY pantalla_comienzo;
ARCHITECTURE structural OF pantalla_comienzo IS
	SIGNAL x_1 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL x_2 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_1 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_2 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL y_bordeSup_Mayor 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_bordeSup_Menor 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL x_letras 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
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
	
	SIGNAL obstacle	: STD_LOGIC;
	SIGNAL obstacle_1	: STD_LOGIC;
	SIGNAL obstacle_2	: STD_LOGIC;
	SIGNAL obstacle_3	: STD_LOGIC;
	
	SIGNAL pos_x_divided_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_y_divided_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
 BEGIN 
	--
	--BORDES EXTERNOS
	x_1 <= std_logic_vector(to_unsigned(10,10));
	x_2 <= std_logic_vector(to_unsigned(630,10));
	
	y_1 <= std_logic_vector(to_unsigned(470,10));
	y_2 <= std_logic_vector(to_unsigned(10,10));
	
	--
	--BORDE SUPERIOR AREA DE JUEgo
	y_bordeSup_Mayor <= std_logic_vector(to_unsigned(60,10));
	y_bordeSup_Menor <= std_logic_vector(to_unsigned(50,10));
	--
	
	--
	--INICIO LETras
	x_letras <= std_logic_vector(to_unsigned(15,10));
	--
	
	obstacle <= obstacle_1 WHEN selector_tablero = "00" ELSE 
					obstacle_2 WHEN selector_tablero = "01" ELSE
					obstacle_3 WHEN selector_tablero = "10" ELSE
					obstacle_1 WHEN selector_tablero = "11";

	PROCESS(clk, pos_x, pos_y,tablero_snake)
	BEGIN
		IF (rising_edge(clk)) THEN
			-- Borde exterior	
			IF (pos_y>=y_1 OR pos_y<=y_2 OR pos_x<=x_1 OR pos_x>=x_2) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";
			--Borde superior área de juego
			ELSIF (pos_y>=y_bordeSup_Menor AND pos_y<=y_bordeSup_Mayor) THEN 
				R <= "1111";
				G <= "1111";
				B <= "1111";
			-- Área de juego
			ELSIF (pos_x>=x_1 AND pos_x<=x_2 AND pos_y>=y_bordeSup_Mayor AND pos_y<=y_1) THEN 
				IF (obstacle = '1') THEN
					R <= "1111";
					G <= "0000";
					B <= "0000";
				ELSIF (tablero_snake = '1') THEN
--				IF (tablero_snake = '1') THEN
					R <= "0000";
					G <= "1111";
					B <= "0000";
				ELSE	
					R <= "0000";
					G <= "0000";
					B <= "0000";
				END IF;
			-- Espacio titulo
			ELSIF (pos_x<=x_2 AND pos_x>=x_1 AND pos_y>=y_2 AND pos_y<=y_bordeSup_Menor) THEN
				R <= "1111";
				G <= "1111";
				B <= "1111";	
			-- Espacio letras
				IF(pos_x <= std_logic_vector(to_unsigned(150,10)) AND pos_x>=x_letras) THEN 
					R <= R_score;
					G <= G_score;
					B <= B_score;
				ELSIF (pos_x>=std_logic_vector(to_unsigned(155,10)) AND pos_x<=std_logic_vector(to_unsigned(255,10)) ) THEN
					R <= R_number;
					G <= G_number;
					B <= B_number;
				ELSIF (pos_x>=std_logic_vector(to_unsigned(575,10))) THEN
					R <= R_heart;
					G <= G_heart;
					B <= B_heart;
				ELSE
					R <= "0000";
					G <= "0000";
					B <= "0000";
				END IF;
			ELSE
				R <= "0000";
				G <= "0000";
				B <= "0000";
			END IF;
		END IF;
	END PROCESS;
	
	SCORE:  ENTITY work.score_image
		   PORT MAP(	limite_x => x_letras,
							limite_y => y_2,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_score,
							G 	=> G_score,
							B 	=> B_score);
	
	HEART:  ENTITY work.heart_image
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(575,10)),
							limite_y => y_2,
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							R 	=> R_heart,
							G 	=> G_heart,
							B 	=> B_heart);
							
	NUMBER:  ENTITY work.number_image
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(155,10)),
							limite_y => y_2,
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
	
	OBTACLE:  ENTITY work.obstacle_image
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(10,10)),
							limite_y => std_logic_vector(to_unsigned(60,10)),
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							obstacle => obstacle_3);
							
	OBTACLE1:  ENTITY work.obstacle_image_1
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(10,10)),
							limite_y => std_logic_vector(to_unsigned(60,10)),
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							obstacle => obstacle_1);
	
	OBTACLE2:  ENTITY work.obstacle_image_2
		   PORT MAP(	limite_x => std_logic_vector(to_unsigned(10,10)),
							limite_y => std_logic_vector(to_unsigned(60,10)),
							pos_x 	=> pos_x,
							pos_y 	=> pos_y,
							obstacle => obstacle_2);
							
END ARCHITECTURE structural;