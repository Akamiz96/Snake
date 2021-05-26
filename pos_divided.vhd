-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY pos_divided IS
	PORT	(	limite_x, limite_y					:	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x, pos_y							: 	IN 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				pos_x_divided, pos_y_divided		: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ENTITY pos_divided;
ARCHITECTURE structural OF pos_divided IS

 BEGIN 
	
	PROCESS(pos_x, pos_y)
	BEGIN
		pos_y_divided <= std_logic_vector((unsigned(pos_y)-unsigned(limite_y))/5);
		pos_x_divided <= std_logic_vector((unsigned(pos_x)-unsigned(limite_x))/5);
	END PROCESS;
	
END ARCHITECTURE structural;