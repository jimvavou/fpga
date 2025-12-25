library ieee;
use ieee.std_logic_1164.all;
Entity mux4_1 is
generic (n:integer:=8);
port(dina,dinb :in std_logic_vector(n-1 downto 0);
dinc,dind :in std_logic_vector(n-1 downto 0);
sel :in std_logic_vector(1 downto 0);
dout :out std_logic_vector(n-1 downto 0));
end mux4_1;
architecture arc of mux4_1 is
begin
with sel select
dout <= dina when "00",
dinb when "01",
dinc when "10",
dind when others;
end arc;