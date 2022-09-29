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
        dso_ena     : out   std_logic;

        sel : out mux_sel_array
    );
end fsm;

architecture rtl of fsm is

    type state_available is (SETUP, DATA_IN, PE_PIPE, DATA_OUT);  --type of state machine.
    signal state            : state_available := SETUP;
    
    signal count            : std_logic_vector(COUNTER_SIZE-1 downto 0);
    signal counter_ena      : std_logic := '0';
    signal counter_rst      : std_logic := '1';

    signal sel_hold         : mux_sel_array := (others =>(others => '0'));
    signal sel_nxt          : mux_sel_array;

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

                        sel_hold <= (others =>(others => '0'));

                        if(ena = '1') then
                            state <= DATA_IN;
                        end if;

                    when DATA_IN =>
                        dsi_ena <= '1';
                        counter_ena <= '1';
                        counter_rst <= '0';

                        if(count = N_SIZE-1) then
                            counter_rst <= '1';
                            state <= PE_PIPE;
                        end if;
     

                    when PE_PIPE =>
                        dsi_ena <= '0';
                        pe_ena <= '1';
                        counter_rst <= '0';
                        
                        if(counter_rst = '0') then
                            sel_hold <= sel_nxt;
                        end if;

                        if(count > MUX_NUM-2) then
                            if(count = MUX_NUM+DIVIDE-2) then
                                counter_rst <= '1';
                                state <= DATA_OUT;
                            end if;
                            accum_ena <= '1';
                        else
                            accum_ena <= '0';
                        end if;

                    when DATA_OUT =>
                        pe_ena <= '0';
                        accum_ena <= '0';
                        dso_ena <= '1';
                        counter_rst <= '0';

                        if(count = N_SIZE-1) then
                            counter_rst <= '1';
                            dso_ena <= '0';
                            state <= SETUP;
                        end if;

                end case;
            end if;
        end if;
    end process;
    
    sel_nxt(0) <= sel_hold(0) when sel_hold(0) = MUX_SIZE-1 
                  else sel_hold(0) + '1';
    SEL_GEN : for i in 1 to MUX_NUM-1 generate
        sel_nxt(i) <= sel_hold(i-1);
    end generate SEL_GEN;

    sel <= sel_hold;

end rtl;
