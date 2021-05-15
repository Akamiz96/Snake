-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY square IS
	PORT	(	
				x_screen	:	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
				y_screen	:	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
				x_sqr		:	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
				y_sqr		:	IN STD_LOGIC_VECTOR(11 DOWNTO 0);
				video_on	:	OUT STD_LOGIC
	);
END ENTITY square;
ARCHITECTURE structural OF square IS
	BEGIN
END ARCHITECTURE structural;