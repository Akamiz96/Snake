---------------------------------------------------------
---------------------------------------------------------
LIBRARY IEEE;
USE ieee.STD_LOGIC_1164.all;
---------------------------------------------------------
ENTITY score_tb IS
END ENTITY score_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF score_tb IS
	SIGNAL			puntaje_tb			:   	STD_LOGIC_VECTOR(17 DOWNTO 0);
	SIGNAL			unidades_tb			:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			decenas_tb			:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			centenas_tb			: 		STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			unidades_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			decenas_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL			centenas_miles_tb				:  	STD_LOGIC_VECTOR(6 DOWNTO 0);
---------------------------------------------------------
BEGIN 
	DUT: ENTITY work.score
		  PORT MAP(  	puntaje => puntaje_tb,
							unidades => unidades_tb,
							decenas => decenas_tb,
							centenas => centenas_tb,
							unidades_miles => unidades_miles_tb,
							decenas_miles => decenas_miles_tb,
							centenas_miles => centenas_miles_tb);	
				  
tesVectorGenerator: PROCESS

	BEGIN
		puntaje_tb <= "110101110011101101";
		WAIT;
	END PROCESS tesVectorGenerator;
END ARCHITECTURE testbench;	