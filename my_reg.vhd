LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-----------------------------------------------
ENTITY my_reg IS
	GENERIC (  MAX_WIDTH   : INTEGER :=4);
	PORT(	  clk	  :   IN   STD_LOGIC;
			  rst   :   IN   STD_LOGIC;
			  ena	  :   IN   STD_LOGIC;
			  d	  :   IN   STD_LOGIC_VECTOR(MAX_WIDTH DOWNTO 0);
			  q	  :   OUT  STD_LOGIC_VECTOR(MAX_WIDTH DOWNTO 0));
END ENTITY;
------------------------------------------------
ARCHITECTURE rtl OF my_reg IS
BEGIN
	
	dff: PROCESS(clk, rst, d)
	BEGIN
		IF(rst = '1') THEN
			q <= (OTHERS => '0');
		ELSIF(rising_edge(clk)) THEN
			IF(ena = '1') THEN
				q <= d;
			END IF;
		END IF;
	END PROCESS;
	
END ARCHITECTURE;