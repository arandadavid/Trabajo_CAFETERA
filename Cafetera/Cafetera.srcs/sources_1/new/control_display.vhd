library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity control_display is
    generic(var: BIT := '0');
    port ( 
        bucle_estados : in STD_LOGIC_VECTOR (2 downto 0);
        seg_ctrl : out STD_LOGIC_VECTOR (7 downto 0)
        );
end control_display;

architecture behavioral of control_display is
begin
    process(bucle_estados)
    variable seg_aux: STD_LOGIC_VECTOR(seg_ctrl'range);
	begin
	   case bucle_estados is
	       when "000" => seg_aux := "00000001";
	       when "001" => seg_aux := "00000010";
	       when "010" => seg_aux := "00000100";
	       when "011" => seg_aux := "00001000";
	       when "100" => seg_aux := "00010000";
	       when "101" => seg_aux := "00100000";
	       when "110" => seg_aux := "01000000";
	       when others => seg_aux := "10000000";
	   end case;
            if(var = '0') then
            seg_ctrl <= not(seg_aux); -- Salida negada, pues para activar el nodo hay aplicar un 0
            end if;
    end process;
end behavioral;