library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity control_display_tb is
end control_display_tb;

architecture tb of control_display_tb is
component control_display is
    port(
        bucle_estados : in STD_LOGIC_VECTOR (2 downto 0);
        seg_ctrl : out STD_LOGIC_VECTOR (7 downto 0)
        );
end component;

signal bucle_estados : STD_LOGIC_VECTOR (2 downto 0);
signal seg_ctrl : STD_LOGIC_VECTOR (7 downto 0);

begin
    uut: control_display
    port map(
        bucle_estados => bucle_estados,
        seg_ctrl => seg_ctrl
        );
    estimulos: process begin
        bucle_estados <= "000";
            wait for 20 ns;
        bucle_estados <= "001";
            wait for 20 ns;
        bucle_estados <= "010";
            wait for 20 ns;
        bucle_estados <= "011";
            wait for 20 ns;
    end process;
end tb;