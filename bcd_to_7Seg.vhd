-----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------
ENTITY bcd_to_7Seg IS
	PORT 		(		entrada			:	in 	STD_LOGIC_VECTOR(3 DOWNTO 0);
						segmento			:	out	STD_LOGIC_VECTOR(6 DOWNTO 0));
END ENTITY bcd_to_7Seg;

--------------------------------------------------------------
ARCHITECTURE structural OF bcd_to_7Seg IS
--------------------------------------------------------------
BEGIN

	WITH entrada SELECT 
		segmento	 <= "1000000"	WHEN	"0000", -- 0
						 "1111001"	WHEN	"0001", -- 1
						 "0100100"	WHEN	"0010", -- 2
						 "0110000"	WHEN	"0011", -- 3
						 "0011001"	WHEN	"0100", -- 4
						 "0010010"	WHEN	"0101", -- 5
						 "0000010"	WHEN	"0110", -- 6
						 "1111000"	WHEN	"0111", -- 7
						 "0000000"	WHEN	"1000", -- 8
						 "0010000"	WHEN	"1001",
						 "1111111" 	WHEN 	OTHERS; -- 9
						 
						 
END ARCHITECTURE structural;