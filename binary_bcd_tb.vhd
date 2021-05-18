---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY binary_bcd_tb IS
END ENTITY binary_bcd_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF binary_bcd_tb IS
	SIGNAL	num_bin_tb	:		STD_LOGIC_VECTOR(13 downto 0); --220397 --11 0101 1100 1110 1101
   SIGNAL	num_bcd_tb	: 		STD_LOGIC_VECTOR(15 downto 0);
---------------------------------------------------------
BEGIN 
	DUT: ENTITY work.binary_bcd
		  PORT MAP(  	num_bin => num_bin_tb,
							num_bcd => num_bcd_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		num_bin_tb <= "10010010111001";
		WAIT;
	END PROCESS tesVectorGenerator;
	
END ARCHITECTURE testbench;