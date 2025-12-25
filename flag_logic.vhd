library ieee ;
use ieee.std_logic_1164.all ;
entity flag_logic IS
port(ac : in std_logic_vector(7 downto 0);
 
 zero : out std_logic);
end flag_logic ;
architecture arc of flag_logic is
signal control : std_logic_vector(12 downto 0);
begin
zero <=not(ac(0) or ac(1) or ac(2) or ac(3) or ac(4) or ac(5)
 or ac(6) or ac(7));
end arc ;
