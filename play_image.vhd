-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY play_image IS
	PORT	(	tablero_snake:	IN 	STD_LOGIC;
				R, G, B 				: 	OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY play_image;
ARCHITECTURE structural OF play_image IS

 BEGIN 	
	PROCESS(tablero_snake)
	BEGIN
		IF(tablero_snake='0')THEN
			R <= "0000";
			G <= "0000";
			B <= "0000";
		ELSE
			R <= "1111";
			G <= "1111";
			B <= "1111";
		END IF;
	END PROCESS;
	
END ARCHITECTURE structural;