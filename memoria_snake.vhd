-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY memoria_snake IS
	GENERIC	(DATA_WIDTH: INTEGER := 62;
				 ADDR_WIDTH: INTEGER := 6);
	PORT	(	clk					:  IN 	STD_LOGIC;
				rst					:  IN    STD_LOGIC;
				pintar_x				:  IN   	STD_LOGIC_VECTOR(5 DOWNTO 0);
				pintar_y				:  IN   	STD_LOGIC_VECTOR(5 DOWNTO 0);
				pantalla_x			:  IN   	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pantalla_y			:  IN   	STD_LOGIC_VECTOR(9 DOWNTO 0);
				comida_x				:  IN   	STD_LOGIC_VECTOR(5 DOWNTO 0);
				comida_y				:  IN   	STD_LOGIC_VECTOR(5 DOWNTO 0);
				we						:  IN   	STD_LOGIC;
				we_comida			:  IN   	STD_LOGIC;
				pintar_despintar	: 	IN 	STD_LOGIC;
				pintar_despintar_comida	: 	IN 	STD_LOGIC;
				pantalla_dato		: 	OUT 	STD_LOGIC;
				comida_dato			: 	OUT 	STD_LOGIC
	);
END ENTITY memoria_snake;
ARCHITECTURE structural OF memoria_snake IS
	
	TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL array_reg	:	mem_2d_type;

 BEGIN 
	
	sequential: PROCESS(clk, rst, we, pintar_despintar)
	BEGIN
		IF(rising_edge(clk))THEN 
			IF (rst = '1') THEN
				array_reg <= (others => (others => '0'));
			ELSE
				IF (we = '1') THEN
					IF (pintar_despintar = '1') THEN
						array_reg(to_integer(unsigned(pintar_y)))(to_integer(unsigned(pintar_x))) <= '1';
					ELSE
						array_reg(to_integer(unsigned(pintar_y)))(to_integer(unsigned(pintar_x))) <= '0';
					END IF;
				END IF;
				IF (we_comida = '1') THEN
					IF (pintar_despintar_comida = '1') THEN
						array_reg(to_integer(unsigned(comida_y)))(to_integer(unsigned(comida_x))) <= '1';
					ELSE
						array_reg(to_integer(unsigned(comida_y)))(to_integer(unsigned(comida_x))) <= '0';
					END IF;
				END IF;
				pantalla_dato 	<= array_reg(to_integer(unsigned(pantalla_y)))(to_integer(unsigned(pantalla_x)));
				comida_dato 	<= array_reg(to_integer(unsigned(comida_y)))(to_integer(unsigned(comida_x)));
			END IF;
		END IF;
	END PROCESS sequential;

END ARCHITECTURE structural;