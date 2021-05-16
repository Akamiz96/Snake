-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-------------------------------------------------------------------------------
ENTITY binary_bcd IS
    PORT(
        num_bin: IN  STD_LOGIC_VECTOR(13 DOWNTO 0); --9401 --10 0100 1011 1001
        num_bcd: OUT STD_LOGIC_VECTOR(15 DOWNTO 0) -- 1001 0100 0000 0001
    );
END binary_bcd;
-------------------------------------------------------------------------------
ARCHITECTURE Behavioral OF binary_bcd IS
BEGIN
    proceso_bcd: PROCESS(num_bin)
        VARIABLE z: STD_LOGIC_VECTOR(29 DOWNTO 0);
    BEGIN
        -- Inicialización de datos en cero.
        z := (OTHERS => '0');
        -- Se realizan los primeros tres corrimientos.
        z(16 DOWNTO 3) := num_bin;
        FOR i IN 0 TO 10 LOOP
            -- Unidades (4 bits).
            IF z(17 DOWNTO 14) > 4 THEN
                z(17 DOWNTO 14) := z(17 DOWNTO 14) + 3;
            END IF;
				-- Decenas (4 bits).
            IF z(21 DOWNTO 18) > 4 THEN
                z(21 DOWNTO 18) := z(21 DOWNTO 18) + 3;
            END IF;
				-- Centenas (3 bits).
            IF z(25 DOWNTO 22) > 4 THEN
                z(25 DOWNTO 22) := z(25 DOWNTO 22) + 3;
            END IF;
				-- Unidades Miles (3 bits).
            IF z(29 DOWNTO 26) > 4 THEN
                z(29 DOWNTO 26) := z(29 DOWNTO 26) + 3;
            END IF;
            -- Corrimiento a la izquierda.
            z(29 DOWNTO 1) := z(28 DOWNTO 0);
        END LOOP;
        -- Pasando datos de variable Z, correspondiente a BCD.
        num_bcd <= z(29 DOWNTO 14);
    END PROCESS;
END Behavioral;
-------------------------------------------------------------------------------