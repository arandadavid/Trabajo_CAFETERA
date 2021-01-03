library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FSM_tb is
end FSM_tb;

architecture tb of FSM_tb is
component FSM
    port(
        SW_ON: in STD_LOGIC;
        BOTON_1, BOTON_2: in STD_LOGIC;
        CLK:  in STD_LOGIC;
        RESET_N: in STD_LOGIC;
        ESTADO: out STD_LOGIC_VECTOR(0 to 3)
        );
end component;
    signal SW_ON: STD_LOGIC;
    signal BOTON_1, BOTON_2: STD_LOGIC;
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
uut: FSM
    port map(
        SW_ON => SW_ON,
        BOTON_1 => BOTON_1,
        BOTON_2 => BOTON_2,
        CLK => CLK,
        RESET_N => RESET_N,
        ESTADO => ESTADO
        );
CLK <= not CLK after 10 ns;
estimulos: process
begin
	SW_ON <= '1' after 10 ns;
	   wait for 20 ns;
    BOTON_1 <= '1';
    BOTON_1 <= '0' after 40 ns;
wait;
end process;  

end tb;
    

