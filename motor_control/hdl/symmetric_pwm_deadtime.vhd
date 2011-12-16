-------------------------------------------------------------------------------
-- Title      : Symmetric PWM with Deadtime generation
-- Project    : Loa
-------------------------------------------------------------------------------
-- File       : symmetric_pwm_deadtime.vhd
-- Author     : Fabian Greif  <fabian.greif@rwth-aachen.de>
-- Company    : Roboterclub Aachen e.V.
-- Created    : 2011-12-16
-- Last update: 2011-12-16
-- Platform   : Spartan 3-400
-------------------------------------------------------------------------------
-- Description:
--
-- Deadtime for on and off can be specified separately.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package symmetric_pwm_deadtime_pkg is

  component symmetric_pwm_deadtime is
    generic (
      WIDTH  : natural;
      T_DEAD : natural);
    port (
      lowside_p  : out std_logic;
      highside_p : out std_logic;
      center_p   : out std_logic;
      clk_en_p   : in  std_logic;
      value_p    : in  std_logic_vector (WIDTH - 1 downto 0);
      reset      : in  std_logic;
      clk        : in  std_logic);
  end component symmetric_pwm_deadtime;

end package symmetric_pwm_deadtime_pkg;

-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library work;
use work.symmetric_pwm_pkg.all;
use work.deadtime_pkg.all;

entity symmetric_pwm_deadtime is
  generic (
    WIDTH  : natural := 12;  -- Number of bits used for the PWM (12bit => 0..4095)
    T_DEAD : natural         -- Defines the duration of the dead-time
   -- inserted between the complementary outputs (in clock cycles of 'clk').
    );
  port (
    lowside_p  : out std_logic;         -- PWM output
    highside_p : out std_logic;         -- inverted PWM output

    center_p : out std_logic;  -- PWM is in the middle of the 'on'-periode
    clk_en_p : in  std_logic;           -- clock enable
    value_p  : in  std_logic_vector (WIDTH - 1 downto 0);

    reset : in std_logic;               -- High active, Restarts the PWM period
    clk   : in std_logic
    );
end symmetric_pwm_deadtime;

architecture structural of symmetric_pwm_deadtime is
  signal pwm   : std_logic;
  signal pwm_n : std_logic;

  signal lowside_center  : std_logic;
  signal highside_center : std_logic;
begin

  pwm_generator : symmetric_pwm
    generic map (
      WIDTH => WIDTH)
    port map (
      pwm_p       => pwm,
      underflow_p => lowside_center,
      overflow_p  => highside_center,
      clk_en_p    => clk_en_p,
      value_p     => value_p,
      reset       => reset,
      clk         => clk);

  pwm_n <= not pwm;

  deadtime_on : deadtime
    generic map (
      T_DEAD => T_DEAD)
    port map (
      in_p  => pwm,
      out_p => lowside_p,
      clk   => clk);

  deadtime_off : deadtime
    generic map (
      T_DEAD => T_DEAD)
    port map (
      in_p  => pwm_n,
      out_p => highside_p,
      clk   => clk);

  -- The deadtime generation delays the PWM output. To keep the center_p signal
  -- synchron is has also to be delayed.
  process
    variable go    : std_logic                           := '0';  -- Delay has started
    variable delay : integer range 0 to (T_DEAD / 2) - 1 := 0;
  begin
    wait until rising_edge(clk);

    if go = '0' then
      center_p <= '0';
      if lowside_center = '1' then
        go    := '1';
        delay := 0;
      end if;
    else
      if delay < (T_DEAD / 2) - 1 then
        delay := delay + 1;
      else
        center_p <= '1';
        go       := '0';
      end if;
    end if;
  end process;
end architecture structural;
