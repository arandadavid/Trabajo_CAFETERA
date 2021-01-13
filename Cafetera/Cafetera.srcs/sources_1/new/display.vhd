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
 type ESTADOS is (S0, S1, S2, S3, S4, S5, S6, S7);
    signal estado_actual: ESTADOS;
    signal estado_siguiente: ESTADOS;
begin  
  state_register: process(RESET_N,CLK) 
  begin --Actualizamos el estado
        if(RESET_N = '0') then
            estado_actual <= S0;
        elsif rising_edge(CLK) then
            estado_actual <= estado_siguiente;
        end if;
    end process;

  mostrar_display: process(reset_n, clk)
   begin
   if reset_n = '1' then
    if rising_edge(clk) then
    case estado is
     when "0000" => --S0
       -- HOLA
       disp0 <= "1001000";
       disp1 <= "1000000";
       disp2 <= "1110001";
       disp3 <= "0001000";
     when "0001" => --S1
       -- 1-C
       disp0 <= "1001111";
       disp1 <= "0000001";
       disp2 <= "0110001";
       -- 2-L
       disp4 <= "0010010";
       disp5 <= "0000001";
       disp6 <= "1110001";    
     when "0100" => --S4
      -- 1-C
       disp0 <= "1001111";
       disp1 <= "0000001";
       disp2 <= "0110001";
      -- 2-F
       disp4 <= "0010010";
       disp5 <= "0000001";
       disp6 <= "0111000"; 
      when others =>
       disp0 <= "0000000";
       disp1 <= "0000000";
       disp2 <= "0000000";
       disp3 <= "0000000";
       disp4 <= "0000000";
       disp5 <= "0000000";
       disp6 <= "0000000";
       disp7 <= "0000000";
        
     end case;
     end if;
    end if;
   end process;
end;

