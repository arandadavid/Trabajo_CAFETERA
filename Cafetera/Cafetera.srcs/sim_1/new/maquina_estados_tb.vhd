library ieee;
use ieee.std_logic_1164.all;

entity maquina_estados_tb is
end maquina_estados_tb;

architecture tb of maquina_estados_tb is

    component maquina_estados
        port (RESET_N: in std_logic;
              CLK: in std_logic;
              BOTON_1: in STD_LOGIC;
              BOTON_2: in STD_LOGIC;
              SW_ON: in STD_LOGIC;
              ESTADO: out std_logic_vector (0 to 3)
         );
    end component;
    
    --Inputs
    signal RESET_N: std_logic;
    signal CLK: std_logic := '0';
    signal BOTON_1: STD_LOGIC;
    signal BOTON_2: STD_LOGIC;
    signal SW_ON: STD_LOGIC;
    --Outputs
    signal ESTADO: std_logic_vector (0 to 3);
    --Periodo de reloj 100MHz
    constant CLK_PERIOD : time := 10ns;  


begin

    uut : maquina_estados
    port map (
              RESET_N   => RESET_N,
              CLK       => CLK,
              BOTON_1   => BOTON_1,
              BOTON_2   => BOTON_2,
              SW_ON     => SW_ON,
              ESTADO    => ESTADO
              );

    clkgen: process --Generamos la señal de reloj
    begin
      CLK <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
    
    estimulo: process 
    begin
       
        RESET_N <= '0', '1' after 10ns;
        wait for 10 ns;
        
        SW_ON <= '1';
            wait for 40 ns;
        BOTON_1 <= '1';
            wait for 10 ns;
        BOTON_1 <= '0';
            wait for 400 ns;
        BOTON_2 <= '1';
            wait for 10 ns;
        BOTON_2 <= '0';
        RESET_N <= '0' after 600 ns;
       
        
        ASSERT false
            REPORT "Simulacin finalizada. Test superado."
            SEVERITY FAILURE;
               
    end process;
end tb;
