library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FSM_tb is
end FSM_tb;

architecture tb of FSM_tb is

    component FSM
         port(
           BOTON_1, BOTON_2: in STD_LOGIC;         --Botones de selección de los modos
           SW_ON: in STD_LOGIC;                    --Interruptor de encendido
           CLK_100MHz:  in STD_LOGIC;              --Senal de reloj de 100MHz
           CLK_DIV: in STD_LOGIC;                  --Señal de reloj de 1Hz
           RESET_N: in STD_LOGIC;                  --Reset activo a nivel bajo
           ESTADO: out STD_LOGIC_VECTOR(3 downto 0)    --Indica el estado actual
        );
    end component;
    
    --Inputs
    signal SW_ON: STD_LOGIC;
    signal BOTON_1, BOTON_2: STD_LOGIC;
    signal CLK_100MHz: STD_LOGIC;
    signal CLK_DIV: std_logic;
    signal RESET_N: STD_LOGIC;
    --Output
    signal ESTADO: STD_LOGIC_VECTOR(3 downto 0);
    
    --Periodo de reloj 100MHz
    constant CLK_PERIOD : time := 10ns; 
    --Periodo de reloj CLK_DIV
    constant CLK_PERIOD_DIV : time := 100ns;

begin
    uut: FSM
       port map(
            SW_ON => SW_ON,
            BOTON_1 => BOTON_1,
            BOTON_2 => BOTON_2,
            CLK_100MHz => CLK_100MHz,
            CLK_DIV => CLK_DIV,
            RESET_N => RESET_N,
            ESTADO => ESTADO
            );
        
    clkgen: process --Generamos la señal de reloj 100MHz
    begin
      CLK_100MHz <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK_100MHz <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
    clkgen_div: process --Generamos la señal de reloj 10MHz
    begin
      CLK_DIV <= '0';
      wait for 0.5 * CLK_PERIOD_DIV;
      CLK_DIV <= '1';
      wait for 0.5 * CLK_PERIOD_DIV;
    end process;

    estimulos: process
    begin
        reset_n <= '0', '1' after CLK_PERIOD;
        SW_ON <= '1' after 10 ns;
           wait for 100 ns;
        BOTON_1 <= '1';
        BOTON_1 <= '0' after 10 ns;
        
        for i in 0 to 30 loop
           wait until CLK_100MHz ='0';
        end loop;
        
        BOTON_2 <= '1', '0' after 10ns;
        wait for 4*CLK_PERIOD;
        --RESET_N <= '0';
        
        for i in 0 to 12 loop
           wait until CLK_100MHz ='0';
        end loop;
        
        assert false
            report "[SUCCESS], simulation finished"
            severity failure;
        
        end process;  
    end tb;



