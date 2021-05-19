LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
----------------------------------------
ENTITY timer_mov IS
	GENERIC (N_50			:	INTEGER	:=	17); --
	PORT	  (clk			:	IN		STD_LOGIC;
				rst			:	IN 	STD_LOGIC;
				ena			:	IN 	STD_LOGIC;
				syn_clr		:	IN 	STD_LOGIC;
				max_tick		:	OUT 	STD_LOGIC;
				min_tick		:	OUT 	STD_LOGIC;
				counter		:	OUT 	STD_LOGIC_VECTOR(N_50-1 DOWNTO 0));
END ENTITY;
----------------------------------------
ARCHITECTURE structural OF timer_mov IS 
	CONSTANT ONES		:	STD_LOGIC_VECTOR(N_50-1 DOWNTO 0)	:=	(OTHERS => '1');
	CONSTANT ZEROS		:	STD_LOGIC_VECTOR(N_50-1 DOWNTO 0)	:=	(OTHERS => '0');
	
	SIGNAL load_s		:	STD_LOGIC	:= '0';
	SIGNAL up_s			:	STD_LOGIC	:= '1';
	SIGNAL max_tick_s	:	STD_LOGIC;
	SIGNAL min_tick_s	:	STD_LOGIC;
	SIGNAL ena_s		:	STD_LOGIC;
	SIGNAL d_s			: 	STD_LOGIC_VECTOR(N_50-1 DOWNTO 0);
	SIGNAL counter_s	:	STD_LOGIC_VECTOR(N_50-1 DOWNTO 0);
BEGIN 
		
	counter <= counter_s;
	
	load_s	<=	'1' WHEN counter_s = "11000011010100000"	ELSE 
					'0';
	max_tick	<=	'1' WHEN counter_s = "11000011010100000"	ELSE 
					'0';
	--Pruebas TestBench 11110100001001000000
	--load_s	<=	'1' WHEN counter_s = "1111"	ELSE 
	--				'0';
	--max_tick	<=	'1' WHEN counter_s = "1111"	ELSE 
	--				'0';
	
	
	
	CNTR: 	ENTITY work.univ_bin_counter
				GENERIC  MAP (N	=> N_50)
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								ena	=> ena, 
								syn_clr	=> syn_clr,
								load	=> load_s,
								up	=> up_s,
								d	=> ZEROS,
								max_tick	=> max_tick_s,
								min_tick	=> min_tick,
								counter	=> counter_s);
END ARCHITECTURE;