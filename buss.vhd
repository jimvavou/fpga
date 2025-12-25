library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity buss is
port(sbus : buffer std_logic_vector(15 downto 0);
	  PCdata : in std_logic_vector(15 downto 0);
     DRdata, TRdata,Rdata,ACdata  : in std_logic_vector(7 downto 0);
	  MEMdata  : in std_logic_vector(7 downto 0);
     membus        : in std_logic ; 
     pcbus,drbus,trbus,rbus,acbus   : in std_logic
     );
end buss ;

architecture arc of buss is
signal control: std_logic_vector(5 downto 0);

begin

control <= membus & pcbus & drbus & trbus & rbus & acbus;
sbus <= x"00" & MEMdata when control="100000" else
			pcdata when control="010000"else
			drdata &x"00" when control="001000" else
			x"00" & trdata when control="000100" else
			rdata & x"00" when control="000010" else
			x"00" & acdata when control="000001" else
			drdata & MEMdata when control="010010" else
			drdata & trdata when control="000011" else
			(others=>'0');


end arc;
