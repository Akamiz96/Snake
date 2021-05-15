-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY control_memory IS
	PORT	(	clk 							:	IN  STD_LOGIC;
				rst 							:	IN  STD_LOGIC;
				input1			:	IN		STD_LOGIC;
				input2			:	IN		STD_LOGIC;
				input3			:	IN		STD_LOGIC;
				input4			:	IN		STD_LOGIC;
				column1			:	OUT	STD_LOGIC;
				column2			:	OUT	STD_LOGIC;
				column3			:	OUT	STD_LOGIC;
				column4			:	OUT	STD_LOGIC;
				x_out 			: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0);
				y_out 			: 	OUT 	STD_LOGIC_VECTOR(9 DOWNTO 0)
				
	);
END ENTITY control_memory;

ARCHITECTURE structural OF control_memory IS
	SIGNAL x_add_s 		: STD_LOGIC;
	SIGNAL y_add_s 		: STD_LOGIC;
	SIGNAL x_sub_s 		: STD_LOGIC;
	SIGNAL y_sub_s 		: STD_LOGIC;
	
	SIGNAL new_data_s		: STD_LOGIC;
	
	SIGNAL button_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL clk_25M 		: STD_LOGIC;
	SIGNAL ena_s	 		: STD_LOGIC;
	
BEGIN

	PLL: ENTITY work.pll_test
	PORT MAP(		inclk0 	=> clk,
						c0			=> clk_25M);
--	clk_25M <= clk;
	
	TECLADO:  ENTITY work.teclado
		   PORT MAP(	clk 		=> clk_25M,
							rst 		=> rst,
							input1 	=> input1,
							input2 	=> input2,
							input3 	=> input3,
							input4 	=> input4,
							column1 	=> column1,
							column2 	=> column2,
							column3 	=> column3,
							column4 	=> column4,
							new_data => new_data_s,
							but_value=> button_s);
						
	
	CONTROL_FSM: ENTITY work.control_fsm
	PORT MAP(		clk 			=> clk_25M,
						rst 			=> rst,
						ena			=> ena_s,
						new_data		=> new_data_s,
						but_value 	=> button_s,
						x_add 		=> x_add_s,
						x_sub 		=> x_sub_s,
						y_add 		=> y_add_s,
						y_sub 		=> y_sub_s);
	
	ADDRMEM: ENTITY work.addr_mem
	PORT MAP(		clk 			=> clk_25M,
						rst			=> rst,
						ena			=> ena_s,
						x_add 		=> x_add_s,
						x_sub 		=> x_sub_s,
						y_add 		=> y_add_s,
						y_sub 		=> y_sub_s,
						x_out 		=> x_out,
						y_out 		=> y_out);					
	
	
	
END ARCHITECTURE structural;
