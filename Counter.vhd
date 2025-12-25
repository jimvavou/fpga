library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           clr : in STD_LOGIC;
           count : out STD_LOGIC_VECTOR(2 downto 0));
end Counter;

architecture Behavioral of Counter is
    signal counter_value : STD_LOGIC_VECTOR(2 downto 0) := "000";
begin
    process(clk, rst, clr)
    begin
		if rising_edge(clk) then
				if  clr = '1' then
					counter_value <= "000";
			  elsif rst = '1' then
					counter_value <= "000";
			  else 
				counter_value <= counter_value + 1;
			  end if;		
		end if;
    end process;

    count <= counter_value;
end Behavioral;
