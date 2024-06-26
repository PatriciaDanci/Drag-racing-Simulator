library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Debouncer is
  port (
    signal btn : in std_logic;
    signal clk : in std_logic;
    signal en : out std_logic
  );

end Debouncer;

architecture Behavioral of Debouncer is
  signal count_int1 : std_logic_vector(31 downto 0) := x"00000000";
  signal Q1 : std_logic;
  signal Q2 : std_logic;
  signal Q3 : std_logic;
begin
  en <= Q2 and (not Q3);
  process (clk)
  begin
    if clk = '1' and clk'event then
      count_int1 <= count_int1 + 1;
    end if;
  end process;
  process (clk)
  begin
    if clk'event and clk = '1' then
      if count_int1(15 downto 0) = "1111111111111111" then
        Q1 <= btn;
      end if;
    end if;
  end process;
  process (clk)
  begin
    if clk'event and clk = '1' then
      Q2 <= Q1;
      Q3 <= Q2;
    end if;
  end process;

end Behavioral;