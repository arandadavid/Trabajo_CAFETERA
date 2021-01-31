library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity ACOND_display is
        port (
            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
            CLK: in STD_LOGIC;
            display: out STD_LOGIC_VECTOR(6 downto 0);
            segctrl: out STD_LOGIC_VECTOR(7 downto 0)
        );
end ACOND_display;

architecture top of ACOND_display is
component display2segm is
    port ( 
        disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
        estado: in STD_LOGIC_VECTOR(2 downto 0);
        segment: out STD_LOGIC_VECTOR(6 downto 0)
        );
end component;

component control_display is
    port ( 
        bucle_estados : in STD_LOGIC_VECTOR (2 downto 0);
        seg_ctrl : out STD_LOGIC_VECTOR (7 downto 0)
        );
end component;

component bucle_estados is
    Port ( clk_div : in STD_LOGIC;
           salida_estados : out STD_LOGIC_VECTOR(2 downto 0)
           );
end component;

component divisor_frecuencia is
    generic(
        max: NATURAL := 10
            );
    port(
        RESET_N: in STD_LOGIC;
        CLK_IN: in STD_LOGIC;
        CLK_OUT: out STD_LOGIC
        );
end component;

signal estados_aux: STD_LOGIC_VECTOR(2 downto 0);
signal clk_aux: STD_LOGIC;

begin
Inst_segmentos: display2segm port map (
        disp0 => disp0,
        disp1 => disp1,
        disp2 => disp2,
        disp3 => disp3,
        disp4 => disp4,
        disp5 => disp5,
        disp6 => disp6,
        disp7 => disp7,
        estado => estados_aux,
        segment => display
    );

Inst_control: control_display port map (
        bucle_estados => estados_aux,
        seg_ctrl => segctrl
    );
    
Inst_estados: bucle_estados port map(
        clk_div => clk_aux,
        salida_estados => estados_aux
        );

Inst_divisor: divisor_frecuencia 
    generic map( max => 50000 )
    port map(
        RESET_N => '1',
        CLK_IN => CLK,
        CLK_OUT => clk_aux
        );
end top;
