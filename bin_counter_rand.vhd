LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
----------------------------------------
ENTITY bin_counter_rand IS
	GENERIC (N				:	INTEGER	:=	10);
	PORT	  (clk			:	IN		STD_LOGIC;
				rst			:	IN 	STD_LOGIC;
				ena			:	IN 	STD_LOGIC;
				syn_clr		:	IN 	STD_LOGIC;
				load			: 	IN		STD_LOGIC;
				up				:	IN 	STD_LOGIC;
				sel			:	IN 	STD_LOGIC;
				d				:	IN 	STD_LOGIC_VECTOR(N-1 DOWNTO 0);
				max_tick		:	OUT 	STD_LOGIC;
				min_tick		:	OUT 	STD_LOGIC;
				counter		:	OUT 	STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END ENTITY;
----------------------------------------
ARCHITECTURE rtl OF bin_counter_rand IS 
	CONSTANT ONES		:	UNSIGNED	(N-1 DOWNTO 0)	:=	(OTHERS => '1');
	CONSTANT ZEROS		:	UNSIGNED	(N-1 DOWNTO 0) :=	(OTHERS => '0');
	
	SIGNAL count_s		:	UNSIGNED	(N-1 DOWNTO 0);
	SIGNAL count_next	:	UNSIGNED	(N-1 DOWNTO 0);
	
BEGIN 
	
	count_next	<=	ZEROS 			 WHEN syn_clr = '1'					ELSE 
						UNSIGNED(d)		 WHEN load = '1'						ELSE
						count_s + 5		 WHEN	(ena = '1' AND up = '1') 	ELSE 
						count_s - 5		 WHEN	(ena = '1' AND up = '0') 	ELSE 
						count_s;
	
	PROCESS(clk,rst,sel)
		VARIABLE temp	:	UNSIGNED(N-1 DOWNTO 0);
	BEGIN
		IF(rst='1')	THEN 
			IF(sel='0') THEN
				temp := "0111000111";
			ELSE
				temp := "0000010100";
			END IF;
		ELSIF(rising_edge(clk))	THEN 
			IF(ena='1')	THEN 
				temp	:=	count_next;
			END IF; 
		END IF;
		counter <= STD_LOGIC_VECTOR(temp);
		count_s <= temp; 
	END PROCESS;
	
	max_tick	<= '1'	WHEN	count_s = ONES		ELSE '0';
	min_tick	<= '1'	WHEN	count_s = ZEROS	ELSE '0';
	
END ARCHITECTURE;