library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

package cpulib is


component tsb is
generic (n: integer :=8);
port( din : in std_logic_vector(n-1 downto 0);
en : in std_logic;
dout : out std_logic_vector(n-1 downto 0));
end component tsb;


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


component alus IS
port(rbus,acload,zload,andop        : in std_logic;
          orop,notop,xorop,aczero   : in std_logic;
          acinc,plus,minus,drbus    : in std_logic;
          alus                      : out std_logic_vector(6 downto 0));
end component alus;


component regf is
port( ac : in std_logic_vector(7 downto 0);
clk : in std_logic;
clr : in std_logic;
ld : in std_logic;
dout : buffer std_logic);
end component regf;


component regnbit is
generic (n: integer :=8);
port( din : in std_logic_vector(n-1 downto 0);
 clk,rst,ld : in std_logic;
 inc : in std_logic;
 dout : out std_logic_vector(n-1 downto 0));
 end component regnbit;
 
 
component buss is
port(sbus : buffer std_logic_vector(15 downto 0);
	  PCdata : in std_logic_vector(15 downto 0);
     DRdata, TRdata,Rdata,ACdata  : in std_logic_vector(7 downto 0);
	  MEMdata  : in std_logic_vector(7 downto 0);
     membus        : in std_logic ; 
     pcbus,drbus,trbus,rbus,acbus   : in std_logic
     );
end component buss ;
 
 
component alu is
generic (n : integer := 8);
port ( ac : in std_logic_vector(n-1 downto 0) ;
db : in std_logic_vector(n-1 downto 0) ;
alus1: in std_logic_vector(7 downto 1) ;
dout: out std_logic_vector(n-1 downto 0) );
end component alu;
 
component mux2_1 is
generic (n:integer:=8);
port(dina,dinb :in std_logic_vector(n-1 downto 0);
 sel :in std_logic;
 dout :out std_logic_vector(n-1 downto 0));
end component mux2_1;
 
 
component mux4_1 is
generic (n:integer:=8);
port(dina,dinb :in std_logic_vector(n-1 downto 0);
dinc,dind :in std_logic_vector(n-1 downto 0);
sel :in std_logic_vector(1 downto 0);
dout :out std_logic_vector(n-1 downto 0));
end component mux4_1;


component adder8bit is
port(dina,dinb :in std_logic_vector(7 downto 0);
cin :in std_logic;
dout :out std_logic_vector(7 downto 0));
end component adder8bit;
 

 
 
 component memory1 is
port( addr : in std_logic_vector(15 downto 0);
clk : in std_logic;
rd,wr : in std_logic;
data : inout std_logic_vector(7 downto 0));
end component memory1;

---------------------------------

component Decoder_4to16 is
    Port ( Din : in STD_LOGIC_VECTOR(7 downto 0);
           Dout : out STD_LOGIC_VECTOR(15 downto 0));
end component;

component Decoder_3to8 is
    Port ( Din : in STD_LOGIC_VECTOR(2 downto 0);
           Dout : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component counter is

	port( clk, rst, clr  : in std_logic ;
		  count   : out std_logic_vector(2 downto 0));
end component;

component hardwired is
port( 
           ir            	  : in std_logic_vector(7 downto 0);			  
           clock, reset  : in std_logic ;			  
           z             	  : in std_logic ;
           mOPs             : buffer std_logic_vector(26 downto 0));
end component;
 
end package cpulib;