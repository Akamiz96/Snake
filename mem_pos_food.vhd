LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY mem_pos_food IS
	PORT(	clk	:	IN		STD_LOGIC;
			rst	:	IN		STD_LOGIC;
			ena	:	IN		STD_LOGIC;
			d_x		:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
			d_y		:	IN		STD_LOGIC_VECTOR(7 DOWNTO 0);
			q_x		:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0);
			q_y		:	OUT	STD_LOGIC_VECTOR(7 DOWNTO 0)); 

END mem_pos_food;

ARCHITECTURE rtl OF mem_pos_food IS
begin
	dffprn: PROCESS(clk,rst,ena)
	BEGIN
		IF(rst='1') THEN
				q_x<="00000000";	
				q_y<="00000000";	
		ELSIF (rising_edge(clk)) THEN
				IF(ena ='1') THEN
					q_x<=d_x;
					q_y<=d_y;
				END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;