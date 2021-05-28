-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY obstacle_image IS
	GENERIC	(DATA_WIDTH: INTEGER := 62;
				 ADDR_WIDTH: INTEGER := 6);
	PORT	(	limite_x, limite_y:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y		: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY obstacle_image;
ARCHITECTURE structural OF obstacle_image IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;

 BEGIN 
	array_reg(0)  <= "11110000000000000000000000000000000000000000000000000000000000";
	array_reg(1)  <= "10000000000000000000000000111111111111111111100011111111111000";
	array_reg(2)  <= "10000000000000000000000000001000000000000000100010000000000000";
	array_reg(3)  <= "10011110000111111111111100001000000000000000100010000000000000";
	array_reg(4)  <= "10010000000000000010000000001000000011111000100010000100000000";
	array_reg(5)  <= "10010000000000000010000000001000000000001000100010000100000000";
	array_reg(6)  <= "10010011111111110010000000001000000000001000100010000100000000";
	array_reg(7)  <= "10010010000000000010000000001111111110001000100010000100011110";
	array_reg(8)  <= "10010010000000000010000010001000000000001000100010000100000010";
	array_reg(9)  <= "00010010000000000010000010001000000000001000100010000100000010";
	array_reg(10) <= "00010010011111111110000010001000000000001000100010000100000010";
	array_reg(11) <= "00010010000000000000000010001000000000001000100010000100000010";
	array_reg(12) <= "00010010000000000000000010001000001000001000100010000100000010";
	array_reg(13) <= "00010010011110000000000010001000001000001000100010000100010010";
	array_reg(14) <= "00010010000010000000000010001000001000000000100010000100010010";
	array_reg(15) <= "00010010000010000000000010000000001000000000100010000100010010";
	array_reg(16) <= "00010000000010000000000010000000001000000000100000000100010010";
	array_reg(17) <= "00010000000010000000000010000000001111111100100000000100010010";
	array_reg(18) <= "10011111110010000000000010000000000000000000100000000100010010";
	array_reg(19) <= "00000000010011111111111111100000000000000000000000000100010010";
	array_reg(20) <= "00000000010010000000000000000000000000000000000000000100010010";
	array_reg(21) <= "00000000010010000000000000000000001111000000000000000100010010";
	array_reg(22) <= "00000000010010000000000000000000001000000000000000000100010010";
	array_reg(23) <= "00010010010010000010000010000000001000000000000000000100010010";
	array_reg(24) <= "00010010010010000010000010000000001000001111111111111100010010";
	array_reg(25) <= "00010010010010000010000011111111111000000000000000000000010010";
	array_reg(26) <= "00010010000010000010000000000000000000000000000000000000010010";
	array_reg(27) <= "10010010000000000010000000000000000000000000000000000000010000";
	array_reg(28) <= "10010010000000000010000000000000000000000001111111111100010000";
	array_reg(29) <= "10010010000000000010000000000000000000000000000000000000010000";
	array_reg(30) <= "10010011111111111111111111111111111111000000000000000000010000";
	array_reg(31) <= "10010000000000000000001000000000000000000000000000000000010000";
	array_reg(32) <= "10010000000000000000001000000000000000000000000000001000000000";
	array_reg(33) <= "10010000000000000000001000000000010000000000000000001000000000";
	array_reg(34) <= "10011111111111111111001000000000010000000000000000001000000000";
	array_reg(35) <= "10000000000000000000001001111110011111111111111001001000000000";
	array_reg(36) <= "10000000000000000000001001000000000000000000000001001000000000";
	array_reg(37) <= "10000000000000000000001001000000000000000000000001001111111111";
	array_reg(38) <= "00000000000000000000001001000000000000000000000001000000000000";
	array_reg(39) <= "00000000000000000000000000000000000000000000000001000000000000";
	array_reg(40) <= "00111111111111111111100000000111111111111111110001000000000000";
	
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