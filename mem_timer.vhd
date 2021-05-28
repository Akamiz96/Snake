-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY mem_timer IS
	GENERIC	(DATA_WIDTH: INTEGER := 26;
				 ADDR_WIDTH: INTEGER := 4);
	PORT	(	pos_x					: 	IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
				max_tiempo			: 	OUT 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
	);
END ENTITY mem_timer;
ARCHITECTURE structural OF mem_timer IS

	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;

 BEGIN 
	array_reg(0)  <= "111001001110000111000000000"; -- 120 M
	array_reg(1)  <= "101111101011110000100000000"; -- 100 M
	array_reg(2)  <= "100110001001011010000000000"; -- 80 M
	array_reg(3)  <= "010111110101111000010000000"; -- 50 M
	array_reg(4)  <= "010011000100101101000000000"; -- 40 M
	array_reg(5)  <= "001011111010111100001000000"; -- 25 M
	array_reg(6)  <= "000100110001001011010000000"; -- 10 M 
	array_reg(7)  <= "000011110100001001000000000"; -- 10 M 

	PROCESS(pos_x)
	BEGIN
		max_tiempo <= array_reg(to_integer(unsigned(pos_x)));
	END PROCESS;

END ARCHITECTURE structural;