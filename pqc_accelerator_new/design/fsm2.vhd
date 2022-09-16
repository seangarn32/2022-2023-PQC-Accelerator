library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity fsm2 is
    port ( 
        reset : in  STD_LOGIC;
        start : in  STD_LOGIC;
        clk : in  STD_LOGIC
    );
end fsm2;

architecture rtl of fsm2 is

    type state_available is (SETUP, DATA_IN, PE, DATA_OUT);  --type of state machine.
    signal present_state: state_available;
    signal counter: STD_LOGIC_VECTOR(7 downto 0);
    signal counter_ena: STD_LOGIC;
    signal counter_reset: STD_LOGIC;

begin

    STATE_COUNTER: entity work.counter(rtl)
            port map (
                clk, counter_reset, counter_ena, counter
            );

    process (clk, reset)
    begin
        if falling_edge(clk) then
            if (reset='1') then
                present_state <= SETUP;  --default state on reset.
                counter_reset <= '0';
            else 

                case present_state is

                    when SETUP =>        --when current state is "A"
                        counter_reset <= '1';
                        if(start = '0') then
                            present_state <= SETUP;
                        else
                            present_state <= DATA_IN; -- once we flip a switch, it will move to DATA_IN
                        end if;  

                    when DATA_IN =>        --when current state is "B"
                        counter_ena <= '1';
                        counter_reset <= '0';
                        if(counter = N_SIZE-1) then
                            present_state <= PE;
                        else
                            present_state<= DATA_IN;
                        end if;

                    when PE =>       --when current state is "C"
                        counter_ena <= '1';
                        if(counter = N_SIZE-1) then
                            present_state <= DATA_OUT;
                        else
                            present_state<= PE;
                        end if;

                    when DATA_OUT =>         --when current state is "D"
                        counter_ena <= '1';
                        if(counter = N_SIZE-1) then
                            present_state <= SETUP;
                        else
                            present_state<= DATA_OUT;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
end rtl;
