LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY mem_score_decenas IS
	GENERIC	(ADDR_WIDTH: INTEGER := 2);
	PORT(	clk			:	IN		STD_LOGIC;
			wr_en			:	IN		STD_LOGIC;
			w_addr		:	IN 	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			r_addr		:	IN 	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			w_data		:	IN 	STD_LOGIC;
			r_data		:	OUT	STD_LOGIC); 
END mem_score_decenas;

ARCHITECTURE rtl OF mem_score_decenas IS
	TYPE mem_2d_type IS ARRAY (0 to 2**ADDR_WIDTH-1) OF STD_LOGIC;
	SIGNAL array_reg	:	mem_2d_type;
	
BEGIN
	--Write process
	write_process: PROCESS(clk)
	BEGIN 
		IF (rising_edge(clk))	THEN
			IF (wr_en = '1') THEN 
				array_reg(to_integer(unsigned(w_addr))) <= w_data;
			END IF;
		END IF;
	END PROCESS;
	
	--Read
	r_data <= array_reg(to_integer(unsigned(r_addr)));
END ARCHITECTURE;