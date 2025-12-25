library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.cpulib.all;

entity alu is
generic (n : integer := 8);
port ( ac : in std_logic_vector(n-1 downto 0) ;
db : in std_logic_vector(n-1 downto 0) ;
alus1: in std_logic_vector(7 downto 1) ;
dout: out std_logic_vector(n-1 downto 0) );
end alu ;


architecture arc of alu is


Signal f1,f2,f3,f4 : std_logic_vector (n-1 downto 0);
Signal zero,notdb : std_logic_vector(n-1 downto 0) ;
Signal ANDout, ORout, XORout, NOTout : std_logic_vector(n-1 downto 0) ;

begin
	zero <= (others=>'0');
	ANDout <= ac AND db ;
	ORout <= ac OR db ;
	XORout <= ac XOR db ;
	NOTout <= NOT (ac) ;
	notdb <= NOT (db) ;
	MUX_1: mux2_1 port map(ZERO,ac,ALUS1(1),f1);
	MUX_2: mux4_1 port map(ZERO,db,NOTDB,ZERO,ALUS1(2)&ALUS1(3),f2);
	MUX_3: mux4_1 port map(ANDout,ORout,XORout,NOTout,ALUS1(5) &
	ALUS1(6),f4);
	PADDR: adder8bit port map(f1,f2,ALUS1(4),f3);
	MUX_4: mux2_1 port map(f3,f4,ALUS1(7), dout);
end arc;