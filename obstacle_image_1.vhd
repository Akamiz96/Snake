-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY obstacle_image_1 IS
	GENERIC	(DATA_WIDTH: INTEGER := 62;
				 ADDR_WIDTH: INTEGER := 6);
	PORT	(	limite_x, limite_y:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY obstacle_image_1;
ARCHITECTURE structural OF obstacle_image_1 IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;

 BEGIN 
	array_reg(0)  <= "00000000111111100000000011111111110000000001111111111111100000";
	array_reg(1)  <= "00000000100000000000000000000000000000000000000000000000100000";
	array_reg(2)  <= "00000000100000000000000000000000000000000000000000000000100000";
	array_reg(3)  <= "00000000100000000000000000000000000000000000000000000000100000";
	array_reg(4)  <= "00000000100000000000000000000000000000000000000000000000100000";
	array_reg(5)  <= "00000000100000000011111111111111111111111111111100000000100000";
	array_reg(6)  <= "00000000100000000010000000000000000000000000000100000000100000";
	array_reg(7)  <= "00000000100000000010000000000000000000000000000100000000000000";
	array_reg(8)  <= "00000000100000000010000000000000000000000000000100000000000000";
	array_reg(9)  <= "00000000100000000010000000000000000000000000000100000000000000";
	array_reg(10) <= "00000000100000000010000000111111111111110000000100000000000000";
	array_reg(11) <= "00000000100000000010000000100000000000010000000100000000000000";
	array_reg(12) <= "00001000100000000010000000100000000000010000000100000000000000";
	array_reg(13) <= "00001000100000000010000000100000000000010000000100000000000000";
	array_reg(14) <= "00001000100000000010000000100000000000010000000100000000000000";
	array_reg(15) <= "00001000100000000010000000100000000000010000000100000000100000";
	array_reg(16) <= "00001000100000000010000000100000000000010000000100000000100000";
	array_reg(17) <= "00001000100000000010000000100000000000010000000100000000100000";
	array_reg(18) <= "00001000100000000010000000100000000000010000000100000000100000";
	array_reg(19) <= "00001000100000000010000000100000000000010000000100000000111111";
	array_reg(20) <= "00001000100000000010000000100000000000010000000100000000000000";
	array_reg(21) <= "00001000100000000010000000100000000000010000000100000000000000";
	array_reg(22) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(23) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(24) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(25) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(26) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(27) <= "00001000100000000010000000000000000000010000000100000000000000";
	array_reg(28) <= "00001000100000000010000000000000000000010000000100000011110000";
	array_reg(29) <= "00001000100000000011111111111111111111110000000100000010000000";
	array_reg(30) <= "00001000100000000000000000000000000000000000000100000010000000";
	array_reg(31) <= "00001000100000000000000000000000000000000000000100000010000000";
	array_reg(32) <= "00001000100000000000000000000000000000000000000100000010000000";
	array_reg(33) <= "00001000100000000000000000000000000000000000000100000010000000";
	array_reg(34) <= "00001000100000000000000000000000000000000000000100000010000000";
	array_reg(35) <= "00001000111111111111111111111111111111111111111100000010000000";
	array_reg(36) <= "00001000000000000000000000000000000000000000000000000010000000";
	array_reg(37) <= "00001000000000000000000000000000000000000000000000000010000000";
	array_reg(38) <= "00001000000000000000000000000000000000000000000000000010000000";
	array_reg(39) <= "00001000000000000000000000000000000000000000000000000010000000";
	array_reg(40) <= "00001000000000000000011111111111100000000001111000000010000000";
	
	PROCESS(pos_x, pos_y)
	BEGIN
		pos_y_divided <= std_logic_vector((unsigned(pos_y)-unsigned(limite_y))/5);
		pos_x_divided <= std_logic_vector((unsigned(pos_x)-unsigned(limite_x))/5);
		mem <= array_reg(to_integer(unsigned(pos_y_divided)))(to_integer(unsigned(pos_x_divided)));
		IF (mem = '1') THEN 
			R <= "0000";
			G <= "0000";
			B <= "1111";
		ELSE
			R <= "0000";
			G <= "0000";
			B <= "0000";
		END IF;
	END PROCESS;
	
END ARCHITECTURE structural;