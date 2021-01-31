library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

-- Se crea un bucle de estados que cambia cada vez que hay un cambio del reloj dividido.
-- Con cada pulso del reloj dividido se le pasa al decodificador un estado que encenderá el display correspondiente
-- Al ser tan rápido se verán todos los display encendidos

entity bucle_estados is
    Port ( clk_div : in STD_LOGIC;
           salida_estados : out STD_LOGIC_VECTOR(2 downto 0)
           );
end bucle_estados;

architecture behavioral of bucle_estados is
signal contador: NATURAL range 0 to 7:=0;
begin
    process(clk_div)
	begin
	   if clk_div = '1' and clk_div'event then
			if contador = 0 then salida_estados<="000";
				contador<=contador + 1 ;
			elsif contador = 1 then 
				salida_estados<="001";
				contador<=contador + 1;
			elsif contador = 2 then
				salida_estados<="010";
				contador<=contador + 1;
		    elsif contador = 3 then 
				salida_estados<="011";
				contador<=contador + 1;
			elsif contador = 4 then
				salida_estados<="100";
				contador<= contador + 1;
		    elsif contador = 5 then 
				salida_estados<="101";
				contador<=contador + 1;
			elsif contador = 6 then 
				salida_estados<="110";
				contador<=contador + 1;
			else 
				salida_estados<="111";
				contador<= 0;
			end if;
		end if;
	end process;

end behavioral;
