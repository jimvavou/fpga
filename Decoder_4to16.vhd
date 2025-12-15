library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ============================================
-- 4-to-16 Instruction Decoder
-- Μετατρέπει ένα 4-bit opcode σε one-hot έξοδο
-- ============================================

entity Decoder_4to16 is
    Port (
        Din  : in  STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit είσοδος (opcode εντολής)
        Dout : out STD_LOGIC_VECTOR(15 downto 0)   -- 16-bit έξοδος (one-hot)
    );
end Decoder_4to16;

architecture Behavioral of Decoder_4to16 is
begin

    -- Συνδυαστική λογική:
    -- Κάθε αλλαγή στο Din ενημερώνει άμεσα την έξοδο Dout
    process(Din)
    begin
        case Din is

            -- Κάθε περίπτωση ενεργοποιεί ΜΟΝΟ ένα bit της Dout
            when "0000" =>
                Dout <= "0000000000000001";  -- INOP

            when "0001" =>
                Dout <= "0000000000000010";  -- ILDAC

            when "0010" =>
                Dout <= "0000000000000100";  -- ISTAC

            when "0011" =>
                Dout <= "0000000000001000";  -- IMVAC

            when "0100" =>
                Dout <= "0000000000010000";  -- IMOVR

            when "0101" =>
                Dout <= "0000000000100000";  -- IJUMP

            when "0110" =>
                Dout <= "0000000001000000";  -- IJMPZ

            when "0111" =>
                Dout <= "0000000010000000";  -- IJPNZ

            when "1000" =>
                Dout <= "0000000100000000";  -- IADD

            when "1001" =>
                Dout <= "0000001000000000";  -- ISUB

            when "1010" =>
                Dout <= "0000010000000000";  -- IINAC

            when "1011" =>
                Dout <= "0000100000000000";  -- ICLAC

            when "1100" =>
                Dout <= "0001000000000000";  -- IAND

            when "1101" =>
                Dout <= "0010000000000000";  -- IOR

            when "1110" =>
                Dout <= "0100000000000000";  -- IXOR

            when "1111" =>
                Dout <= "1000000000000000";  -- INOT

            -- Ασφάλεια για μη έγκυρες τιμές (X, U κλπ.)
            when others =>
                Dout <= (others => '0');

        end case;
    end process;

end Behavioral;
