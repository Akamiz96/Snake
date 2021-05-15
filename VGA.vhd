-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY VGA IS
	PORT	(	clk 							:	IN  STD_LOGIC;
				R_in, G_in, B_in			: 	IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
				VGA_HS 						:  OUT STD_LOGIC;
				VGA_VS 						:	OUT STD_LOGIC;
				VGA_R, VGA_G, VGA_B 		: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				pos_out_x, pos_out_y		: 	OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END ENTITY VGA;

ARCHITECTURE structural OF VGA IS
	SIGNAL clk_25M 		: STD_LOGIC;
	SIGNAL pos_out_y_s 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_out_x_s 	: STD_LOGIC_VECTOR(9 DOWNTO 0);
	
	SIGNAL red_rdata 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL gre_rdata 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL blu_rdata 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN

	pos_out_y <= pos_out_y_s;
	pos_out_x <= pos_out_x_s;
	red_rdata <= R_in;
	gre_rdata <= G_in;
	blu_rdata <= B_in;

	VGA_SYNC:  ENTITY work.vga_sync
		   PORT MAP(	clk			=> clk_25M,
							R_in			=> red_rdata,
							G_in			=> gre_rdata,
							B_in			=> blu_rdata,
							hsync			=> VGA_HS,
							vsync 		=> VGA_VS,
							R 				=> VGA_R,
							G 				=> VGA_G,
							B 				=> VGA_B,
							pos_out_x	=> pos_out_x_s,
							pos_out_y	=> pos_out_y_s);
	
	
	PLL: ENTITY work.pll_25M
	PORT MAP(		inclk0 	=> clk,
						c0			=> clk_25M);
	
	
END ARCHITECTURE structural;
