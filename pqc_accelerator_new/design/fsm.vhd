library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity fsm is
    port ( 
        clk : in  STD_LOGIC;
        rst : in  STD_LOGIC;
        ena : in  STD_LOGIC;

        dsi_ena : out   std_logic;
        pe_ena  : out   std_logic;
        dso_ena : out   std_logic
    );
end fsm;

architecture rtl of fsm is

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

    process (clk, rst)
    begin
        if falling_edge(clk) then
            if (rst='1') then
                present_state <= SETUP;  --default state on reset.
                counter_reset <= '0';
            else 

                case present_state is

                    when SETUP =>        --when current state is "A"
                        counter_reset <= '1';
                        if(ena = '0') then
                            present_state <= SETUP;
                            dsi_ena <= '0';
                            pe_ena <= '0';
                            dso_ena <= '0';
                        else
                            present_state <= DATA_IN; -- once we flip a switch, it will move to DATA_IN
                            dsi_ena <= '1';
                        end if;  

                    when DATA_IN =>        --when current state is "B"
                        counter_ena <= '1';
                        counter_reset <= '0';
                        if(counter = N_SIZE-1) then
                            present_state <= PE;
                            pe_ena <= '1';
                            dsi_ena <= '0';
                        else
                            present_state<= DATA_IN;
                        end if;

                    when PE =>       --when current state is "C"
                        counter_ena <= '1';
                        if(counter = N_SIZE-1) then
                            present_state <= DATA_OUT;
                            pe_ena <= '0';
                            dso_ena <= '1';
                        else
                            present_state<= PE;
                        end if;

                    when DATA_OUT =>         --when current state is "D"
                        counter_ena <= '1';
                        if(counter = N_SIZE-1) then
                            present_state <= SETUP;
                            dso_ena <= '0';
                        else
                            present_state<= DATA_OUT;
                        end if;
                        
                end case;
            end if;
        end if;
    end process;
end rtl;
