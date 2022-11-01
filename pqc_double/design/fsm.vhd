library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity fsm is
    port ( 
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;

        dsi_ena     : out   std_logic;
        pe_ena      : out   std_logic;
        accum_ena   : out   std_logic;
        dso_ena     : out   std_logic
    );
end fsm;

architecture rtl of fsm is

    type state_available is (SETUP, DATA_IN, PE_PIPE, DATA_OUT);  --type of state machine.
    signal state            : state_available := SETUP;
    
    signal count            : std_logic_vector(COUNTER_SIZE-1 downto 0);
    signal counter_ena      : std_logic := '0';
    signal counter_rst      : std_logic := '1';

begin

    STATE_COUNTER: entity work.counter(rtl)
            port map (
                clk, counter_rst, counter_ena, count
            );

    process (clk)
    begin

        if rising_edge(clk) then

            if (rst='1') then
                state <= SETUP;
            else
                case state is

                    when SETUP =>
                        dsi_ena <= '0';
                        pe_ena <= '0';
                        accum_ena <= '0';
                        dso_ena <= '0';
                        counter_ena <= '0';
                        counter_rst <= '1';
                        if(ena = '1') then
                            state <= DATA_IN;
                        end if;

                    when DATA_IN =>
                        if(count = N_SIZE-1) then
                            dsi_ena <= '0';
                            pe_ena <= '1';
                            counter_rst <= '1';
                            state <= PE_PIPE;
                        else
                            dsi_ena <= '1';
                            counter_ena <= '1';
                            counter_rst <= '0';
                        end if;

                    when PE_PIPE =>
                        if(count = PE_SIZE + N_SIZE / (PE_SIZE * 2) -1) then
                            pe_ena <= '0';
                            counter_rst <= '1';
                            state <= DATA_OUT;
                        else
                            if(count > PE_SIZE) then
                                accum_ena <= '1';
                            else
                                accum_ena <= '0';
                            end if;
                            dsi_ena <= '0';
                            pe_ena <= '1';
                            counter_rst <= '0';
                        end if;

                    when DATA_OUT =>
                        if(count = N_SIZE-1) then
                            dso_ena <= '0';
                            counter_rst <= '1';
                            state <= SETUP;
                        else
                            pe_ena <= '0';
                            accum_ena <= '0';
                            dso_ena <= '1';
                            counter_rst <= '0';
                        end if;

                end case;
            end if;
        end if;
    end process;

end rtl;
