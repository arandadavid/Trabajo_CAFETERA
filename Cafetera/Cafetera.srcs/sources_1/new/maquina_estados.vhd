library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity maquina_estados is
    port ( 
           RESET_N : in STD_LOGIC;
           CLK : in STD_LOGIC;
           BOTON_1: in STD_LOGIC;
           BOTON_2: in STD_LOGIC;
           SW_ON: in STD_LOGIC;
           ESTADO : out STD_LOGIC_VECTOR (3 downto 0)
           );
end maquina_estados;

architecture behavioral of maquina_estados is
component divisor_frecuencia
    generic(
        max: NATURAL := 10
    );
    port(
        RESET_N: in STD_LOGIC;
        CLK_IN: in STD_LOGIC;
        CLK_OUT: out STD_LOGIC
    );
end component;

component FSM

    port(
        BOTON_1, BOTON_2: in STD_LOGIC;  --Botones de selección de los modos
        SW_ON: in STD_LOGIC;             --Interruptor de encendido
        CLK_100MHZ:  in STD_LOGIC;
        CLK_DIV: in STD_LOGIC;
        RESET_N: in STD_LOGIC;
        ESTADO: out STD_LOGIC_VECTOR(0 to 3)
        );
end component;

signal a: STD_LOGIC;

begin
Inst_divisor_frecuencia: divisor_frecuencia port map(
    RESET_N => RESET_N,
    CLK_IN => CLK,
    CLK_OUT => a
    );

Inst_FSM: FSM port map(
    BOTON_1 => BOTON_1,
    BOTON_2 => BOTON_2,
    SW_ON => SW_ON,
    CLK_100MHZ => CLK,
    CLK_DIV => a,
    RESET_N => RESET_N,
    ESTADO => ESTADO
    );
end behavioral;
