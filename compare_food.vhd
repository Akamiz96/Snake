LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY compare_food IS
	PORT(	ena	:	IN		STD_LOGIC;
			
			x_food		:	IN		STD_LOGIC_VECTOR(13 DOWNTO 0);
			y_food		:	IN	STD_LOGIC_VECTOR(13 DOWNTO 0);
			check	:	OUT		STD_LOGIC); 

END compare_food;

ARCHITECTURE behavioral OF compare_food IS

BEGIN


END ARCHITECTURE;