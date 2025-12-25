library ieee;
use ieee.std_logic_1164.all;
entity regf is
port( ac : in std_logic_vector(7 downto 0);
 clk : in std_logic;
 clr : in std_logic;
 ld : in std_logic;
 dout : buffer std_logic);
end regf;
architecture arc of regf is
component flag_logic is
port(ac : in std_logic_vector(7 downto 0);
 zero : out std_logic);
end component;
	

signal din : std_logic;
signal zero : std_logic;
begin
din <= zero;

FLL : flag_logic port map(ac,zero);
end arc;