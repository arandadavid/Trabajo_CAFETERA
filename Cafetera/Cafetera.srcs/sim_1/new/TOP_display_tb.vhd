library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity TOP_display_tb is
end TOP_display_tb;

architecture tb of TOP_display_tb is
component TOP_display is
    port ( 
            RESET_N: in STD_LOGIC;
            CLK: in STD_LOGIC;
            ESTADO: in STD_LOGIC_VECTOR(3 downto 0);
            IMAGEN: out STD_LOGIC_VECTOR(6 downto 0);
            SEGCTRL: out STD_LOGIC_VECTOR(7 downto 0)
            );
end component;

signal RESET_N: STD_LOGIC;
signal CLK: STD_LOGIC;
signal ESTADO: STD_LOGIC_VECTOR(3 downto 0);
signal IMAGEN: STD_LOGIC_VECTOR(6 downto 0);
signal SEGCTRL: STD_LOGIC_VECTOR(7 downto 0);

--Periodo de reloj 100MHz
constant CLK_PERIOD : time := 10ns; 

begin
    uut: TOP_display
        port map(
            RESET_N => RESET_N,
            CLK => CLK,
            ESTADO => ESTADO,
            IMAGEN => IMAGEN,
            SEGCTRL => SEGCTRL
            );
            
clkgen: process --Generamos la señal de reloj 100MHz
    begin
      CLK <= '0';
      wait for 0.5 * CLK_PERIOD;
      CLK <= '1';
      wait for 0.5 * CLK_PERIOD;
    end process;
    
tester: process
begin
    RESET_N <= '0', '1' after 20ns;
    wait for 10ns;
    
    ESTADO <= "0000"; 
    wait for 100ns;
    
    ESTADO <= "0001"; 
    wait for 100ns;
    
    ESTADO <= "0100"; 
    wait for 100ns;
    
    ESTADO <= "1111";
    wait for 100ns;
    
    wait for 1200ns;
    
    RESET_N <= '0';
    wait for 10*CLK_PERIOD;
    
          
    ASSERT false
        REPORT "Simulacin finalizada. Test superado."
        SEVERITY FAILURE;
    
end process;

end tb;
