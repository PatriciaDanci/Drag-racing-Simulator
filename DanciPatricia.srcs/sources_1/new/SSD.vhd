----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2023 03:39:19 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
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

entity SSD is
  port (
    --Input
    clk : in std_logic;
    enable : in std_logic;
    --Output
    en : out std_logic;
    cat : out std_logic_vector(6 downto 0);
    an : out std_logic_vector(7 downto 0)
  );
end SSD;

architecture Behavioral of SSD is

  signal selection: std_logic_vector(2 downto 0) := (others => '0');
begin

  cat <= "0111111";

  process (clk, enable)
  begin
    if (enable = '1') then
      if (rising_edge(clk)) then
        if (selection< "111") then
          selection<= selection + 1;
        else
          selection<= (others => '0');
        end if;
      end if;

      case selection is
        when "000" => an <= "01111111";
          en <= '0';
        when "001" => an <= "10111111";
          en <= '0';
        when "010" => an <= "11011111";
          en <= '0';
        when "011" => an <= "11101111";
          en <= '0';
        when "100" => an <= "11110111";
          en <= '0';
        when "101" => an <= "11111011";
          en <= '0';
        when "110" => an <= "11111101";
          en <= '0';
        when others => an <= "11111110";
          en <= '1';
      end case;
    end if;
  end process;

end Behavioral;