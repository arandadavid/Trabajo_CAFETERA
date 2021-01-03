----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.01.2021 21:22:14
-- Design Name: 
-- Module Name: ACOND_INPUT_tb - Behavioral
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


entity ACOND_INPUT_tb is
end ACOND_INPUT_tb;

architecture Behavioral of ACOND_INPUT_tb is

    component ACOND_INPUT
        port(
            CLK: in std_logic; --Señal de reloj 100MHz
            RESET_IN: in std_logic; --Señal de RESET
            Boton1, Boton2: in std_logic; --Botones de selección
            Boton_sel_1, Boton_sel_2, reset: out std_logic --Botones de selección sincronizados
        );
    end component;  
    
    signal CLK, RESET_IN, Boton1, Boton2, Boton_sel_1, Boton_sel_2, reset:  std_logic; 
    
    constant CLK_PERIOD: time := 10ns; --Periodo de la señal de reloj (100MHz)
           
begin

    uut: ACOND_INPUT
    port map (
        CLK => CLK,
        RESET_IN => RESET_IN,
        Boton1 => Boton1,
        Boton2 => Boton2,
        Boton_sel_1 => Boton_sel_1,
        Boton_sel_2 => Boton_sel_2,
        reset => reset
    );
    
    clkgen: process --Señal de reloj
    begin
      CLK <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
    
    
    tester: process
    begin
    
      boton1 <= '1', '0' after 40ns;
      boton2 <= '0';
      RESET_IN <= '0';
      
      wait for 20ns;
      RESET_IN <= '0', '1' after 20ns, '0' after 60 ns;
        
      for i in 0 to 1 loop
          wait for 0.25 * CLK_PERIOD;
          boton2 <= '1';
          wait until clk ='0';
          wait for 0.25 * CLK_PERIOD;
          boton2 <= '0';
      end loop;
      
      wait for 50 ns;
      
      wait until clk ='0';
      boton1 <= '1';
      boton2 <= '1';
      wait for 3 * CLK_PERIOD;
      boton1 <= '0';
      boton2 <= '0';
      
      wait for 50ns;
      
      for i in 0 to 4 loop
        wait until clk ='0';
      end loop;
 
      ASSERT false
             REPORT "Simulacin finalizada. Test superado."
             SEVERITY FAILURE;
     
    end process;


end Behavioral;
