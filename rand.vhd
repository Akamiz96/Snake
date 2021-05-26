LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
----------------------------------------
ENTITY rand IS
	GENERIC (N_rand_one			:	INTEGER	:=	8;
				N_rand_two			:	INTEGER	:=	8); 
	PORT	  (clk			:	IN		STD_LOGIC;
				rst			:	IN 	STD_LOGIC;
				ena			:	IN 	STD_LOGIC;
				syn_clr		:	IN 	STD_LOGIC;
				max_tick		:	OUT 	STD_LOGIC;
				min_tick		:	OUT 	STD_LOGIC;
				counter_rand_one		:	OUT 	STD_LOGIC_VECTOR(N_rand_one-1 DOWNTO 0);
				counter_rand_two		:	OUT 	STD_LOGIC_VECTOR(N_rand_two-1 DOWNTO 0));
END ENTITY;
----------------------------------------
ARCHITECTURE structural OF rand IS 
	SIGNAL load_one_s	:	STD_LOGIC	:= '0';
	SIGNAL load_two_s	:	STD_LOGIC	:= '0';
	SIGNAL up_one_s		:	STD_LOGIC	:= '1';
	SIGNAL up_two_s		:	STD_LOGIC	:= '0';
	SIGNAL max_tick_s	:	STD_LOGIC;
	SIGNAL min_tick_s	:	STD_LOGIC;
	SIGNAL counter_rand_one_s	:	STD_LOGIC_VECTOR(N_rand_one-1 DOWNTO 0);
	SIGNAL counter_rand_two_s	:	STD_LOGIC_VECTOR(N_rand_two-1 DOWNTO 0);
BEGIN 

	counter_rand_one <= counter_rand_one_s;
	counter_rand_two <= counter_rand_two_s;
	
	load_one_s	<=	'1' WHEN counter_rand_one_s = "01110111"	ELSE 
					'0';

	load_two_s	<=	'1' WHEN counter_rand_two_s = "00000000"	ELSE 
					'0';
	
	max_tick	<=	'1' WHEN counter_rand_one_s = "01110111"	ELSE 
					'0';

	min_tick	<=	'1' WHEN counter_rand_two_s = "00000000"	ELSE 
					'0';

	CNTR_1: 	ENTITY work.bin_counter_rand
				GENERIC  MAP (N	=> N_rand_one)
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								ena	=> ena, 
								syn_clr	=> syn_clr,
								load	=> load_one_s,
								up	=> up_one_s,
								sel => '1',
								d	=> "00000000",
								max_tick	=> max_tick_s,
								min_tick	=> min_tick_s,
								counter	=> counter_rand_one_s);

	CNTR_2: 	ENTITY work.bin_counter_rand
				GENERIC  MAP (N	=> N_rand_two)
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								ena	=> ena, 
								syn_clr	=> syn_clr,
								load	=> load_two_s,
								up	=> up_two_s,
								sel => '0',
								d	=> "01001111",
								max_tick	=> max_tick_s,
								min_tick	=> min_tick_s,
								counter	=> counter_rand_two_s);

END ARCHITECTURE;