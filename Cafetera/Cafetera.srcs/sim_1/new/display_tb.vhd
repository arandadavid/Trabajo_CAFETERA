library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity display_tb is
end;

architecture bench of display_tb is

  component display
      Port ( 
             clk : in STD_LOGIC;
             estado : in STD_LOGIC_VECTOR (3 downto 0);
             disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);
             reset_n: in STD_LOGIC
             );
  end component;
  
  --Inputs
  signal clk: STD_LOGIC;
  signal reset_n: STD_LOGIC;
  signal estado: STD_LOGIC_VECTOR (3 downto 0);
  --Outputs
  signal disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7: STD_LOGIC_VECTOR (6 downto 0);
  --Periodo del reloj 100MHz
  constant clk_period: time := 100 ns;


begin

  uut: display
   port map ( 
        clk       => clk,
        estado    => estado,
        disp0     => disp0,
        disp1     => disp1,
        disp2     => disp2,
        disp3     => disp3,
        disp4     => disp4,
        disp5     => disp5,
        disp6     => disp6,
        disp7     => disp7,
        reset_n => reset_n
    );
                          
  clock: process
  begin 
    clk <= '0';
     wait for clk_period;
    clk <='1';
    wait for clk_period;
  end process;
  
  stimulus: process
  begin
    
    reset_n <= '1';
    estado <= "0000";
    wait for 200 ns;
    
    estado <="0001" after 100 ns;
    wait for 200 ns;
    
    estado <= "0100" after 100 ns;
    wait for 200 ns;
    
    estado <="1000" after 100 ns;
    wait for 200 ns;
    
    estado <="1111" after 100 ns;
    wait for 200 ns;
   
    assert false
       report "[SUCCESS]: simulation finished."
       severity failure;
   end process;
  
  end architecture;
