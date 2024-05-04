----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2023 05:01:10 PM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
  port (
    --Input: 
    clk : in std_logic;
    btnC : in std_logic;
    btnU : in std_logic;
    btnD : in std_logic;
    switch : in std_logic;

    --Output:
    cat : out std_logic_vector(6 downto 0);
    an : out std_logic_vector(7 downto 0);
    led : out std_logic_vector(1 downto 0)
  );
end FSM;

architecture Behavioral of FSM is

  type state is (idle, start, player_1, race1, player_2, race2, winner);
  signal current_state : state := idle;
  signal next_state : state := idle;

  signal timerP1 : std_logic_vector(15 downto 0) := (others => '0');
  signal timerP2 : std_logic_vector(15 downto 0) := (others => '0');

  signal enableP1 : std_logic := '0';
  signal enableP2 : std_logic := '0';

  signal speedP1 : std_logic_vector(2 downto 0) := (others => '0');
  signal speedP2 : std_logic_vector(2 downto 0) := (others => '0');

  signal speedClkP1 : std_logic := '0';
  signal speedClkP2 : std_logic := '0';

  signal finishP1 : std_logic := '0';
  signal finishP2 : std_logic := '0';

begin

  Timer_Player1 : entity WORK.Timer
    port map(
      clk => clk,
      enable => enableP1,
      timer => timerP1
    );

  Timer_Player2 : entity WORK.Timer
    port map(
      clk => clk,
      enable => enableP2,
      timer => timerP2
    );

  SpeedControllerP1 : entity WORK.SpeedController
    port map(
      clk => clk,
      clutch => switch,
      up => btnU,
      down => btnD,
      enable => enableP1,
      car_speed => speedP1
    );

  SpeedControllerP2 : entity WORK.SpeedController
    port map(
      clk => clk,
      clutch => switch,
      up => btnU,
      down => btnD,
      enable => enableP2,
      car_speed => speedP2
    );

  FreqDividerP1 : entity WORK.FreqDivider
    port map(
      clk => clk,
      intensity => speedP1, --intensity
      new_clk => speedClkP1 --new_clk
    );

  FreqDividerP2 : entity WORK.FreqDivider
    port map(
      clk => clk,
      intensity => speedP2,
      new_clk => speedClkP2
    );

  SSDPlayer1 : entity WORK.SSD
    port map(
      clk => speedClkP1, --new_clk
      enable => enableP1,
      en => finishP1,
      cat => cat,
      an => an
    );

  SSDPlayer2 : entity WORK.SSD
    port map(
      clk => speedClkP2,
      enable => enableP2,
      en => finishP2,
      cat => cat,
      an => an
    );

  process (clk, btnC)
  begin
    case current_state is
      when idle =>
        if btnC = '1' then
          next_state <= player_1;
        else
          next_state <= idle;
        end if;

      when player_1 =>
        if btnC = '1' then
          next_state <= race1;
        else
          next_state <= player_1;
        end if;

      when race1 =>
        if (finishP1 = '1') then --when the race is over
          enableP1 <= '0';
          next_state <= player_2;
        else
          enableP1 <= '1';
          next_state <= race1;
        end if;

      when player_2 =>
        if btnC = '1' then
          next_state <= race2;
        else
          next_state <= player_2;
        end if;

      when race2 =>
        if (finishP2 = '1') then
          enableP2 <= '0';
          next_state <= winner;
        else
          enableP2 <= '1';
          next_state <= race2;
        end if;

      when others => 
        if btnC = '1' then
            next_state <= idle;
        else
            if timerP1 > timerP2 then
                led(0) <= '1';
            elsif timerP2 > timerP1 then
                led(1) <= '1';
            else
                led <= "11";
            end if;
            next_state <= winner;
        end if;

    end case;
  end process;

end Behavioral;