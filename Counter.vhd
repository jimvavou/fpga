library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- ==================================================
-- 3-bit Synchronous Counter (Time-State Counter)
-- Χρησιμοποιείται στη μονάδα ελέγχου για την
-- παραγωγή των χρονικών καταστάσεων T0–T7
-- ==================================================

entity Counter is
    Port (
        clk   : in  STD_LOGIC;                    -- Ρολόι συστήματος
        rst   : in  STD_LOGIC;                    -- Σύγχρονο reset (επιστροφή στην T0)
        clr   : in  STD_LOGIC;                    -- Clear από τη μονάδα ελέγχου
        inc   : in  STD_LOGIC;                    -- Αύξηση κατά 1 (inc)
        count : out STD_LOGIC_VECTOR(2 downto 0)  -- Έξοδος 3-bit (τιμή απαριθμητή)
    );
end Counter;

architecture Behavioral of Counter is

    -- Εσωτερικός καταχωρητής 3-bit
    -- Αποθηκεύει την τρέχουσα τιμή της χρονικής κατάστασης
    signal counter_value : STD_LOGIC_VECTOR(2 downto 0) := "000";

begin

    -- Σύγχρονο process: ενεργοποιείται στη θετική ακμή του clock
    process(clk)
    begin
        if clk'event and clk = '1' then      

            -- Προτεραιότητα 1: Reset
            -- Όταν rst = '1', ο απαριθμητής μηδενίζεται
            if rst = '1' then
                counter_value <= "000";

            -- Προτεραιότητα 2: Clear
            -- Ενεργοποιείται στην τελευταία μικροκατάσταση
            -- κάθε εντολής για επιστροφή στο FETCH (T0)
            elsif clr = '1' then
                counter_value <= "000";

            -- Προτεραιότητα 3: Increment
            -- Όταν inc = '1', ο απαριθμητής αυξάνει κατά 1
            elsif inc = '1' then
                counter_value <= counter_value + 1;

            -- Αν κανένα από τα παραπάνω δεν ισχύει,
            -- ο απαριθμητής διατηρεί την τρέχουσα τιμή του
            end if;

        end if;
    end process;

    -- Αντιστοίχιση της εσωτερικής τιμής στην έξοδο
    count <= counter_value;

end Behavioral;
