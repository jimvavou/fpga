library ieee;
use ieee.std_logic_1164.all;
entity adder8bit is
port(dina,dinb :in std_logic_vector(7 downto 0);
cin :in std_logic;
dout :out std_logic_vector(7 downto 0));
end adder8bit;
architecture structural of adder8bit is
component FA
port(A,B,Ci : in std_logic ;
S,Co : out std_logic ) ;
end component ;
Signal C : std_logic_vector(7 downto 0);
begin
FA_1: FA port map(dina(0),dinb(0), cin, dout(0), C(0));
p1: for i in 1 to 7 generate
FA_2: FA PORT MAP (dina(i), dinb(i), C(i-1), dout(i), C(i));
end generate;
end structural;