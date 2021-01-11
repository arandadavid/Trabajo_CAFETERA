library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity divisor_frecuencia is
    generic(
        max: NATURAL := 10
            );
    port(
        RESET_N: in STD_LOGIC;
        CLK_IN: in STD_LOGIC;
        CLK_OUT: out STD_LOGIC
        );
end divisor_frecuencia;

architecture behavioral of divisor_frecuencia is
    subtype contador_t is natural range 0 to max;
    signal contador: contador_t;  --Se�al "contador" con valor inicial 0	
begin
    divisor: process(CLK_IN,RESET_N) --Cada 10 pulsos de reloj "normal" da un pulso el reloj dividido
  begin
    if RESET_N = '0' then  --Si la se�al de reset vale 1
      contador <= 0;  --A la se�al "contador" se le asigna el valor 0
      CLK_OUT <= '0';  --A la se�al "clk_dividido" se le asigna el valor 0
    elsif CLK_IN'event and CLK_IN = '1' then  --Si hay un flanco positivo en la entrada clk o clk=1
      if contador >= max - 1 then  --Si la se�al "contador" es mayor o igual que max-1=9
        CLK_OUT <= '1';  --A la se�al "clk_dividido" se le asigna el valor 1
        contador <= 0;  --A la se�al "contador" se le asigna el valor 0
      else  --Si no se cumple ninguno de los dos casos anteriores
        CLK_OUT <= '0';  ----Al reloj dividido" se le asigna el valor 0
        contador <=contador + 1;  --La se�al contador incrementa en 1 su valor
      end if;
    end if;
  end process;  
end behavioral;    