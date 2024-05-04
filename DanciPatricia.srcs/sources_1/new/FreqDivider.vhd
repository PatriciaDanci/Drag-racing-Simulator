----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 07:29:57 PM
-- Design Name: 
-- Module Name: FrequencyDivider - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FreqDivider is
  port (
    signal clk : in std_logic;
    signal intensity: in std_logic_vector(2 downto 0); --car speed selection
    signal new_clk : out std_logic
  );
end FreqDivider;

architecture Behavioral of FreqDivider is

  signal counter : integer := 0;
  signal time_clk: integer := 99999999;
  signal clk_div : std_logic;

begin

   time_clk <= 99999999 when intensity="000" else -- 100 000 000 1s     --0     49999999
                 74999999 when intensity="001" else --  75 000 000 0.75s  --1     24999999
                 49999999 when intensity="010" else --  50 000 000 0.5s   --2
                 24999999 when intensity="011" else --  25 000 000 0.25s  --3
                  9999999 when intensity="100" else --  10 000 000 0.1s   --4
                  7499999 when intensity="101" else --   7 500 000 0.075s --5
                  499999 when intensity="110" else  --   5 000 000 0.05s  --6
                  249999;                             --   2 500 000 0.025s --7

  process (clk, time_clk)
  begin
    if clk = '1' and clk'event then
      if counter <  time_clk then 
        counter <= counter + 1;
      else
        counter <= 0;
        clk_div <= not(clk_div);
      end if;
    end if;
  end process;

  new_clk <= clk_div;

end Behavioral;