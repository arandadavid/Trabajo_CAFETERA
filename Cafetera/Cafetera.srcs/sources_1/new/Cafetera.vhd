library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity FSM is
    port(
        SW_SYNC: in STD_LOGIC_VECTOR(0 to 3);
        BOTON_SYNC: in STD_LOGIC;
        CLK:  in STD_LOGIC;
        RESET_N: in STD_LOGIC;
        ESTADO: out STD_LOGIC_VECTOR(0 to 3)
        );
end FSM;

architecture behavioral of FSM is
    type ESTADOS is (S0, S1, S2, S3, S4, S5, S6, S7);
    signal estado_actual: ESTADOS;
    signal estado_siguiente: ESTADOS;
    constant max_count: INTEGER := 50000000; --(100Mhz/2)
    signal count: INTEGER range 0 to max_count;
    signal CLK_state : STD_LOGIC := '0';
    shared variable segundos: INTEGER := 0;
begin
    state_register: process(RESET_N,CLK) begin
        if(RESET_N = '0') then
            estado_actual <= S0;
        elsif rising_edge(CLK) then
            estado_actual <= estado_siguiente;
        end if;
    end process;
    
    nextstate_decod: process (SW_SYNC, BOTON_SYNC, estado_actual, CLK_state) begin
        estado_siguiente <= estado_actual;
        case estado_actual is
            when S0 => 
                if(BOTON_SYNC = '1') then
                    estado_siguiente <= S1;
                end if;
            when S1 => 
                if(SW_SYNC(0) = '1') then --Si activamos el SW asignado a CAFE CORTO
                    estado_siguiente <= S2;
                elsif(SW_SYNC(1) = '1') then --Si activamos el SW asignado a CAFE LARGO
                    estado_siguiente <= S3;
                end if;
            when S2 => 
                segundos := 0;
                while segundos < 10 loop
                    if CLK_state'event and CLK = '1' then
                        segundos := segundos + 1;
                    end if;
                end loop;
                estado_siguiente <= S4;
            when S3 =>
                segundos := 0;
                while segundos < 20 loop
                    if CLK_state'event and CLK = '1' then
                        segundos := segundos + 1;
                    end if;
                end loop;
                estado_siguiente <= S4;
            when S4 =>
                if(SW_SYNC(3) = '1') then --Si activamos el SW asignado a LECHE FR�A
                    estado_siguiente <= S5;
                elsif(SW_SYNC(4) = '1') then --Si activamos el SW asignado a LECHE CALIENTE
                    estado_siguiente <= S6;
                end if;
            when S5 => 
                segundos := 0;
                while segundos < 10 loop
                    if CLK_state'event and CLK = '1' then
                        segundos := segundos + 1;
                    end if;
                end loop;
                estado_siguiente <= S7;
            when S6 =>
                segundos := 0;
                while segundos < 20 loop
                    if CLK_state'event and CLK = '1' then
                        segundos := segundos + 1;
                    end if;
                end loop;
                estado_siguiente <= S7;
            when S7 => 
                segundos := 0;
                while segundos < 15 loop
                    if CLK_state'event and CLK = '1' then
                        segundos := segundos + 1;
                    end if;
                end loop;
             when others =>
                if RESET_N = '0' then
                    estado_siguiente <= S0;
                end if;
        end case;
    end process;
    
    decodificador: process(estado_actual) begin
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
    
    temporizador: process(CLK) begin
        if CLK'event and CLK = '1' then
            if (count<max_count) then
                count <= count + 1;
            else 
                CLK_state <= not CLK_state;
                count <= 0;
            end if;
        end if;
    end process;
end behavioral; 
