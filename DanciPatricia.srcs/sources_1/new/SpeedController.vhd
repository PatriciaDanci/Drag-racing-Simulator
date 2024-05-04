----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 07:26:50 PM
-- Design Name: 
-- Module Name: SpeedCounter - Behavioral
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

entity SpeedController is
  port (
    -- Inputs
    clk : in std_logic;
    clutch : in std_logic;
    up : in std_logic;
    down : in std_logic;
    enable : in std_logic;
    -- Outputs
    car_speed : out std_logic_vector(2 downto 0)
  );
end entity SpeedController;

architecture Behavioral of SpeedController is

  signal car_speed_reg : std_logic_vector(2 downto 0) := (others => '0');

begin
  process (clk, enable)
  begin
    if enable = '1' then
      if rising_edge(clk) then
        -- Car speed counting
        if clutch = '1' then
          if up = '1' then
            car_speed_reg <= std_logic_vector(unsigned(car_speed_reg));
            car_speed_reg <= car_speed_reg + 1;
          elsif down = '1' then
            car_speed_reg <= std_logic_vector(unsigned(car_speed_reg));
            car_speed_reg <= car_speed_reg - 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  -- Output signals assignment
  car_speed <= car_speed_reg;
end architecture Behavioral;