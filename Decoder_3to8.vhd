library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ==================================================
-- 3-to-8 State Decoder
-- Αποκωδικοποιεί την τιμή του μετρητή (T-state counter)
-- σε one-hot σήματα καταστάσεων T0 έως T7
-- ==================================================

entity Decoder_3to8 is
    Port (
        Din  : in  STD_LOGIC_VECTOR(2 downto 0);  -- 3-bit είσοδος από τον απαριθμητή
        Dout : out STD_LOGIC_VECTOR(7 downto 0)   -- 8-bit έξοδος (T0–T7, one-hot)
    );
end Decoder_3to8;

architecture Behavioral of Decoder_3to8 is
begin

    -- Συνδυαστική λογική:
    -- Κάθε αλλαγή στο Din ενεργοποιεί άμεσα
    -- μία και μόνο μία κατάσταση T0–T7
    process(Din)
    begin
        case Din is

            -- Για κάθε δυαδική τιμή του Din
            -- ενεργοποιείται το αντίστοιχο T-state

            when "000" =>
                Dout <= "00000001";  -- T0: αρχική κατάσταση (FETCH1)

            when "001" =>
                Dout <= "00000010";  -- T1: δεύτερη φάση fetch (FETCH2)

            when "010" =>
                Dout <= "00000100";  -- T2: τρίτη φάση fetch (FETCH3)

            when "011" =>
                Dout <= "00001000";  -- T3: πρώτη μικροκατάσταση εντολής

            when "100" =>
                Dout <= "00010000";  -- T4: δεύτερη μικροκατάσταση

            when "101" =>
                Dout <= "00100000";  -- T5: τρίτη μικροκατάσταση

            when "110" =>
                Dout <= "01000000";  -- T6: τέταρτη μικροκατάσταση

            when "111" =>
                Dout <= "10000000";  -- T7: πέμπτη / τελευταία μικροκατάσταση

            -- Ασφαλής κατάσταση για μη έγκυρες τιμές
            when others =>
                Dout <= (others => '0');

        end case;
    end process;

end Behavioral;
