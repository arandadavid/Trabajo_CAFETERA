----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.01.2021 20:10:21
-- Design Name: 
-- Module Name: visualizador - Behavioral
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



entity visualizador is
  Port (
    ESTADO: in std_logic_vector(0 to 3);                                                            --Salida de la máquina de estados
    RESET_N : in STD_LOGIC;                                                                         --Reset activo a nivel bajo
    CLK : in STD_LOGIC;                                                                             --Señal de reloj 100MHz
    disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);     --Displays
    LEDS_VECTOR : out STD_LOGIC_VECTOR(9 downto 0);                                                 --LEDS indicadores del progreso
    LED_ERROR: out std_logic                                                                        --Led activo en caso de error
   );
end visualizador;



architecture Behavioral of visualizador is

    COMPONENT display --Declaración: módulo display
        Port ( 
           reset_n: in STD_LOGIC;
           clk : in STD_LOGIC;
           estado : in STD_LOGIC_VECTOR (3 downto 0);
           disp0 : out STD_LOGIC_VECTOR (6 downto 0);
           disp1 : out STD_LOGIC_VECTOR (6 downto 0);
           disp2 : out STD_LOGIC_VECTOR (6 downto 0);
           disp3 : out STD_LOGIC_VECTOR (6 downto 0);
           disp4 : out STD_LOGIC_VECTOR (6 downto 0); 
           disp5 : out STD_LOGIC_VECTOR (6 downto 0); 
           disp6 : out STD_LOGIC_VECTOR (6 downto 0); 
           disp7 : out STD_LOGIC_VECTOR (6 downto 0)
        );    
    END COMPONENT;
    
    COMPONENT leds --Declaración del módulo leds
        Port ( 
           RESET_N: in STD_LOGIC;                                   --Reset activo a nivel bajo
           CLK : in STD_LOGIC;                                      --Señal de reloj 100MHz
           CLK_DIV: in STD_LOGIC;                                   --Señal de reloj de 1Hz             
           ESTADO : in STD_LOGIC_VECTOR (3 downto 0);               --Salida de la máquina de estados
           LEDS_VECTOR : out STD_LOGIC_VECTOR (9 downto 0);         --LEDS indicadores del progreso
           LED_ERROR: out std_logic                                 --Led activo en caso de error
        );
    END COMPONENT;
    
    COMPONENT divisor_frecuencia
    port(
        RESET_N: in STD_LOGIC;
        CLK_IN: in STD_LOGIC;
        CLK_OUT: out STD_LOGIC
        );
    END COMPONENT;
   
    signal clk_div: std_logic;
    
begin
    --Instanciamos el módulo displays
    Inst_Display: display PORT MAP(
        reset_n => RESET_N,
        clk => CLK,
        estado => ESTADO,
        disp0 => DISP0,
        disp1 => DISP1,
        disp2 => DISP2,
        disp3 => DISP3,
        disp4 => DISP4,
        disp5 => DISP5,
        disp6 => DISP6,
        disp7 => DISP7
    );
    
    --Instanciamos el divisor de frecuencia
    Inst_Divisor: divisor_frecuencia PORT MAP(
        RESET_N => RESET_N,
        CLK_IN => CLK,
        CLK_OUT => clk_div
    );
    
    --Instanciamos el módulo LEDS
    Inst_Leds: leds PORT MAP(
        RESET_N => RESET_N,
        CLK => CLK,
        CLK_DIV => clk_div,             
        ESTADO => ESTADO,
        LEDS_VECTOR => LEDS_VECTOR,
        LED_ERROR => LED_ERROR             
    );

end Behavioral;
