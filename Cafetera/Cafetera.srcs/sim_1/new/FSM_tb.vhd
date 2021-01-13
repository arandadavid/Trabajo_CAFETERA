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
    
    --Inputs
    signal SW_ON: STD_LOGIC;
    signal BOTON_1, BOTON_2: STD_LOGIC;
    signal CLK: STD_LOGIC := '0';
    signal RESET_N: STD_LOGIC := '1';
    signal ESTADO: STD_LOGIC_VECTOR(0 to 3);
    signal CLK_state : STD_LOGIC := '0';
    signal count: INTEGER := 0;
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
        
CLK <= not CLK after 50 ns;
        
estimulos: process
begin
	SW_ON <= '1' after 10 ns;
	   wait for 100 ns;
    BOTON_1 <= '1';
    BOTON_1 <= '0' after 10 ns;
 --   SW_ON <= '0';
 --   RESET_N <= '1';
    wait;
end process;  
end tb;



