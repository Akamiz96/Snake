LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
----------------------------------------
ENTITY circular IS
	GENERIC	(DATA_WIDTH: INTEGER := 8;
				 ADDR_WIDTH: INTEGER := 2);
	PORT	  (clk			:	IN		STD_LOGIC;
				rst			:	IN		STD_LOGIC;
				rd				:	IN 	STD_LOGIC;
				wr				:	IN 	STD_LOGIC;
				w_data		:	IN 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				r_data		:  OUT 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
				full			:	OUT 	STD_LOGIC;
				empty			:	OUT 	STD_LOGIC);
END ENTITY;
----------------------------------------
ARCHITECTURE structural OF circular IS 
	SIGNAL full_s			:	STD_LOGIC;
	SIGNAL w_addr_s		:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL r_addr_s		:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL wr_en_s			: 	STD_LOGIC;
BEGIN 
	
	wr_en_s	<= NOT full_s AND wr;
	full		<= full_s;
	
	FIFO: ENTITY work.fifo_ctrl
			GENERIC MAP(ADDR_WIDTH	=> ADDR_WIDTH)
		   PORT MAP(  	clk			=> clk,
							rst			=> rst,
							rd				=> rd,
							wr				=> wr,
							empty			=> empty,
							full			=> full_s,
							w_addr		=> w_addr_s,
							r_addr		=> r_addr_s);
	
	REGI: ENTITY work.register_file
			GENERIC MAP(DATA_WIDTH	=> DATA_WIDTH,
							ADDR_WIDTH	=> ADDR_WIDTH)
		   PORT MAP(  	clk			=> clk,
							wr_en			=> wr_en_s,
							w_addr		=> w_addr_s,
							r_addr		=> r_addr_s,
							w_data		=> w_data,
							r_data		=> r_data);
END ARCHITECTURE;