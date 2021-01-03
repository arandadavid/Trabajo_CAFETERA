----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.01.2021 18:26:25
-- Design Name: 
-- Module Name: ACOND_INPUT - Behavioral
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



entity ACOND_INPUT is
  Port (
    CLK: in std_logic; --Señal de reloj 100MHz
    RESET_IN: in std_logic; --Señal de RESET
    Boton1, Boton2: in std_logic; --Botones de selección
    Boton_sel_1, Boton_sel_2, reset: out std_logic --Botones de selección sincronizados
  );
end ACOND_INPUT;

architecture structural of ACOND_INPUT is

    COMPONENT sincronizador --Declaración: modulo sincronizador para botón 1
      PORT (
        CLK : in std_logic;
        ASYNC_IN : in std_logic;
        SYNC_OUT : out std_logic
      );
    END COMPONENT;
    
    
    COMPONENT EdgeDetector --Declaración: detector de flanco para botón 1
      PORT (
        CLK : in std_logic;
        SYNC_IN : in std_logic;
        EDGE : out std_logic
      );
    END COMPONENT;
    
    
    signal sync_out1, sync_out2, sync_out_reset: std_logic; 

begin
    
    --Instanciamos los sincronizadores
    Inst_Sincronizador1: sincronizador PORT MAP (
       CLK => CLK,
       ASYNC_IN => Boton1,
       SYNC_OUT => sync_out1
    );
    
    Inst_Sincronizador2: sincronizador PORT MAP (
       CLK => CLK,
       ASYNC_IN => Boton2,
       SYNC_OUT => sync_out2
    );
    
    Inst_Sincronizador_Reset: sincronizador PORT MAP (
       CLK => CLK,
       ASYNC_IN => RESET_IN,
       SYNC_OUT => sync_out_reset
    );
    
    
    --Instanciamos los detectores de flanco
    Inst_EdgeDetector1: EdgeDetector PORT MAP (
       CLK => CLK,
       SYNC_IN => sync_out1,
       EDGE => boton_sel_1
    );
    
    Inst_EdgeDetector2: EdgeDetector PORT MAP (
       CLK => CLK,
       SYNC_IN => sync_out2,
       EDGE => boton_sel_2
    );

    Inst_EdgeDetector_Reset: EdgeDetector PORT MAP (
       CLK => CLK,
       SYNC_IN => sync_out_reset,
       EDGE => reset
    );
end structural;
