-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
-------------------------------------------------------------------------------
ENTITY prueba_VGA IS
	PORT	(	clk 				:	IN  STD_LOGIC;
				rst 				:	IN  STD_LOGIC;
				input1			:	IN		STD_LOGIC;
				input2			:	IN		STD_LOGIC;
				input3			:	IN		STD_LOGIC;
				input4			:	IN		STD_LOGIC;
				column1			:	OUT	STD_LOGIC;
				column2			:	OUT	STD_LOGIC;
				column3			:	OUT	STD_LOGIC;
				column4			:	OUT	STD_LOGIC;
				VGA_HS 						:  OUT STD_LOGIC;
				VGA_VS 						:	OUT STD_LOGIC;
				VGA_R, VGA_G, VGA_B 		: 	OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
				enter 		:  IN 	STD_LOGIC_VECTOR(3 downto 0)
				
	);
END ENTITY prueba_VGA;

ARCHITECTURE structural OF prueba_VGA IS
	SIGNAL x_add_s 		: STD_LOGIC;
	SIGNAL y_add_s 		: STD_LOGIC;
	SIGNAL x_sub_s 		: STD_LOGIC;
	SIGNAL y_sub_s 		: STD_LOGIC;
	
	SIGNAL button_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
	SIGNAL x_out_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL y_out_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);

	SIGNAL pos_out_x_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);
	SIGNAL pos_out_y_s 		: STD_LOGIC_VECTOR(9 DOWNTO 0);

	SIGNAL R_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL G_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL B_in_s 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	
BEGIN						
	
	VGA: ENTITY work.VGA
	PORT MAP(		clk 			=> clk,
						R_in 			=> R_in_s,
						G_in 			=> G_in_s,
						B_in 			=> B_in_s,
						VGA_HS 		=> VGA_HS,
						VGA_VS 		=> VGA_VS,
						VGA_R 		=> VGA_R,
						VGA_G 		=> VGA_G,
						VGA_B  		=> VGA_B,
						pos_out_x	=> pos_out_x_s,
						pos_out_y	=> pos_out_y_s);	
		
	IMG_FINAL: ENTITY work.imagen_final
	PORT MAP(		clk 		=> clk,
						x 			=> x_out_s,
						y 			=> y_out_s,
						pos_x 	=> pos_out_x_s,
						pos_y 	=> pos_out_y_s,
						R 			=> R_in_s,
						G 			=> G_in_s,
						B 			=> B_in_s,
						unidades => enter,
						decenas => enter,
						centenas => enter,
						miles => enter,
						decenas_miles => enter);	
	
	
	
END ARCHITECTURE structural;
