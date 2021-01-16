library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity display is
    Port ( 
           reset_n: in STD_LOGIC;
           clk : in STD_LOGIC;
           estado : in STD_LOGIC_VECTOR (3 downto 0);
           disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0)
     );    
end display;
           
architecture behavioral of display is
begin  

  mostrar_display: process(reset_n, clk)
   begin
   if reset_n = '1' then
    if rising_edge(clk) then
    case estado is
     when "0000" => --S0
       -- HOLA
       disp0 <= "1001000"; --H
       disp1 <= "0000001"; --O
       disp2 <= "1110001"; --L
       disp3 <= "0001000"; --A
       disp4 <= "1111111";
       disp5 <= "1111111";
       disp6 <= "1111111";
       disp7 <= "1111111";
     when "0001" => --S1
       -- 1-C
       disp0 <= "1001111"; --1
       disp1 <= "1111110"; --
       disp2 <= "0110001"; --C
       disp3 <= "1111111";
       -- 2-L
       disp4 <= "0010010"; --2
       disp5 <= "1111110"; --
       disp6 <= "1110001"; --L
       disp7 <= "1111111";   
     when "0100" => --S4
      -- 1-C
       disp0 <= "1001111"; --1
       disp1 <= "1111110"; --
       disp2 <= "0110001"; --C
       disp3 <= "1111111";
      -- 2-F
       disp4 <= "0010010"; --2
       disp5 <= "1111110"; --
       disp6 <= "1000111"; --F
       disp7 <= "1111111";
      when others =>
       disp0 <= "1111111";
       disp1 <= "1111111";
       disp2 <= "1111111";
       disp3 <= "1111111";
       disp4 <= "1111111";
       disp5 <= "1111111";
       disp6 <= "1111111";
       disp7 <= "1111111";   
      end case;
     end if;
    end if;
   end process;
end;

