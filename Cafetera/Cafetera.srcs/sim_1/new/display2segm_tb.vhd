library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity display2segm_tb is
end display2segm_tb;

architecture tb of display2segm_tb is
component display2segm is
    port(
        disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
        estado: in STD_LOGIC_VECTOR(2 downto 0);
        segment: out STD_LOGIC_VECTOR(6 downto 0)
        );
end component;

signal disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : STD_LOGIC_VECTOR (6 downto 0);
signal estado: STD_LOGIC_VECTOR(2 downto 0);
signal segment: STD_LOGIC_VECTOR(6 downto 0);

begin
    uut: display2segm
    port map(
            disp0 => disp0,
            disp1 => disp1,
            disp2 => disp2,
            disp3 => disp3,
            disp4 => disp4,
            disp5 => disp5,
            disp6 => disp6,
            disp7 => disp7,
            estado => estado,
            segment => segment
        );
    estimulos: process begin
        disp0 <= "0010001";
        disp1 <= "1010010";
        disp2 <= "1110001";
        estado <= "000";
            wait for 20 ns;
        estado <= "001";
            wait for 20 ns;
        estado <= "010";
            wait;
    end process;
end tb;
