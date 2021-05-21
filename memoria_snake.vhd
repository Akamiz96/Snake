-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY memoria_snake IS
	GENERIC	(DATA_WIDTH: INTEGER := 119;
				 ADDR_WIDTH: INTEGER := 79);
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				max_tick				:  IN 	STD_LOGIC;
				x_in 					: 	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				y_in 					: 	IN		STD_LOGIC_VECTOR(9 DOWNTO 0);
				comida				:  IN 	STD_LOGIC;
				data_in				:  IN 	STD_LOGIC_VECTOR(13 DOWNTO 0);								
				rd						:	OUT 	STD_LOGIC;
				wr						:	OUT 	STD_LOGIC;
				data_out          :  OUT	STD_LOGIC_VECTOR(13 DOWNTO 0);
				cabeza_x				:  OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				cabeza_y				:  OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY memoria_snake;
ARCHITECTURE structural OF memoria_snake IS
	
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;
	SIGNAL pos_y_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_x_divided	: 	STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL mem				: 	STD_LOGIC;
	SIGNAL x 				:  STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL y 				:  STD_LOGIC_VECTOR(6 DOWNTO 0);

 BEGIN 
	
	sequential: PROCESS(clk)
	BEGIN
		IF (rst = '1') THEN
			array_reg(to_integer(unsigned(40)))(to_integer(unsigned(60))) <= '1';
			wr <= '1';
			data_out <= STD_LOGIC_VECTOR(40, 14) & STD_LOGIC_VECTOR(60, 14);
			cabeza_x <= STD_LOGIC_VECTOR(60, 14);
			cabeza_y <= STD_LOGIC_VECTOR(40, 14);
		ELSE
			IF(max_tick = '1') THEN
				array_reg(to_integer(unsigned(y_in)))(to_integer(unsigned(x_in))) <= '1';
				wr <= '1';
				data_out <= x_in & y_in;
				cabeza_x <= x_in;
				cabeza_y <= y_in;
				IF(comida = '0') THEN
					rd <= '1';
					x  <= data_in(13 DOWNTO 7);
					y  <= data_in(6 DOWNTO 0);
					array_reg(to_integer(unsigned(y)))(to_integer(unsigned(x))) <= '0';	
				ELSE
					rd <= '0';
				END IF;
			END IF;
		END IF;
	END PROCESS sequential;
	
END ARCHITECTURE structural;