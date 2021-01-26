library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FSM is
    generic(
        max: NATURAL := 10
    );
     
    port(
        BOTON_1, BOTON_2: in STD_LOGIC;         --Botones de selección de los modos
        SW_ON: in STD_LOGIC;                    --Interruptor de encendido
        CLK_100MHZ:  in STD_LOGIC;              --Senal de reloj de 100MHz
        CLK_DIV: in STD_LOGIC;                  --Señal de reloj de 1Hz
        RESET_N: in STD_LOGIC;                  --Reset activo a nivel bajo
        ESTADO: out STD_LOGIC_VECTOR(3 downto 0)    --Indica el estado actual
        );
  
end FSM;

architecture behavioral of FSM is
    type ESTADOS is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
    signal estado_actual: ESTADOS;
    signal estado_siguiente: ESTADOS;
    
    subtype contador_t is NATURAL range 0 to max;
    shared VARIABLE segundos_aux: contador_t := 0;  --Señal "segundos_aux" con valor inicial 0       --PRIMER CAMBIO
    
begin
    state_register: process(RESET_N,CLK_100MHZ) begin --Actualizamos el estado
        if(RESET_N = '0') then
            estado_actual <= S0;
        elsif rising_edge(CLK_100MHZ) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
    
    nextstate_decod: process (estado_actual, CLK_DIV, BOTON_1, BOTON_2, SW_ON) begin
        estado_siguiente <= estado_actual;
        case estado_actual is
            when S0 => 
                segundos_aux := 0;
                if(SW_ON = '1') then --Interruptor de encendido
                    estado_siguiente <= S1;
                end if;
            when S1 => 
                if CLK_DIV'event and CLK_DIV = '1' then
                   segundos_aux := segundos_aux + 1;
                end if;
                if segundos_aux > 10 then
                   segundos_aux := 0;
                   estado_siguiente <= S8;           
                elsif(BOTON_1 = '1') then --Si activamos el pulsador asignado a CAFE CORTO
                    estado_siguiente <= S2;
                    segundos_aux := 0;
                elsif(BOTON_2 = '1') then --Si activamos el pulsador asignado a CAFE LARGO
                    estado_siguiente <= S3;
                    segundos_aux  :=  0;
                end if;
            when S2 => 
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux  :=  segundos_aux + 1;
                end if;
                if segundos_aux = 10 then
                    segundos_aux  :=  0;
                    estado_siguiente <= S4;
                end if;
            when S3 =>
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux  :=  segundos_aux + 1;
                end if;
                if segundos_aux = 20 then
                    segundos_aux  :=  0;
                    estado_siguiente  <=  S4;
                end if;
            when S4 =>
                if(BOTON_1 = '1') then --Si pulsamos el botón asignado a LECHE FRÍA
                    estado_siguiente <= S5;
                elsif(BOTON_2 = '1') then --Si pulsamos el botón asignado a LECHE CALIENTE
                    estado_siguiente <= S6;
                end if;
            when S5 => 
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux := segundos_aux + 1;
                end if;
                if segundos_aux = 10 then
                    segundos_aux := 0;
                    estado_siguiente <= S7;
                end if;
            when S6 =>
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux := segundos_aux + 1;
                end if;
                if segundos_aux = 10 then
                    segundos_aux := 0;
                    estado_siguiente <= S7;
                end if;
            when S7 => 
                if CLK_DIV'event and CLK_DIV = '1' then
                    segundos_aux := segundos_aux + 1;
                end if;
                if segundos_aux = 2 then
                    segundos_aux := 0;
                    estado_siguiente <= S0;
                end if;
             when others =>
                segundos_aux := 0;
 
        end case;
    end process;
    
    
    decodificador: process(estado_actual) begin --Decodificador de la salida
        case estado_actual is 
           when S0 => ESTADO <= "0000";
           when S1 => ESTADO <= "0001";          
           when S2 => ESTADO <= "0010"; 
           when S3 => ESTADO <= "0011";
           when S4 => ESTADO <= "0100"; 
           when S5 => ESTADO <= "0101"; 
           when S6 => ESTADO <= "0110";
           when S7 => ESTADO <= "0111"; 
           when others => ESTADO <= "1000";
        end case;
    end process;
    

end behavioral; 
