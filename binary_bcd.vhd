-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-------------------------------------------------------------------------------
ENTITY binary_bcd IS
    PORT(
        num_bin: IN  STD_LOGIC_VECTOR(17 DOWNTO 0); --220397 --0011 0101 1100 1110 1101
        num_bcd: OUT STD_LOGIC_VECTOR(23 DOWNTO 0) -- 0010 0010 0000 0011 1001 0111
    );
END binary_bcd;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF binary_bcd IS
BEGIN
    proceso_bcd: PROCESS(num_bin)
        VARIABLE z: STD_LOGIC_VECTOR(41 DOWNTO 0);
    BEGIN
        -- Inicialización de datos en cero.
        z := (OTHERS => '0');
        -- Se realizan los primeros tres corrimientos.
        z(20 DOWNTO 3) := num_bin;
        FOR i IN 0 TO 14 LOOP
            -- Unidades (4 bits).
            IF z(21 DOWNTO 18) > 4 THEN
                z(21 DOWNTO 18) := z(21 DOWNTO 18) + 3;
            END IF;
				-- Decenas (4 bits).
            IF z(25 DOWNTO 22) > 4 THEN
                z(25 DOWNTO 22) := z(25 DOWNTO 22) + 3;
            END IF;
				-- Centenas (3 bits).
            IF z(29 DOWNTO 26) > 4 THEN
                z(29 DOWNTO 26) := z(29 DOWNTO 26) + 3;
            END IF;
				-- Unidades Miles (3 bits).
            IF z(33 DOWNTO 30) > 4 THEN
                z(33 DOWNTO 30) := z(33 DOWNTO 30) + 3;
            END IF;
				-- Decenas Miles (3 bits).
            IF z(37 DOWNTO 34) > 4 THEN
                z(37 DOWNTO 34) := z(37 DOWNTO 34) + 3;
            END IF;
				-- Centena Miles (3 bits).
				IF z(41 DOWNTO 38) > 4 THEN
                z(41 DOWNTO 38) := z(41 DOWNTO 38) + 3;
            END IF;
            -- Corrimiento a la izquierda.
            z(41 DOWNTO 1) := z(40 DOWNTO 0);
        END LOOP;
        -- Pasando datos de variable Z, correspondiente a BCD.
        num_bcd <= z(41 DOWNTO 18);
    END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------