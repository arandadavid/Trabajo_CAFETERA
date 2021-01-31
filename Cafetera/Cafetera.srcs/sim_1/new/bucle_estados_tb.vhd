library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity bucle_estados_tb is
end bucle_estados_tb;

architecture tb of bucle_estados_tb is
component bucle_estados is
    port(
        clk_div: IN STD_LOGIC;
        salida_estados: OUT STD_LOGIC_VECTOR(2 downto 0)
        );
end component;

signal clk_div: STD_LOGIC;
signal salida_estados: STD_LOGIC_VECTOR(2 downto 0);

begin
    uut: bucle_estados
    port map(
        clk_div => clk_div,
        salida_estados => salida_estados
        );
    estimulos: process begin
        clk_div <= '0';
            wait for 20 ns;
        clk_div <= '1';
            wait for 10 ns;
        clk_div <= '0';
            wait for 20 ns;
        clk_div <= '1';
            wait for 10 ns;
        clk_div <= '0';
    end process;
end tb;
