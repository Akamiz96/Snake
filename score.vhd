-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY score IS
	PORT	(	clk              :	IN		STD_LOGIC;    
            rst              :	IN		STD_LOGIC;
				ena_score			:  IN STD_LOGIC;
				clear					:  IN STD_LOGIC;
				mem_unidades		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_decenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_centenas				:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				mem_unidades_miles		:  OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END ENTITY score;
-------------------------------------------------------------------------------
ARCHITECTURE structural OF score IS
	SIGNAL score_s				   : STD_LOGIC_VECTOR(13 DOWNTO 0);

BEGIN	
	
	BintoBCD: ENTITY	work.binary_bcd
		PORT MAP	(	num_bin => score_s,
						num_bcd(15 downto 12) => mem_unidades_miles,
						num_bcd(11 downto 8) => mem_centenas,
						num_bcd(7 downto 4) => mem_decenas,
						num_bcd(3 downto 0) => mem_unidades
						);
	
   --Contador	
	COUNTER: ENTITY work.score_counter      
			PORT MAP(   clk     => clk,
							rst     => rst,
							ena	  => ena_score,
							clear	  => clear,
							score   => score_s);

END ARCHITECTURE structural;
------------------------------------------------------------------------------