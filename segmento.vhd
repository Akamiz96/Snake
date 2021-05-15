-----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------
ENTITY segmento IS
	PORT 		(		entrada			:	in 	STD_LOGIC_VECTOR(3 DOWNTO 0);
						segmentoA		:	out	STD_LOGIC_VECTOR(6 DOWNTO 0);
						segmentoB		:	out	STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY segmento;

--------------------------------------------------------------
ARCHITECTURE structural OF segmento IS

--------------------------------------------------------------
BEGIN

	WITH entrada SELECT 
		segmentoA <= "1000000"	WHEN	"0000", -- 0
						 "1111001"	WHEN	"0001", -- 1
						 "0100100"	WHEN	"0010", -- 2
						 "0110000"	WHEN	"0011", -- 3
						 "0011001"	WHEN	"0100", -- 4
						 "0010010"	WHEN	"0101", -- 5
						 "0000010"	WHEN	"0110", -- 6
						 "1111000"	WHEN	"0111", -- 7
						 "0000000"	WHEN	"1000", -- 8
						 "0010000"	WHEN	"1001", -- 9 
						 "1000000"	WHEN	"1010", -- 0
						 "1111001"	WHEN	"1011", -- 1
						 "0100100"	WHEN	"1100", -- 2
						 "0110000"	WHEN	"1101", -- 3
						 "0011001"	WHEN	"1110", -- 4
						 "0010010"	WHEN	"1111", -- 5
						 "0000110"	WHEN	OTHERS; -- E
						 
	-- Decenas 						
	WITH entrada SELECT 
		segmentoB <= "1000000"	WHEN	"0000", -- 0
						 "1000000"	WHEN	"0001", -- 0 
						 "1000000"	WHEN	"0010", -- 0
						 "1000000"	WHEN	"0011", -- 0
						 "1000000"	WHEN	"0100", -- 0
						 "1000000"	WHEN	"0101", -- 0
						 "1000000"	WHEN	"0110", -- 0
						 "1000000"	WHEN	"0111", -- 0
						 "1000000"	WHEN	"1000", -- 0
						 "1000000"	WHEN	"1001", -- 0
						 "1111001"	WHEN	"1010", -- 1
						 "1111001"	WHEN	"1011", -- 1
						 "1111001"	WHEN	"1100", -- 1
						 "1111001"	WHEN	"1101", -- 1
						 "1111001"	WHEN	"1110", -- 1
						 "1111001"	WHEN	"1111", -- 1
						 "0000110"	WHEN	OTHERS;
END ARCHITECTURE structural;
