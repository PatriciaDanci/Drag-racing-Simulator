----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2023 01:53:59 PM
-- Design Name: 
-- Module Name: Nexys4 - Behavioral
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

entity Nexys4 is
  port (

    --INPUT PORTS
    CLK100MHZ : in std_logic;
    BTNC : in std_logic;
    BTNU : in std_logic;
    BTND : in std_logic;
    SWITCH : in std_logic;

    --OUTPUT PORTS
    CAT : out std_logic_vector(6 downto 0);
    AN : out std_logic_vector(7 downto 0);
    LED : out std_logic_vector(1 downto 0)

  );
end Nexys4;

architecture Behavioral of Nexys4 is
  
  signal up: std_logic;
  signal down: std_logic;
  signal start: std_logic;

  signal clk_speed : std_logic;
  signal speed : std_logic_vector(2 downto 0);

begin

    Debouncer_BTNC: entity WORK.Debouncer
    port map(
        btn => BTNC,
        clk => CLK100MHZ,
        en => start
    );

    
    Debouncer_BTND: entity WORK.Debouncer
    port map(
        btn => BTND,
        clk => CLK100MHZ,
        en => down
    );

    
    Debouncer_BTNU: entity WORK.Debouncer
    port map(
        btn => BTNU,
        clk => CLK100MHZ,
        en => up
    );
    
    FSM: entity WORK.FSM 
    port map(
        clk => CLK100MHZ,
        btnU => up,
        btnD => down,
        btnC => start,
        switch => SWITCH,
        cat => CAT,
        an => AN,
        led => LED
    );



end Behavioral;