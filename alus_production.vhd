
library ieee;
use ieee.std_logic_1164.all;

-- ============================================================================
-- Entity: alus
-- Ρόλος: Κωδικοποιεί τα σήματα ελέγχου της μικροεντολής σε έναν 7-bit κωδικό
--        προς την ALU / datapath (έξοδος "alus").
--
-- Είσοδοι (control signals):
--   rbus, drbus     : επιλογές/ενεργοποιήσεις πηγών στο bus (π.χ. R-bus, D-bus)
--   acload, zload   : φόρτωση καταχωρητών (AC, Z)
--   andop, orop,
--   notop, xorop    : επιλογή λογικών πράξεων
--   aczero          : καθαρισμός/μηδενισμός AC (CLAC)
--   acinc           : αύξηση AC (INAC)
--   plus, minus     : επιλογή πρόσθεσης/αφαίρεσης
--
-- Έξοδος:
--   alus            : 7-bit κωδικός λειτουργίας προς την ALU (ALU select)
-- ============================================================================

entity alus is
  port(
    rbus, acload, zload, andop  : in  std_logic;
    orop, notop, xorop, aczero  : in  std_logic;
    acinc, plus, minus, drbus   : in  std_logic;
    alus                        : out std_logic_vector(6 downto 0)
  );
end alus;

architecture arc of alus is

  -- ----------------------------------------------------------------------------
  -- Το "control" είναι ένα συμπιεσμένο vector 12-bit που ενώνει ΟΛΑ τα control
  -- σήματα σε μία λέξη, για να γίνει εύκολο το case decoding.
  --
  -- Bit order (MSB -> LSB) ακριβώς όπως τα κάνεις concatenate:
  -- control(11) = rbus
  -- control(10) = drbus
  -- control(9)  = acload
  -- control(8)  = zload
  -- control(7)  = andop
  -- control(6)  = orop
  -- control(5)  = notop
  -- control(4)  = xorop
  -- control(3)  = aczero
  -- control(2)  = acinc
  -- control(1)  = plus
  -- control(0)  = minus
  -- ----------------------------------------------------------------------------
  signal control : std_logic_vector(11 downto 0);

begin

  -- Συνένωση των σημάτων ελέγχου σε ένα 12-bit "control"
  control <= rbus & drbus & acload & zload & andop & orop
             & notop & xorop & aczero & acinc & plus & minus;

  -- ----------------------------------------------------------------------------
  -- Combinational process (ευαίσθητο μόνο στο control):
  -- Κάθε μοναδικό pattern control αντιστοιχεί σε μία λειτουργία ALU (alus code).
  -- ----------------------------------------------------------------------------
  process(control)
  begin
    case control is

      -- AND: απαιτεί συγκεκριμένο συνδυασμό (rbus=1, drbus=0, acload=1, zload=1,
      --      andop=1, τα υπόλοιπα 0)
      when "101110000000" => alus <= "1000000"; -- AND

      -- OR
      when "101101000000" => alus <= "1100000"; -- OR

      -- NOT (μονοτελής τελεστής, συνήθως στο AC)
      when "001100100000" => alus <= "1110000"; -- NOT

      -- XOR
      when "101100010000" => alus <= "1010000"; -- XOR

      -- CLAC: clear accumulator (μηδενισμός AC)
      when "001100001000" => alus <= "0000000"; -- CLAC

      -- INAC: increment accumulator (AC <- AC + 1)
      when "001100000100" => alus <= "0001001"; -- INAC

      -- ADD: πρόσθεση (π.χ. AC <- AC + R ή AC <- AC + DR ανάλογα με bus select)
      when "101100000010" => alus <= "0000101"; -- ADD

      -- SUB: αφαίρεση
      when "101100000001" => alus <= "0001011"; -- SUB

      -- MOVR: μεταφορά/πέρασμα operand (ουσιαστικά "pass-through" στην ALU)
      when "101100000000" => alus <= "0000100"; -- MOVR

      -- LDAC5: ειδική περίπτωση όπου το ίδιο ALU code χρησιμοποιείται
      --        (π.χ. σε συγκεκριμένο βήμα μικροακολουθίας LDAC)
      when "011100000000" => alus <= "0000100"; -- LDAC5

      -- Default: αν δεν ταιριάζει κανένα pattern, δίνεις "invalid"/NOP code
      -- (εδώ "1111111")
      when others => alus <= "1111111"; -- NO OPERATION / invalid

    end case;
  end process;

end arc;
