----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.01.2021 17:35:11
-- Design Name: 
-- Module Name: TOP - Behavioral
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
use ieee.numeric_std.ALL;


entity TOP is
  Port (
    CLK: in std_logic;             --Señal de reloj 100MHz
    RESET_N: in std_logic;        --Señal de RESET
    SW_ON: in STD_LOGIC;           --Botón de encendido
    Boton1, Boton2: in std_logic;  --Botones de selección                
        --Outputs                           
--    disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);     --Displays
    DISPLAY: out STD_LOGIC_VECTOR(6 downto 0);                                                      --Displays
    SEG_CONTROL: out STD_LOGIC_VECTOR(7 downto 0);                                                  --ANODO DE CONTROL
    LEDS_VECTOR : out STD_LOGIC_VECTOR(9 downto 0);                                                 --LEDS indicadores del progreso
    LED_ERROR: out std_logic                                                                        --Led activo en caso de error
  );
end TOP;

architecture Behavioral of TOP is

    component acond_input  --Declación: acondicionamiento de la entrada
      Port (
            CLK: in std_logic; --Señal de reloj 100MHz
            RESET_IN: in std_logic; --Señal de RESET
            Boton1, Boton2: in std_logic; --Botones de selección
            Boton_sel_1, Boton_sel_2: out std_logic --Botones de selección sincronizados
      );
    end component;
    
    component maquina_estados
      generic(
        Tiempo_M1: NATURAL:= 10; --Tiempo asignado al modo 1
        Tiempo_M2: NATURAL:= 20  --Tiempo asignado al modo 2
      );
      port ( 
            RESET_N : in STD_LOGIC;
            CLK : in STD_LOGIC;
            BOTON_1: in STD_LOGIC;
            BOTON_2: in STD_LOGIC;
            SW_ON: in STD_LOGIC;
            ESTADO : out STD_LOGIC_VECTOR (3 downto 0)
      );
    end component;
    
    component visualizador
      Port (
            ESTADO: in std_logic_vector(0 to 3);                                                            --Salida de la máquina de estados
            RESET_N : in STD_LOGIC;                                                                         --Reset activo a nivel bajo
            CLK : in STD_LOGIC;                                                                             --Señal de reloj 100MHz
--            disp0, disp1, disp2, disp3, disp4, disp5, disp6, disp7 : out STD_LOGIC_VECTOR (6 downto 0);     --Displays
            DISPLAY: out STD_LOGIC_VECTOR(6 downto 0);                                                      --Displays
            SEG_CONTROL: out STD_LOGIC_VECTOR(7 downto 0);                                                  --ANODO DE CONTROL
            LEDS_VECTOR : out STD_LOGIC_VECTOR(9 downto 0);                                                 --LEDS indicadores del progreso
            LED_ERROR: out std_logic                                                                        --Led activo en caso de error
      );
    end component;
    
    signal b1_sinc, b2_sinc: std_logic;
    signal estado: std_logic_vector (3 downto 0);
    
begin

    Inst_acondicionador: acond_input PORT MAP(
        CLK => CLK,
        RESET_IN => RESET_N,
        Boton1 => Boton1,
        Boton2 => Boton2,
        Boton_sel_1 => b1_sinc,
        Boton_sel_2 => b2_sinc
    );
    
    Inst_maquina_estados : maquina_estados PORT MAP(
        RESET_N => reset_n,
        CLK => CLK,
        BOTON_1 => b1_sinc,
        BOTON_2 => b2_sinc,
        SW_ON => SW_ON,
        ESTADO => estado
    );
    
    Inst_visualizador: visualizador PORT MAP(
        ESTADO => estado,                                                                       
        RESET_N => reset_n,                                                                      
        CLK => CLK,                                                                              
        DISPLAY => DISPLAY,
        SEG_CONTROL => SEG_CONTROL,
        LEDS_VECTOR => LEDS_VECTOR,
        LED_ERROR => LED_ERROR
    );

end Behavioral;
