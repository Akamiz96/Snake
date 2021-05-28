LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY movimiento IS
	GENERIC (N				:	INTEGER	:=	5);
	PORT	(	clk				:	IN 	STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				max_tick			:  IN 	STD_LOGIC;
				selX				:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				selY				:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				x_out				:  OUT   STD_LOGIC_VECTOR(5 DOWNTO 0);
				y_out				:  OUT   STD_LOGIC_VECTOR(5 DOWNTO 0));
				
END ENTITY movimiento;
ARCHITECTURE RTL OF movimiento IS
	SIGNAL x_plusOne  : INTEGER RANGE 0 to 61;
	SIGNAL x_minusOne : INTEGER RANGE 0 to 61;
	SIGNAL y_plusOne  : INTEGER RANGE 0 to 40;
	SIGNAL y_minusOne : INTEGER RANGE 0 to 40;
	SIGNAL x : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL y : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL q_out_x : STD_LOGIC_VECTOR(5 DOWNTO 0);
	SIGNAL q_out_y : STD_LOGIC_VECTOR(5 DOWNTO 0);
	
	SIGNAL x_in : INTEGER RANGE 0 to 61 := 31;
	SIGNAL y_in : INTEGER RANGE 0 to 40 := 20;
	
BEGIN
	
	x_out <= STD_LOGIC_VECTOR(to_unsigned(x_in,6));
	y_out <= STD_LOGIC_VECTOR(to_unsigned(y_in,6));
	------------------------
	PROCESS(clk,x_in,y_in,selX,selY,rst)
	BEGIN
		IF (rising_edge(clk)) THEN 
			IF(rst = '1') THEN 
				x_in <= 31;
				y_in <= 20;
			ELSE
				IF(selX="01")THEN
					IF(x_in < 61) THEN
						x_in  <= x_in + 1;
					ELSE
						x_in <= 0;
					END IF;
				END IF;
				
				IF(selX="10")THEN
					IF(x_in > 0) THEN
						x_in  <= x_in - 1;
					ELSE
						x_in <= 61;
					END IF;
				END IF;
				
				IF(selY="01")THEN
					IF(y_in < 40) THEN
						y_in  <= y_in + 1;
					ELSE
						y_in <= 0;
					END IF;
				END IF;
				
				IF(selY="10")THEN
					IF(y_in > 0) THEN
						y_in  <= y_in - 1;
					ELSE
						y_in <= 40;
					END IF;
				END IF;
			END IF;			
		END IF;
	END PROCESS;
	------------------------
	

	
END ARCHITECTURE;	