-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
-------------------------------------------------------------------------------
ENTITY score IS
	PORT	(	puntaje				:  IN STD_LOGIC_VECTOR(13 DOWNTO 0);
				clk              :	IN		STD_LOGIC;    
            rst              :	IN		STD_LOGIC;
				ena_score			:  IN STD_LOGIC;
				unidades				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				decenas				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				centenas				:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
				unidades_miles		:  OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END ENTITY score;
-------------------------------------------------------------------------------
ARCHITECTURE structural OF score IS
	SIGNAL bcd0_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd1_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd2_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL bcd3_s				   : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL score_s				   : STD_LOGIC_VECTOR(13 DOWNTO 0);
	
	SIGNAL wr_en_s					: STD_LOGIC;
	SIGNAL w_addr_s0				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_addr_s1				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_addr_s2				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_addr_s3				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL r_addr_s				: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL w_data_s				: STD_LOGIC;
	SIGNAL r_data_s				: STD_LOGIC;
	

BEGIN	
	
	w_addr_s0 <= "00";
	w_addr_s1 <= "01";
	w_addr_s2 <= "10";
	w_addr_s3 <= "11";

	BintoBCD: ENTITY	work.binary_bcd
		PORT MAP	(	num_bin => score_s,
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
	
   --Contador	
	COUNTER: ENTITY work.score_counter      
			PORT MAP(   clk     => clk,
							rst     => rst,
							ena	  => ena_score,
							score   => score_s);
	
	--Save Unidades 
	MEM_UNIDADES0: ENTITY work.mem_score_unidades
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s0,
							r_addr  => r_addr_s,
							w_data  => bcd0_s(3),
							r_data  => r_data_s);
	
	MEM_UNIDADES1: ENTITY work.mem_score_unidades
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s1,
							r_addr  => r_addr_s,
							w_data  => bcd0_s(2),
							r_data  => r_data_s);
	
	MEM_UNIDADES2: ENTITY work.mem_score_unidades
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s2,
							r_addr  => r_addr_s,
							w_data  => bcd0_s(1),
							r_data  => r_data_s);
	
	MEM_UNIDADES3: ENTITY work.mem_score_unidades
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s3,
							r_addr  => r_addr_s,
							w_data  => bcd0_s(0),
							r_data  => r_data_s);
	--Save Decenas	
	MEM_DECENAS0: ENTITY work.mem_score_decenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s0,
							r_addr  => r_addr_s,
							w_data  => bcd1_s(3),
							r_data  => r_data_s);
	
	MEM_DECENAS1: ENTITY work.mem_score_decenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s1,
							r_addr  => r_addr_s,
							w_data  => bcd1_s(2),
							r_data  => r_data_s);
	
	MEM_DECENAS2: ENTITY work.mem_score_decenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s2,
							r_addr  => r_addr_s,
							w_data  => bcd1_s(1),
							r_data  => r_data_s);
	
	MEM_DECENAS3: ENTITY work.mem_score_decenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s3,
							r_addr  => r_addr_s,
							w_data  => bcd1_s(0),
							r_data  => r_data_s);
	
	--Save Centenas
	MEM_CENTENAS0: ENTITY work.mem_score_centenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s0,
							r_addr  => r_addr_s,
							w_data  => bcd2_s(3),
							r_data  => r_data_s);
	
	MEM_CENTENAS1: ENTITY work.mem_score_centenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s1,
							r_addr  => r_addr_s,
							w_data  => bcd2_s(2),
							r_data  => r_data_s);
	
	MEM_CENTENAS2: ENTITY work.mem_score_centenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s2,
							r_addr  => r_addr_s,
							w_data  => bcd2_s(1),
							r_data  => r_data_s);
	
	MEM_CENTENAS3: ENTITY work.mem_score_centenas
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s3,
							r_addr  => r_addr_s,
							w_data  => bcd2_s(0),
							r_data  => r_data_s);
	
	--Save Unidades Miles	
	MEM_UNIDADESMILES0: ENTITY work.mem_score_unidades_miles
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s0,
							r_addr  => r_addr_s,
							w_data  => bcd3_s(3),
							r_data  => r_data_s);
	
	MEM_UNIDADESMILES1: ENTITY work.mem_score_unidades_miles
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s1,
							r_addr  => r_addr_s,
							w_data  => bcd3_s(2),
							r_data  => r_data_s);
	
	MEM_UNIDADESMILES2: ENTITY work.mem_score_unidades_miles
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s2,
							r_addr  => r_addr_s,
							w_data  => bcd3_s(1),
							r_data  => r_data_s);
	
	MEM_UNIDADESMILES3: ENTITY work.mem_score_unidades_miles
			PORT MAP (	clk	  => clk,
							wr_en	  => wr_en_s,
							w_addr  => w_addr_s3,
							r_addr  => r_addr_s,
							w_data  => bcd3_s(0),
							r_data  => r_data_s);

END ARCHITECTURE structural;
------------------------------------------------------------------------------