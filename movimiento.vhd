LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
----------------------------------------------------------------
ENTITY movimiento IS
	GENERIC (N				:	INTEGER	:=	9);
	PORT	(	clk				:	IN 	STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				max_tick			:  IN 	STD_LOGIC;
				selX				:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				selY				:  IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
				food_x			: 	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				food_y			: 	IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
				x_in				:  IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
				y_in				:  IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
				x_out				:  OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
				y_out				:  OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
				comida			: 	OUT 	STD_LOGIC);
				
END ENTITY movimiento;
ARCHITECTURE RTL OF movimiento IS
	SIGNAL x_plusOne  : INTEGER RANGE 0 to 119;
	SIGNAL x_minusOne : INTEGER RANGE 0 to 199;
	SIGNAL y_plusOne  : INTEGER RANGE 0 to 79;
	SIGNAL y_minusOne : INTEGER RANGE 0 to 79;
	SIGNAL x : STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y : STD_LOGIC_VECTOR(9 DOWNTO 0);
BEGIN

	------------------------
	x_plusOne  <= to_integer(unsigned(x_in)) + 1;
	x_minusOne <= to_integer(unsigned(x_in)) + 1;
	
	y_plusOne  <= to_integer(unsigned(y_in)) + 1;
	y_minusOne <= to_integer(unsigned(y_in)) + 1;	
	------------------------
	------------------------
	x <= STD_LOGIC_VECTOR(to_unsigned(x_plusOne,10))  WHEN selX = "01" ELSE 
		  STD_LOGIC_VECTOR(to_unsigned(x_minusOne,10)) WHEN selX = "10" ELSE
		  x_in;
				
	y <= STD_LOGIC_VECTOR(to_unsigned(y_plusOne,10))  WHEN selY = "01" ELSE 
		  STD_LOGIC_VECTOR(to_unsigned(y_minusOne,10)) WHEN selY = "10" ELSE
		  y_in;
				
	regX : ENTITY work.my_reg
		GENERIC MAP (MAX_WIDTH	=> N)
		PORT MAP (	 clk			=> clk,
						 rst			=> rst,
						 ena			=> max_tick,
						 d				=> x,
						 q				=> x_out);
	regY : ENTITY work.my_reg
		GENERIC MAP (MAX_WIDTH	=> N)
		PORT MAP (	 clk			=> clk,
						 rst			=> rst,
						 ena			=> max_tick,
						 d				=> y,
						 q				=> y_out);
	
	PROCESS(x_plusOne,x_minusOne,y_plusOne, y_minusOne)
	BEGIN
		IF (x = food_x AND y = food_y) THEN
			comida <= '1';
		ELSE 
			comida <= '0';
		END IF;
	END PROCESS;
	
END ARCHITECTURE;	