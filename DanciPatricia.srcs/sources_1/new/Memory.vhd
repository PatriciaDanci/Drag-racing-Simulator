----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2023 07:44:21 PM
-- Design Name: 
-- Module Name: Memory - Behavioral
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Single_port_RAM_VHDL is
    port (
        clk : in std_logic;
        reset : in std_logic;
        address : in std_logic_vector(6 downto 0);
        data_in : in std_logic_vector(7 downto 0);
        write_enable : in std_logic;
        data_out : out std_logic_vector(7 downto 0)
    );
end Single_port_RAM_VHDL;

architecture Behavioral of Single_port_RAM_VHDL is
    type RAM_ARRAY is array (0 to 127) of std_logic_vector(7 downto 0);
    signal RAM : RAM_ARRAY := (
        x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", 
        others => (others => '0')
    );
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
               
                RAM <= (
                    x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00", 
                    others => (others => '0')
                );
            elsif write_enable = '1' then
                
                RAM(to_integer(unsigned(address))) <= data_in;
            end if;
        end if;
    end process;
    
    data_out <= RAM(to_integer(unsigned(address)));
end Behavioral;