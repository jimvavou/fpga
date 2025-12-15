library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ==================================================
-- Package: ask4lib
-- Περιέχει τις δηλώσεις components που
-- χρησιμοποιούνται στη μονάδα ελέγχου (hardwired)
-- ==================================================

package ask4lib is

    -- ----------------------------------------------
    -- Component: Decoder_4to16
    -- Αποκωδικοποιητής εντολών 4 → 16
    -- Μετατρέπει το opcode (IR[3:0]) σε one-hot σήματα
    -- ----------------------------------------------
    component Decoder_4to16 is
        Port (
            Din  : in  STD_LOGIC_VECTOR(3 downto 0);   -- 4-bit είσοδος (opcode)
            Dout : out STD_LOGIC_VECTOR(15 downto 0)   -- 16 one-hot έξοδοι εντολών
        );
    end component;

    -- ----------------------------------------------
    -- Component: Decoder_3to8
    -- Αποκωδικοποιητής καταστάσεων 3 → 8
    -- Μετατρέπει την έξοδο του απαριθμητή
    -- σε one-hot χρονικές καταστάσεις T0–T7
    -- ----------------------------------------------
    component Decoder_3to8 is
        Port (
            Din  : in  STD_LOGIC_VECTOR(2 downto 0);   -- 3-bit είσοδος από counter
            Dout : out STD_LOGIC_VECTOR(7 downto 0)    -- One-hot T0–T7
        );
    end component;

    -- ----------------------------------------------
    -- Component: Counter
    -- Σύγχρονος απαριθμητής 3-bit
    -- Παράγει την ακολουθία χρονικών καταστάσεων
    -- για τη μονάδα ελέγχου
    -- ----------------------------------------------
    component Counter is
        Port (
            clk   : in  STD_LOGIC;                     -- Ρολόι συστήματος
            rst   : in  STD_LOGIC;                     -- Σύγχρονο reset
            clr   : in  STD_LOGIC;                     -- Clear από FSM (επιστροφή σε T0)
            inc   : in  STD_LOGIC;                     -- Αύξηση κατά 1
            count : out STD_LOGIC_VECTOR(2 downto 0)   -- Έξοδος απαριθμητή
        );
    end component;

end package ask4lib;
