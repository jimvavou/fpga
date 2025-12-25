library ieee;
use ieee.std_logic_1164.all;


entity memory1 is
port( addr : in std_logic_vector(15 downto 0);
	clk : in std_logic;
	rd,wr : in std_logic;
	data : inout std_logic_vector(7 downto 0));
end memory1;
architecture arc of memory1 is



component Memory IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END component Memory;


component tsb is
generic (n: integer :=8);
port( din : in std_logic_vector(n-1 downto 0);
en : in std_logic;
dout : out std_logic_vector(n-1 downto 0));
end component;


signal addr12bit : std_logic_vector(7 downto 0);
signal datain : std_logic_vector(7 downto 0);
signal dataout : std_logic_vector(7 downto 0);



begin
adr8: for j in 0 to 7 generate
addr12bit(j) <= addr(j) ;
end generate;
BUSbuf: tsb port map (dataout,rd,data);
MEMbuf: tsb port map (data,wr,datain);
mem: Memory port map
(datain,not(clk),addr12bit,wr,dataout);
end ;
