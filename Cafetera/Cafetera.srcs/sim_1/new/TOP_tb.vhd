----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2021 18:17:54
-- Design Name: 
-- Module Name: TOP_tb - Behavioral
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



entity TOP_tb is
end TOP_tb;

architecture Behavioral of TOP_tb is

    component top
        port(
            CLK: in std_logic;             --Señal de reloj 100MHz
            RESET_N: in std_logic;        --Señal de RESET
            SW_ON: in STD_LOGIC;           --Botón de encendido
            Boton1, Boton2: in std_logic;  --Botones de selección                
           --Outputs                           
            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);     --Displays
            LEDS_VECTOR : out STD_LOGIC_VECTOR(9 downto 0);                                                 --LEDS indicadores del progreso
            LED_ERROR: out std_logic                                                                        --Led activo en caso de error
        );
    end component;
    
    --Inputs
    signal RESET_N: std_logic;
    signal CLK: std_logic; 
    signal SW_ON: std_logic;
    signal boton1, boton2: std_logic;
    --Outputs
    signal disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 :  STD_LOGIC_VECTOR (6 downto 0);
    signal LEDS_VECTOR :  std_logic_vector (9 downto 0);
    signal LED_ERROR:  std_logic;
    
    --Periodo de reloj 100MHz
    constant CLK_PERIOD : time := 10ns; 

begin

    uut: top 
    port map(
        RESET_N => RESET_N,
        CLK => CLK,   
        SW_ON => SW_ON,
        BOTON1 => BOTON1,
        BOTON2 => BOTON2,       
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
        RESET_N <= '0', '1' after 20ns;
        wait for 10ns;
        
        SW_ON <= '1'; --Encendemos la cafetera. 
        wait for 100ns;
        
        Boton1 <= '1', '0' after 30ns;
        
        wait for 1500ns;
        Boton2 <= '1', '0' after 20ns;
        
        wait for 1200ns;
        
        reset_n <= '0';
        wait for 10*CLK_PERIOD;
        
                
        ASSERT false
            REPORT "Simulacin finalizada. Test superado."
            SEVERITY FAILURE;
        
    end process;


end Behavioral;
