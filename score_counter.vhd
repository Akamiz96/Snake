LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
-------------------------------------
ENTITY score_counter IS      
    PORT(           clk              :	IN		STD_LOGIC;    
                    rst              :	IN		STD_LOGIC;
						  ena					 :	IN		STD_LOGIC;
						  clear				 :	IN		STD_LOGIC;
                    score            :	OUT 	STD_LOGIC_VECTOR(13 DOWNTO 0));
END ENTITY score_counter;
-------------------------------------
ARCHITECTURE behaviour OF score_counter IS
        SIGNAL     d_signal             :STD_LOGIC_VECTOR(13 DOWNTO 0);
		  SIGNAL     q_signal             :STD_LOGIC_VECTOR(13 DOWNTO 0);
		  SIGNAL     rst_signal           :STD_LOGIC;
BEGIN
	 d_signal <= STD_LOGIC_VECTOR(unsigned(q_signal)+1);
	 score 		<= q_signal;
	 rst_signal <= rst AND clear;

    DUT: ENTITY work.my_dff_score
    PORT MAP (    clk            =>    clk,
						rst            =>    rst_signal,
						ena				=>		ena,
						d              => 	d_signal,
						q        		=>    q_signal);

END ARCHITECTURE behaviour;