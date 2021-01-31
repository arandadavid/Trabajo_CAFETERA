library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity TOP_display is
    port(
        RESET_N: in STD_LOGIC;
        CLK: in STD_LOGIC;
        ESTADO: in STD_LOGIC_VECTOR(3 downto 0);
        IMAGEN: out STD_LOGIC_VECTOR(6 downto 0);
        SEGCTRL: out STD_LOGIC_VECTOR(7 downto 0)
        );
end TOP_display;

architecture top of TOP_display is
component display is
    port ( 
           reset_n: in STD_LOGIC;
           clk : in STD_LOGIC;
           estado : in STD_LOGIC_VECTOR (3 downto 0);
           disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0)
     );    
end component;

component ACOND_display is
        port (
            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
            CLK: in STD_LOGIC;
            display: out STD_LOGIC_VECTOR(6 downto 0);
            segctrl: out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

signal d0, d1, d2, d3, d4, d5, d6, d7 : STD_LOGIC_VECTOR (6 downto 0);

begin
Inst_display: display port map(
    reset_n => RESET_N,
    clk => CLK,
    estado => ESTADO,
    disp0 => d0,
    disp1 => d1,
    disp2 => d2, 
    disp3 => d3, 
    disp4 => d4,
    disp5 => d5,
    disp6 => d6,
    disp7 => d7
    );

Inst_ACOND: ACOND_display port map(
    CLK => CLK,
    display => IMAGEN,
    segctrl => SEGCTRL,
    disp0 => d0,
    disp1 => d1,
    disp2 => d2, 
    disp3 => d3, 
    disp4 => d4,
    disp5 => d5,
    disp6 => d6,
    disp7 => d7
    );
end top;
