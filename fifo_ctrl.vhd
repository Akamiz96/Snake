LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY fifo_ctrl IS
	GENERIC	(ADDR_WIDTH: NATURAL := 4);
	PORT(	clk			:	IN		STD_LOGIC;
			rst			:	IN		STD_LOGIC;
			rd				:	IN		STD_LOGIC;
			wr				:	IN		STD_LOGIC;
			empty			:	OUT	STD_LOGIC;
			full			:	OUT	STD_LOGIC;
			w_addr		:	OUT	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
			r_addr		:	OUT	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0)); 
END fifo_ctrl;

ARCHITECTURE arch OF fifo_ctrl IS
	SIGNAL w_ptr_reg, w_ptr_next, w_ptr_succ	:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL r_ptr_reg, r_ptr_next, r_ptr_succ	:	STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0);
	SIGNAL full_reg, full_next						:	STD_LOGIC;
	SIGNAL empty_reg, empty_next					:	STD_LOGIC;
	SIGNAL wr_op										:	STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL wr_en										:	STD_LOGIC;
	
BEGIN
	--succesive pointer values
	w_ptr_succ	<=	STD_LOGIC_VECTOR(UNSIGNED(w_ptr_reg)+1);
	r_ptr_succ	<=	STD_LOGIC_VECTOR(UNSIGNED(r_ptr_reg)+1);
	
	--next state logic for read and write pointers
	wr_op	<=	wr & rd;
	
	--OUT signals 
	empty		<= empty_reg;
	full		<= full_reg;
	w_addr	<= w_ptr_reg;
	r_addr	<= r_ptr_reg;
	
	--register for read and write operations
	PROCESS(clk, rst)
	BEGIN 
		IF (rst='1')	THEN
			w_ptr_reg	<=	(OTHERS => '0');
			r_ptr_reg	<= (OTHERS => '0');
			full_reg		<=	'0';
			empty_reg	<=	'1';
		ELSIF (rising_edge(clk))	THEN
			w_ptr_reg	<=	w_ptr_next;
			r_ptr_reg	<= r_ptr_next;
			full_reg		<=	full_next;
			empty_reg	<=	empty_next;
		END IF;
	END PROCESS;
	
	PROCESS(w_ptr_reg,w_ptr_succ,r_ptr_reg,r_ptr_succ,wr_op,empty_reg,full_reg)
	BEGIN
		CASE wr_op	IS
			WHEN "00"	=> --no op
				w_ptr_next <= w_ptr_reg;
				r_ptr_next <= r_ptr_reg;
				full_next  <= full_reg;
				empty_next <= empty_reg;
			WHEN "01"	=> --read
				w_ptr_next <= w_ptr_reg;
				IF(empty_reg /= '1') THEN
					r_ptr_next <= r_ptr_succ;
					full_next  <= '0';
					IF(r_ptr_succ = w_ptr_reg) THEN
						empty_next <= '1';
					ELSE
						empty_next <= empty_reg;
					END IF;
				END IF;
			WHEN "10"	=> --write
				r_ptr_next <= r_ptr_reg;
				IF(full_reg /= '1') THEN
					w_ptr_next <= w_ptr_succ;
					empty_next  <= '0';
					IF(w_ptr_succ = r_ptr_reg) THEN
						full_next <= '1';
					ELSE
						full_next <= full_reg;
					END IF;
				END IF;
			WHEN "11"	=> --write/read
				w_ptr_next <= w_ptr_succ;
				r_ptr_next <= r_ptr_succ;
				full_next  <= full_reg;
				empty_next <= empty_reg;
			WHEN OTHERS => 
				w_ptr_next <= w_ptr_reg;
				r_ptr_next <= r_ptr_reg;
				full_next  <= full_reg;
				empty_next <= empty_reg;
		END CASE;
	END PROCESS;
END ARCHITECTURE;