----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2021 16:00:43
-- Design Name: 
-- Module Name: leds_tb - Behavioral
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
use IEEE.numeric_std.all;



entity leds_tb is
end leds_tb;

architecture Behavioral of leds_tb is

    component leds
        port(
            RESET_N: in STD_LOGIC;                                   --Reset activo a nivel bajo
            CLK : in STD_LOGIC;                                      --Señal de reloj 100MHz
            CLK_DIV: in STD_LOGIC;                                   --Señal de reloj de 1Hz             
            ESTADO : in STD_LOGIC_VECTOR (3 downto 0);               --Salida de la máquina de estados
            LEDS_VECTOR : out STD_LOGIC_VECTOR (9 downto 0);  --LEDS indicadores del progreso
            LED_ERROR: out std_logic   
        );
    end component;
    
    --Inputs
    signal RESET_N: std_logic;
    signal CLK: std_logic;
    signal CLK_DIV: std_logic;
    signal ESTADO: std_logic_vector (3 downto 0);
    --Outputs
    signal LEDS_VECTOR :  std_logic_vector (9 downto 0);
    signal LED_ERROR:  std_logic;
    
    --Periodo de reloj 100MHz
    constant CLK_PERIOD : time := 10ns; 
    --Periodo de reloj CLK_DIV
    constant CLK_PERIOD_DIV : time := 100ns;
    

begin

    uut : leds
    port map (
        RESET_N => RESET_N,
        CLK => CLK,
        CLK_DIV => CLK_DIV,          
        ESTADO => ESTADO,
        LEDS_VECTOR => LEDS_VECTOR,
        LED_ERROR => LED_ERROR
    );


    clkgen: process --Generamos la señal de reloj 100MHz
    begin
      CLK <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
    clkgen_div: process --Generamos la señal de reloj 10MHz
    begin
      CLK_DIV <= '0';
      wait for 0.5 * CLK_PERIOD_DIV;
      CLK_DIV <= '1';
      wait for 0.5 * CLK_PERIOD_DIV;
    end process;
    
    
    tester: process
    begin
        RESET_N <= '1';
        ESTADO <= "0000";
        wait for 40ns;
        
        ESTADO <= "0010";
        wait for 1000ns;
        
        ESTADO <= "0011";
        wait for 1000ns;
        
        ESTADO <= "1000";
        wait for 100ns;
        
        RESET_N <= '0';
        for i in 0 to 12 loop
          wait until clk ='0';
        end loop;
        
        ASSERT false
            REPORT "Simulacin finalizada. Test superado."
            SEVERITY FAILURE;
        
    end process;

end Behavioral;
