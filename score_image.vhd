-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY score_image IS
	GENERIC	(DATA_WIDTH: INTEGER := 26;
				 ADDR_WIDTH: INTEGER := 3);
	PORT	(	limite_x, limite_y:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY score_image;
ARCHITECTURE structural OF score_image IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;

 BEGIN 
	array_reg(0) <= "00000000000000000000000000";
	array_reg(1) <= "00000000000000000000000000";
	array_reg(2) <= "11011100111001100111001110";
	array_reg(3) <= "11000101001010010000100001";
	array_reg(4) <= "00011100111010010000100110";
	array_reg(5) <= "11000100101010010000101000";
	array_reg(6) <= "11011101001001100111000111";
	array_reg(7) <= "00000000000000000000000000";
	
	PROCESS(mem,pos_y,limite_y,pos_x,limite_x,pos_y_divided,pos_x_divided,array_reg)
	BEGIN
		pos_y_divided <= std_logic_vector((unsigned(pos_y)-unsigned(limite_y))/5);
		pos_x_divided <= std_logic_vector((unsigned(pos_x)-unsigned(limite_x))/5);
		mem <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
		IF (mem = '1') THEN 
			R <= "1111";
			G <= "1111";
			B <= "1111";
		ELSE
			R <= "0000";
			G <= "0000";
			B <= "0000";
		END IF;
	END PROCESS;
	
END ARCHITECTURE structural;