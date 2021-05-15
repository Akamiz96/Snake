-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY heart_image IS
	GENERIC	(DATA_WIDTH: INTEGER := 11;
				 ADDR_WIDTH: INTEGER := 3);
	PORT	(	limite_x, limite_y:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY heart_image;
ARCHITECTURE structural OF heart_image IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;

 BEGIN 
	array_reg(0) <= "00001010000";
	array_reg(1) <= "00011111000";
	array_reg(2) <= "00011111000";
	array_reg(3) <= "00001110000";
	array_reg(4) <= "00000100000";
	
	PROCESS(pos_x, pos_y)
	BEGIN
		pos_y_divided <= std_logic_vector((unsigned(pos_y)-unsigned(limite_y))/5);
		pos_x_divided <= std_logic_vector((unsigned(pos_x)-unsigned(limite_x))/5);
		mem <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
		IF (mem = '1') THEN 
			R <= "1111";
			G <= "0000";
			B <= "0000";
		ELSE
			R <= "0000";
			G <= "0000";
			B <= "0000";
		END IF;
--		G <= "0000";
--		B <= "0000";
--		G(0) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		G(1) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		G(2) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		B(0) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		B(1) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		B(2) <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
--		r_data <= array_reg(to_integer(unsigned(r_addr)));
	END PROCESS;
	
END ARCHITECTURE structural;