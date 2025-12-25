library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;
use work.cpulib.all;

entity cpu is
port(ARdata,PCdata  : buffer std_logic_vector(15 downto 0);
     DRdata,ACdata  : buffer std_logic_vector(7 downto 0);
     IRdata,TRdata  : buffer std_logic_vector(7 downto 0);
     RRdata         : buffer std_logic_vector(7 downto 0);
     ZRdata         : buffer std_logic ; 
     clock,reset    : in std_logic;
     mOPs           : buffer std_logic_vector(26 downto 0); 
     addressBus     : buffer std_logic_vector(15 downto 0);
     dataBus        : buffer std_logic_vector(7 downto 0));
end cpu ;

architecture arc of cpu is
			  

signal andop,orop,notop,xorop,aczero,acinc,plus,minus:  std_logic;
SIGNAL ARLOAD,PCLOAD,DRLOAD,IRLOAD,TRLOAD,RLOAD,ACLOAD,ZLOAD: STD_logic;
SIGNAL ARINC,PCINC,TRBUS,RBUS,ACBUS,PCBUS,DRBUS,MEMbus,busMEM: STD_logic;
SIGNAL acout,databus1: STD_logic_vector(7 DOWnto 0) ;
signal  alus1: STD_logic_vector(7 DOWnto 1) ;
SIGNAL Drout,TRout,Rout,IRout: STD_logic_vector(7 DOWnto 0);
SIGNAL PCout,ARout: STD_logic_vector(15 DOWnto 0);
signal datab : std_logic_vector(15 downto 0) bus;
signal ARin,PCin : STD_logic_vector(15 DOWnto 0);
signal DRin,RRin,TRin,ACin,Irin : std_logic_vector(7 downto 0);
signal z : std_logic;

begin

   aluss : alus port map(mOPS(9),mOPS(18),mOPS(17),mOPS(7),mOPS(6),mOPS(4),mOPS(5),mOPS(2), mOPS(3),mOPS(1),mOPS(0),mOPS(11),alus1);

	Ze: regf  port map(ACin,clock,reset,mOPS(17),ZRdata);
	
	AR: regnbit generic map( n=>16) 
					port map(ARin,clock,'1', mOPS(26),mOPS(25),ARout);
	PC: regnbit generic map( n=>16) 
					port map(PCin,clock,'1',mOPS(24),mOPS(23),PCout);
	DR: regnbit generic map( n=>8) 
					port map(DRin,clock,'1',mOPS(22),'0',Drout);
	IR:regnbit  generic map( n=>8) 
					port map(IRin,clock,'1',mOPS(20),'0',IRout);
	TR: regnbit generic map( n=>8) 
					port map(TRin,clock,'1',mOPS(21),'0',TRout);
	 R: regnbit generic map( n=>8) 
					port map(RRin,clock,'1',mOPS(19),'0',Rout);	
			
 ALLU: alu port map(dataBus,acout,alus1,ACin);				
  AC: regnbit port map(ACin,clock,'1',mOPS(18),'0',ACout); 
 BUS1: buss port map(addressBus,PCdata,DRdata,TRdata,RRdata,ACdata,databus,mOPS(14),mOPS(12),
							mOPS(11),mOPS(10),mOPS(9),mOPS(8));	

	BUSbuf: tsb generic map (n=>8 ) 
					 port map (datab(15 downto 8),busMEM,dataBus);
	MEMbuf: tsb generic map (n=>8 ) 
					 port map (dataBus,MEMbus,datab(7 downto 0));
	PCbuf:  tsb generic map (n=>16) 
					 port map(PCout,mOPS(12),datab);
	DRbuf:  tsb generic map (n=>8) 
					 port map(DRout,mOPS(11),datab(15 DOWnto 8));	
	TRbuf: tsb generic map (n=>8) 
					 port map(TRout,mOPS(10),datab(7 DOWnto 0));
	Rbuf: tsb generic map (n=>8) 
					 port map(Rout,mOPS(9),datab(15 DOWnto 8));
	ACbuf: tsb generic map (n=>8) 
					 port map(ACout,mOPS(8),datab(7 DOWnto 0));		
			
mem: memory1 port map(ARout,clock,mOPS(13),mOPS(14),dataBus1);

CU: hardwired port map(IROut,clock,reset,z,mOPs);


ARdata <= ARout;
PCdata <= PCout;
DRdata <= DRout;
RRdata <= Rout;
ACdata <= ACout;
IRdata <= IRout;
TRdata <= TRout;
Irin  <=DRout;
dataBus1<=dataBus;
			
					 
end arc;


	
    