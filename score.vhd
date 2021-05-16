-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY score IS
	PORT	(	puntaje				:  IN STD_LOGIC_VECTOR(17 DOWNTO 0);
				clk              :	IN		STD_LOGIC;    
            rst              :	IN		STD_LOGIC;
				ena_score			:  IN STD_LOGIC;
				unidades				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				decenas				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				centenas				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				unidades_miles		:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				decenas_miles		:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				centenas_miles		:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY score;
-------------------------------------------------------------------------------
ARCHITECTURE structural OF score IS
	SIGNAL bcd0_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd1_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd2_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd3_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd4_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd5_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL score_s				   : STD_LOGIC_VECTOR(17 DOWNTO 0);

BEGIN	

	BintoBCD: ENTITY	work.binary_bcd
		PORT MAP	(	num_bin => score_s,
						num_bcd(23 downto 20) => bcd5_s,
						num_bcd(19 downto 16) => bcd4_s,
						num_bcd(15 downto 12) => bcd3_s,
						num_bcd(11 downto 8) => bcd2_s,
						num_bcd(7 downto 4) => bcd1_s,
						num_bcd(3 downto 0) => bcd0_s
						);
	
	BCD0:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd0_s,
							segmento	=> unidades);
							
	BCD1:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd1_s,
							segmento	=> decenas);
	
	BCD2:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd2_s,
							segmento	=> centenas);
	
	BCD3:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd3_s,
							segmento	=> unidades_miles);
							
	BCD4:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd4_s,
							segmento	=> decenas_miles);
							
	BCD5:  ENTITY work.bcd_to_7Seg
		   PORT MAP(	entrada	=> bcd5_s,
							segmento	=> centenas_miles);

	COUNTER: ENTITY work.score_counter      
			PORT MAP(   clk     => clk,
							rst     => rst,
							ena	  => ena_score,
							score   => score_s);

END ARCHITECTURE structural;
------------------------------------------------------------------------------