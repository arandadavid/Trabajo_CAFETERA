----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.01.2021 23:06:21
-- Design Name: 
-- Module Name: visualizador_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity visualizador_tb is
end visualizador_tb;

architecture Behavioral of visualizador_tb is

    component visualizador
        port(
            ESTADO: in std_logic_vector(0 to 3);                                                            --Salida de la máquina de estados
            RESET_N : in STD_LOGIC;                                                                         --Reset activo a nivel bajo
            CLK : in STD_LOGIC;                                                                             --Señal de reloj 100MHz
            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);     --Displays
            LEDS_VECTOR : out STD_LOGIC_VECTOR(9 downto 0);                                                 --LEDS indicadores del progreso
            LED_ERROR: out std_logic
        );
    end component;
    
    --Inputs
    signal RESET_N: std_logic;
    signal CLK: std_logic; 
    signal ESTADO: std_logic_vector (3 downto 0);
    --Outputs
    signal disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 :  STD_LOGIC_VECTOR (6 downto 0);
    signal LEDS_VECTOR :  std_logic_vector (9 downto 0);
    signal LED_ERROR:  std_logic;
    
    --Periodo de reloj 100MHz
    constant CLK_PERIOD : time := 10ns; 
    
begin

    uut : visualizador
    port map (
        RESET_N => RESET_N,
        CLK => CLK,          
        ESTADO => ESTADO,
        LEDS_VECTOR => LEDS_VECTOR,
        LED_ERROR => LED_ERROR,
        disp0 => DISP0,
        disp1 => DISP1,
        disp2 => DISP2,
        disp3 => DISP3,
        disp4 => DISP4,
        disp5 => DISP5,
        disp6 => DISP6,
        disp7 => DISP7
    );
    
    clkgen: process --Generamos la señal de reloj 100MHz
    begin
      CLK <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
    tester: process
    begin
        RESET_N <= '1';
        ESTADO <= "0000";
        wait for 40ns;
        
        ESTADO <= "0010";
        wait for 800ns;
        
        ESTADO <= "0001";
        wait for 400ns;
        
        ESTADO <= "0011";
        wait for 1000ns;
        
        ESTADO <= "1000";
        wait for 100ns;
        
        RESET_N <= '0';
        wait for 200ns;
          
        
        ASSERT false
            REPORT "Simulacin finalizada. Test superado."
            SEVERITY FAILURE;
        
    end process;

end Behavioral;
