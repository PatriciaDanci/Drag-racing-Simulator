----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2023 06:12:49 PM
-- Design Name: 
-- Module Name: Timer - Behavioral
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
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Timer is
  port (

    clk : in std_logic;
    enable : in std_logic;

    timer : out std_logic_vector(15 downto 0)

  );
end Timer;

architecture Behavioral of Timer is
  signal clk_div : std_logic := '0';
  signal counter : integer := 0;
  signal cnt: std_logic_vector(15 downto 0) := (others => '0');

begin

  process (clk)
  begin
    if clk = '1' and clk'event then
      if counter < 24999999 then
        counter <= counter + 1;
      else
        counter <= 0;
        clk_div <= not(clk_div);
      end if;
    end if;
  end process;
  process (clk_div, enable)
  begin
    if (enable = '1') then
      if (rising_edge(clk_div)) then
        if (cnt < "1111111111111111") then
          cnt <= cnt + 1;
        else
          cnt <= (others => '0');
        end if;
      end if;
    end if;
  end process;

  timer <= cnt;

end Behavioral;