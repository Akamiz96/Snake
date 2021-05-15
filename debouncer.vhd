----------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------------------------------
ENTITY debouncer IS
	PORT	(	clk				:	IN		STD_LOGIC;
				sw					:	IN		STD_LOGIC;
				rst				:	IN		STD_LOGIC;
				deb_sw			:	OUT	STD_LOGIC
	);
END ENTITY debouncer;
----------------------------------------------------------------
ARCHITECTURE structural OF debouncer IS
	SIGNAL max_tick_tb	:	STD_LOGIC;
	SIGNAL ena_tb			:	STD_LOGIC;
	SIGNAL syn_tb			:	STD_LOGIC;
	SIGNAL min_tickRY_s	:	STD_LOGIC;
	SIGNAL clk_10			:	STD_LOGIC;
	SIGNAL counterRY_s	:	STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
					
	DUT: ENTITY work.debouncer_controller
		  PORT MAP(  	clk			=> clk,
							rst			=> rst,
							sw				=> sw,
							max_tick		=> max_tick_tb,
							ena_counter	=> ena_tb,
							syn_clr		=> syn_tb,
							deb_sw		=> deb_sw);	
								
	TMR: 		ENTITY work.timer5ms
				PORT MAP(  	clk	=> clk,
								rst	=> rst,
								ena	=> ena_tb, 
								syn_clr	=> syn_tb,
								max_tick	=> max_tick_tb,
								min_tick	=> min_tickRY_s,
								counter	=> counterRY_s);

END ARCHITECTURE structural;