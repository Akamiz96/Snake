-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY mem_timer IS
	GENERIC	(DATA_WIDTH: INTEGER := 27;
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

	array_reg(0)  <= "010011000100101101000000000"; -- 40 M
	array_reg(1)  <= "001011111010111100001000000"; -- 25 M
	array_reg(2)  <= "000100110001001011010000000"; -- 10 M
	
	array_reg(3)  <= "000010011000100101101000000"; -- 5  M
	array_reg(4)  <= "000000111101000010010000000"; -- 2  M
	array_reg(5)  <= "000000011110100001001000000"; -- 1  M
	---------------------------------------------------------
	array_reg(6)  <= "010011000100101101000000000"; -- 10 M 
	array_reg(7)  <= "010011000100101101000000000"; -- 10 M 
	PROCESS(pos_x,array_reg)
	BEGIN
		max_tiempo <= array_reg(to_integer(unsigned(pos_x)));
	END PROCESS;

END ARCHITECTURE structural;