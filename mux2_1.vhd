library ieee;
use ieee.std_logic_1164.all;
entity mux2_1 is
generic (n:integer:=8);
port(dina,dinb :in std_logic_vector(n-1 downto 0);
 sel :in std_logic;
 dout :out std_logic_vector(n-1 downto 0));
end mux2_1;
architecture arc of mux2_1 is
begin
dout<= dina when sel='0' else dinb;
end arc;
