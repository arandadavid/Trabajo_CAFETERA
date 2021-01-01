library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FSM_tb is
end FSM_tb;

architecture tb of FSM_tb is
component FSM
    port(
        SW_SYNC: in STD_LOGIC_VECTOR(0 to 3);
        BOTON_SYNC: in STD_LOGIC;
        CLK:  in STD_LOGIC;
        RESET_N: in STD_LOGIC;
        ESTADO: out STD_LOGIC_VECTOR(0 to 3)
        );
end component;
    signal SW_SYNC: STD_LOGIC_VECTOR(0 to 3);
    signal BOTON_SYNC: STD_LOGIC;
    signal CLK: STD_LOGIC := '0';
    signal RESET_N: STD_LOGIC := '1';
    signal ESTADO: STD_LOGIC_VECTOR(0 to 3);
    type ESTADOS is (S0, S1, S2, S3, S4, S5, S6, S7);
    signal estado_actual: ESTADOS;
    signal estado_siguiente: ESTADOS;
    constant max_count: INTEGER := 50000000; --(100Mhz/2)
    signal count: INTEGER range 0 to max_count;
    signal CLK_state : STD_LOGIC := '0';
    shared variable segundos: INTEGER := 0;
begin
duu: FSM
    port map(
        SW_SYNC => SW_SYNC,
        BOTON_SYNC => BOTON_SYNC,
        CLK => CLK,
        RESET_N => RESET_N,
        ESTADO => ESTADO
        );
CLK <= not CLK after 50 ns;
estimulos: process begin
    BOTON_SYNC <= '1' after 100 ns;
    B
    

