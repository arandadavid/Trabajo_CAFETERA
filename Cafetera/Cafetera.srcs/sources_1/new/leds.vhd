----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2021 11:03:49
-- Design Name: 
-- Module Name: leds - Behavioral
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

entity leds is
  generic(
    size : positive := 10;  --Tamaño del array de LEDS  
    max : NATURAL := 20     --Limite de segundos
  );
  Port ( 
    RESET_N: in STD_LOGIC;                                   --Reset activo a nivel bajo
    CLK : in STD_LOGIC;                                      --Señal de reloj 100MHz
    CLK_DIV: in STD_LOGIC;                                   --Señal de reloj de 1Hz             
    ESTADO : in STD_LOGIC_VECTOR (3 downto 0);               --Salida de la máquina de estados
    LEDS_VECTOR : out STD_LOGIC_VECTOR (size - 1 downto 0);  --LEDS indicadores del progreso
    LED_ERROR: out std_logic                                 --Led activo en caso de error
  );
end leds;

architecture Behavioral of leds is
    subtype contador_t is NATURAL range 0 to max;
    signal segundos_aux: contador_t := 0;  --Señal "segundos_aux" con valor inicial 0
begin

    LEDS: process(reset_n, clk, clk_div)
    begin
    
      if RESET_N = '0' then
        segundos_aux <=  0;
        LEDS_VECTOR <= (others => '0');
        LED_ERROR <= '0';     
      else
        case ESTADO is
            when X"2" => --S2
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux <= segundos_aux + 1;
                    LEDS_VECTOR <= (segundos_aux => '1', others => '0');
                end if;
                
                if segundos_aux = 10 then
                    segundos_aux <= 0;
                end if;
                       
            when X"3" => --S3       
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux <= segundos_aux + 1;
                end if;
             
                if segundos_aux mod 2 = 0 then --Si segundos es par
                    LEDS_VECTOR <= ((segundos_aux/2) => '1', others => '0'); 
                end if;
                
                if segundos_aux = 20 then
                    segundos_aux <= 0;
                end if;
                
            when X"5" => --S5                
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux <= segundos_aux + 1;
                    LEDS_VECTOR <= (segundos_aux => '1', others => '0');
                end if;
                
                if segundos_aux = 10 then
                    segundos_aux <= 0;
                end if;
                            
            when X"6" => --S6                            
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux <= segundos_aux + 1;
                end if;
             
                if segundos_aux mod 2 = 0 then --Si segundos es par
                    LEDS_VECTOR <= ((segundos_aux/2) => '1', others => '0'); 
                end if;
                
                if segundos_aux = 20 then
                    segundos_aux <= 0;
                end if;
                                
            when X"8" => --S8
                LEDS_VECTOR <= (others => '0');
                LED_ERROR <= '1';
                segundos_aux <= 0;
            
            when others => 
                segundos_aux <= 0;
                LED_ERROR <= '0';
                LEDS_VECTOR <= (others => '0');
                
            end case;        
      end if;
    end process;

end Behavioral;
