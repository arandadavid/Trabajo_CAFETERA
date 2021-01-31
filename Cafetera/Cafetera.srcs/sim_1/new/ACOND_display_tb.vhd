library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity ACOND_display_tb is
end ACOND_display_tb;

architecture tb of ACOND_display_tb is
component ACOND_display is
        port (
            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : in STD_LOGIC_VECTOR (6 downto 0);
            CLK: in STD_LOGIC;
            display: out STD_LOGIC_VECTOR(6 downto 0);
            segctrl: out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;

signal disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : STD_LOGIC_VECTOR (6 downto 0);
signal CLK: STD_LOGIC;
signal display: STD_LOGIC_VECTOR(6 downto 0);
signal segctrl: STD_LOGIC_VECTOR(7 downto 0);

--Periodo del reloj 100MHz
constant CLK_period: time := 100 ns;

begin
    uut: ACOND_display 
        port map(
        disp0 => disp0,
        disp1 => disp1,
        disp2 => disp2,
        disp3 => disp3,
        disp4 => disp4,
        disp5 => disp5,
        disp6 => disp6,
        disp7 => disp7,
        CLK => CLK,
        display => display,
        segctrl => segctrl
        );
        
clock: process
  begin 
    CLK <= '0';
     wait for CLK_period;
    CLK <='1';
    wait for CLK_period;
  end process;

tester: process
begin     
   disp0 <= "1001000"; --H
   disp1 <= "0000001"; --O
   disp2 <= "1110001"; --L
   disp3 <= "0001000"; --A
   disp4 <= "1111111";
   disp5 <= "1111111";
   disp6 <= "1111111";
   disp7 <= "1111111";
    
    wait for 1200ns;
    
    wait for 10*CLK_period;
    
          
    ASSERT false
        REPORT "Simulacin finalizada. Test superado."
        SEVERITY FAILURE;
    
end process;

end tb;
