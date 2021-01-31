library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity display2segm is
    port ( 
        disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
        estado: in STD_LOGIC_VECTOR(2 downto 0);
        segment: out STD_LOGIC_VECTOR(6 downto 0)
        );
end display2segm;

architecture Behavioral of display2segm is
begin
    process(disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7, estado)
		begin
			case estado IS
				when "000" => segment <= disp0;
				when "001" => segment <= disp1;
				when "010" => segment <= disp2;
				when "011" => segment <= disp3;
				when "100" => segment <= disp4;
				when "101" => segment <= disp5;
				when "110" => segment <= disp6;
				when others => segment <= disp7;
			end case;
		end process;

end Behavioral;
