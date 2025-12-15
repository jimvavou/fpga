library ieee;
use ieee.std_logic_1164.all;

entity tb_hardwired is
end entity;

architecture sim of tb_hardwired is

  -- DUT inputs
  signal ir    : std_logic_vector(3 downto 0) := (others => '0');
  signal clock : std_logic := '0';
  signal reset : std_logic := '1';
  signal z     : std_logic := '0';

  -- DUT outputs
  signal mOPs  : std_logic_vector(26 downto 0);

  constant Tclk : time := 20 ns;

begin

  -- Instantiate DUT (Device Under Test)
  dut: entity work.hardwired
    port map(
      ir    => ir,
      clock => clock,
      reset => reset,
      z     => z,
      mOPs  => mOPs
    );

  -- Clock generator: 20 ns period
  clk_proc: process
  begin
    while now < 1200 ns loop
      clock <= '0'; wait for Tclk/2;
      clock <= '1'; wait for Tclk/2;
    end loop;
    wait;
  end process;

  -- Stimulus process: reset + 6 instructions
  stim_proc: process
  begin
    -- Reset active for 2 cycles
    reset <= '1';
    ir    <= "0000";
    z     <= '0';
    wait for 2*Tclk;     -- 40 ns
    reset <= '0';

    -- Rule: ÎºÏÎ±ÏÎ¬Î¼Îµ ÎºÎ¬Î¸Îµ ÎµÎ½ÏÎ¿Î»Î® 8 ÎºÏÎºÎ»Î¿ÏÏ (T0..T7) => 160 ns

    -- 1) NOP  (ir=0000), z=0
    ir <= "0000"; z <= '0';
    wait for 8*Tclk;

    -- 2) LDAC (ir=0001), z=0
    ir <= "0001"; z <= '0';
    wait for 8*Tclk;

    -- 3) STAC (ir=0010), z=0
    ir <= "0010"; z <= '0';
    wait for 8*Tclk;

    -- 4) JUMP (ir=0101), z=0
    ir <= "0101"; z <= '0';
    wait for 8*Tclk;

    -- 5) JMPZ (ir=0110), Z=1 (ÏÏÏÎµ Î½Î± ÏÎ¬ÎµÎ¹ Î±ÏÏ ÏÎ·Î½ "true" Î´Î¹Î±Î´ÏÎ¿Î¼Î®)
    ir <= "0110"; z <= '1';
    wait for 8*Tclk;

    -- 6) ADD  (ir=1000), z=0
    ir <= "1000"; z <= '0';
    wait for 8*Tclk;

    -- Finish
    wait;
  end process;

end architecture;