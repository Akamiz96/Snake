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
				x_in				:  IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
				y_in				:  IN    STD_LOGIC_VECTOR(7 DOWNTO 0);
				x_out				:  OUT   STD_LOGIC_VECTOR(7 DOWNTO 0);
				y_out				:  OUT   STD_LOGIC_VECTOR(7 DOWNTO 0));
				
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
	x_plusOne  <= unsigned(x_in) + 1;
	x_minusOne <= unsigned(x_in) + 1;
	
	y_plusOne  <= unsigned(y_in) + 1;
	y_minusOne <= unsigned(y_in) + 1;	
	------------------------
	------------------------
	x <= STD_LOGIC_VECTOR(x_plusOne)  WHEN selX = "01";
		  STD_LOGIC_VECTOR(x_minusOne) WHEN selX = "10";
		  x_in 					          WHEN OTHERS;
				
	y <= STD_LOGIC_VECTOR(y_plusOne)  WHEN selY = "01";
		  STD_LOGIC_VECTOR(y_minusOne) WHEN selY = "10";
		  y_in 					          WHEN OTHERS;
				
	regX : ENTITY work.my_reg
		GENERIC MAP (MAX_WIDTH	=> N)
		PORT MAP (	 clk			=> clk,
						 rts			=> rst,
						 ena			=> max_tick,
						 d				=> x,
						 q				=> x_out);
	regY : ENTITY work.my_reg
		GENERIC MAP (MAX_WIDTH	=> N)
		PORT MAP (	 clk			=> clk,
						 rts			=> rst,
						 ena			=> max_tick,
						 d				=> y,
						 q				=> y_out);
	
END ARCHITECTURE;	