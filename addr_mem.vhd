-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY addr_mem IS
	PORT	(	clk 					:  IN 	STD_LOGIC;
				rst 					:  IN 	STD_LOGIC;
				ena					: 	IN 	STD_LOGIC;
				x_add					: 	IN		STD_LOGIC;
				x_sub					: 	IN		STD_LOGIC;
				y_add					: 	IN		STD_LOGIC;
				y_sub					: 	IN		STD_LOGIC;
				x_out					: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				y_out					: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ENTITY addr_mem;
ARCHITECTURE structural OF addr_mem IS

 SIGNAL x : INTEGER RANGE 0 to 640;
 SIGNAL y : INTEGER RANGE 0 to 480;
 
 BEGIN 
 PROCESS(rst,clk,x_add,y_add,x_sub,y_sub)
	BEGIN
		IF (rising_edge(clk)) THEN 
			IF (rst = '1') THEN
				x <= 0;
				y <= 0;
			ELSE
				IF (x_add = '1' AND ena='1') THEN 
					x <= x + 1 ;
					IF (x>640) THEN
						x <= 0;
					END IF;
				END IF;
				IF (y_add = '1') THEN 
					y <= y + 1 ;
					IF (y>480) THEN
						y <= 0;
					END IF;
				END IF;
				IF (x_sub = '1') THEN 
					IF (x=0) THEN
						x <= 640;
					ELSE
						x <= x - 1 ;
					END IF;
				END IF;
				IF (y_sub = '1') THEN 
					IF (y=0) THEN
						y <= 480;
					ELSE
						y <= y - 1 ;
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	x_out  <= std_logic_vector(to_unsigned(x, 10));
	y_out  <= std_logic_vector(to_unsigned(y, 10));
	
END ARCHITECTURE structural;