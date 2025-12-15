library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
library lpm;
use lpm.lpm_components.all;
use work.ask4lib.all;

entity hardwired is
port( ir            	  : in std_logic_vector(3 downto 0);
           clock, reset  : in std_logic ;
           z             	  : in std_logic ;
           mOPs             : out std_logic_vector(26 downto 0));
end hardwired;
architecture arc of hardwired is

signal FETCH1 ,FETCH2 ,FETCH3, NOP1  : std_logic ;
signal LDAC1 ,LDAC2 ,LDAC3 ,LDAC4 ,LDAC5 : std_logic ;
signal STAC1 ,STAC2 ,STAC3, STAC4, STAC5 : std_logic ;
signal MVAC1, MOVR1, JUMP1 ,JUMP2 ,JUMP3 : std_logic ;
signal JMPZ1 ,JMPZY1, JMPZY2, JMPZY3 ,JMPZN1, JMPZN2 : std_logic ;
signal JPNZ1 ,JPNZY1 ,JPNZY2, JPNZY3 ,JPNZN1 ,JPNZN2 : std_logic ;
signal ADD1, SUB1 ,INAC1, CLAC1, AND1, OR1, XOR1, NOT1 : std_logic ;
signal cdata :  std_logic_vector(2 downto 0);
signal dout2 :  std_logic_vector(7 downto 0);
signal dout1 :  std_logic_vector(15 downto 0);
signal notz ,inc, clear : std_logic ;

signal INOP,ILDAC,ISTAC,IMVAC,IMOVR,IJMPZ,IJUMP,IADD,ISUB,IINAC,ICLAC,IAND,IOR,IXOR,INOT,IJPNZ   : std_logic ;
signal T0, T1, T2, T3 ,T4 ,T5 ,T6 ,T7   : std_logic ;

begin

notZ<= not Z;


INOP <= dout1(0);
ILDAC <= dout1(1);
ISTAC <= dout1(2);
IMVAC <= dout1(3);
IMOVR <= dout1(4);
IJUMP <= dout1(5);
IJMPZ <= dout1(6);
IJPNZ <= dout1(7);
IADD <= dout1(8);
ISUB <= dout1(9);
IINAC <= dout1(10);
ICLAC <= dout1(11);
IAND <= dout1(12);
IOR <= dout1(13);
IXOR <= dout1(14);
INOT <= dout1(15);	


T0 <= dout2(0);
T1 <= dout2(1);
T2 <= dout2(2);
T3 <= dout2(3);
T4 <= dout2(4);
T5 <= dout2(5);
T6 <= dout2(6);
T7 <= dout2(7);  





FETCH1<=T0;	        
FETCH2<=T1;	        
FETCH3<=T2;	        
NOP1<=INOP and T3;	
LDAC1<=ILDAC and T3;	
LDAC2<=ILDAC and T4;	
LDAC3<=ILDAC and T5;	
LDAC4<=ILDAC and T6;	
LDAC5<=ILDAC and T7;	
STAC1<=ISTAC and T3;	
STAC2<=ISTAC and T4;	
STAC3<=ISTAC and T5;	
STAC4<=ISTAC and T6; 
STAC5<=ISTAC and T7;
MVAC1<=IMVAC and T3;
MOVR1<=IMOVR and T3;
JUMP1<=IJUMP and T3;
JUMP2<=IJUMP and T4;
JUMP3<=IJUMP and T5;
JMPZY1<=IJMPZ and Z and T3;
JMPZY2<=IJMPZ and Z and T4;
JMPZY3<=IJMPZ and Z and T5;
JMPZN1<=IJMPZ and notZ and T3;
JMPZN2<=IJMPZ and notZ and T4;
JPNZY1<=IJPNZ and notZ and T3;
JPNZY2<=IJPNZ and notZ and T4;
JPNZY3<=IJPNZ and notZ and T5;
JPNZN1<=IJPNZ and Z and T3;
JPNZN2<=IJPNZ and Z and T4;
ADD1<=IADD and T3;
SUB1<=ISUB and T3;
INAC1<=IINAC and T3;
CLAC1<=ICLAC and T3;
AND1<=IAND and T3;
OR1<=IOR and T3;
XOR1<=IXOR and T3;
NOT1<=INOT and T3;

mOPS(26)<=FETCH1 or FETCH3 or LDAC3 or STAC3;
mOPS(25)<=LDAC1 or STAC1 or JMPZY1 or JPNZY1;
mOPS(24)<=JUMP3 or JMPZY3 or JPNZY3;
mOPS(23)<=FETCH2 or LDAC1 or LDAC2 or STAC1 or STAC2 or JMPZN1 or JMPZN2 or JPNZN1 or JPNZN2;
mOPS(22)<=FETCH2 or LDAC1 or LDAC2 or LDAC4 or STAC1 or STAC2 or STAC4 or JUMP1 or JUMP2 or JMPZY1 or JMPZY2 or JPNZY1 or JPNZY2;
mOPS(21)<=LDAC2  or STAC2  or JUMP2  or JMPZY2  or JPNZY2;
mOPS(20)<=FETCH3;
mOPS(19)<=MVAC1;
mOPS(18)<=LDAC5 or MOVR1 or ADD1 or SUB1 or INAC1 or CLAC1 or AND1 or  OR1 or XOR1 or NOT1;
mOPS(17)<=LDAC5 or MOVR1 or ADD1 or SUB1 or INAC1 or CLAC1 or AND1 or  OR1 or XOR1 or NOT1;
mOPS(16)<=FETCH2 or LDAC1 or LDAC2 or LDAC4 or STAC1 or STAC2 or JUMP1 or JUMP2 or JMPZY1 or JMPZY2 or JPNZY1 or  JPNZY2;
mOPS(15)<=STAC5;
mOPS(14)<=FETCH2 or LDAC1 or LDAC2 or LDAC4 or STAC1 or STAC2 or JUMP1 or JUMP2 or JMPZY1 or JMPZY1  or JPNZY1 or JPNZY2;
mOPS(13)<=STAC5;
mOPS(12)<=FETCH1  or  FETCH3;
mOPS(11)<=LDAC2 or LDAC3 or LDAC5 or STAC2 or STAC3 or STAC5 or JUMP2 or JUMP3 or JMPZY2 or JMPZY3 or JPNZY2 or JPNZY3; 
mOPS(10)<=LDAC3 or STAC3 or JUMP3 or JMPZY3 or JPNZY3;
mOPS(9)<=MOVR1 or ADD1 or SUB1 or AND1 or  OR1 or XOR1;
mOPS(8)<=STAC4 or MVAC1;
mOPS(7)<=AND1;
mOPS(6)<=OR1;
mOPS(5)<=XOR1;
mOPS(4)<=NOT1;
mOPS(3)<=INAC1;
mOPS(2)<=CLAC1;
mOPS(1)<=ADD1;
mOPS(0)<=SUB1;

 
clear<= NOP1 OR LDAC5 OR STAC5 OR MVAC1 OR MOVR1 OR JUMP3 OR JMPZY3 OR JMPZN2 OR JPNZY3
	    OR JPNZN2 OR ADD1 OR SUB1 OR INAC1 OR CLAC1 OR AND1 OR OR1 OR XOR1 OR NOT1;
		
 
 block0: Decoder_4to16 port map(Din=>ir, Dout=>dout1);
 block1: Counter 
    port map(clk   => clock,rst   => reset,  clr   => clear, inc   => inc,count => cdata);
 block2: Decoder_3to8 port map(Din=>cdata, Dout=>dout2);
end arc;
