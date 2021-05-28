-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY pos_multiplied IS
	PORT	(	pos_x, pos_y							: 	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				pos_x_multiplied, pos_y_multiplied		: 	OUT 	STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END ENTITY pos_multiplied;
ARCHITECTURE structural OF pos_multiplied IS
	SIGNAL pos_y_operated 		: STD_LOGIC_VECTOR(15 DOWNTO 0);
	SIGNAL pos_x_operated 		: STD_LOGIC_VECTOR(15 DOWNTO 0);
 BEGIN 
	
	PROCESS(pos_x, pos_y)
	BEGIN
		pos_y_operated <= std_logic_vector((unsigned(pos_y))*10);
		pos_x_operated <= std_logic_vector((unsigned(pos_x))*10);
	END PROCESS;
	pos_x_multiplied <= pos_x_operated(7 DOWNTO 0);
	pos_y_multiplied <= pos_y_operated(7 DOWNTO 0);
END ARCHITECTURE structural;