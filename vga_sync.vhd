-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY vga_sync IS
	PORT	(	clk 					:  IN 	STD_LOGIC;
				R_in, G_in, B_in	: 	IN 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				hsync 				:  OUT 	STD_LOGIC;
				vsync 				:	OUT 	STD_LOGIC;
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0);
				pos_out_x			: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_out_y			: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ENTITY vga_sync;
ARCHITECTURE structural OF vga_sync IS

 SIGNAL x_pos : INTEGER RANGE 0 to 800;
 SIGNAL y_pos : INTEGER RANGE 0 to 525;
 
 BEGIN 
 PROCESS(clk,x_pos,y_pos)
	BEGIN
		IF (rising_edge(clk)) THEN 
			-- Contador de posicion de X y Y 
			IF(x_pos < 800) THEN
				x_pos <= x_pos + 1 ;
			ELSE
				x_pos <= 0;
				IF(y_pos < 525) THEN
					y_pos <= y_pos + 1 ;
				ELSE 
					y_pos <= 0;
				END IF;
			END IF;
			
			-- Contador de posicion de X y Y siguiente
			IF(x_pos < 799) THEN
				pos_out_x <= std_logic_vector(to_unsigned(x_pos + 1,10));
			ELSE
				pos_out_x <= std_logic_vector(to_unsigned(0,10));
				IF(y_pos < 524) THEN
					pos_out_y <= std_logic_vector(to_unsigned(y_pos + 1,10));
				ELSE 
					pos_out_y <= std_logic_vector(to_unsigned(0,10));
				END IF;
			END IF;
			
			-- Sincronización HSync and VSync 
			IF (x_pos >= 656 AND x_pos <= 751) THEN
				Hsync <= '0';
			ELSE 
				Hsync <= '1';
			END IF; 
			
			IF (y_pos >= 490 AND y_pos <= 491) THEN
				Vsync <= '0';
			ELSE 
				Vsync <= '1';
			END IF;
			
			-- Valores RGB en cero
			IF ((x_pos >= 640 AND x_pos <= 800) OR (y_pos >= 480 AND y_pos <= 525)) THEN
				R <= (OTHERS=>'0');
				G <= (OTHERS=>'0');
				B <= (OTHERS=>'0');
			ELSE
				-- Dibujar pixeles
				R <= R_in;
				G <= G_in;
				B <= B_in;
			END IF;
	
		END IF;
	END PROCESS;
	
--	pos_out_x  <= std_logic_vector(to_unsigned(x_pos, 10));
--	pos_out_y  <= std_logic_vector(to_unsigned(y_pos, 10));
	
END ARCHITECTURE structural;