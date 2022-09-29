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
    signal state_nxt        : state_available;
    
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
                counter_rst <= '1';
            else
                if(state = PE_PIPE) then
                    sel_hold <= sel_nxt;
                    if(count = MUX_NUM+DIVIDE-1) then
                        counter_rst <= '1';
                    else
                        counter_rst <= '0';
                    end if;
                else
                    counter_rst <= '0';
                    sel_hold <= (others =>(others => '0'));
                end if;
                state <= state_nxt;
            end if;
        end if;
    end process;

    state_nxt <= SETUP      when rst = '1' or ena = '0'
            else DATA_IN    when state = SETUP and ena = '1'
            else PE_PIPE    when state = DATA_IN and (count = N_SIZE-1 or counter_rst = '1')
            else DATA_OUT   when state = PE_PIPE and (count = MUX_NUM+DIVIDE-1 or counter_rst = '1')
            else SETUP      when state = DATA_OUT and count = N_SIZE-1
            else state;

    counter_ena <= '0' when state = SETUP else '1';
    dsi_ena     <= '1' when state = DATA_IN else '0';
    pe_ena      <= '1' when state = PE_PIPE else '0';
    accum_ena   <= '1' when state = PE_PIPE and (sel_hold(MUX_NUM-2) = "1" or count > MUX_NUM) else '0';
    dso_ena     <= '1' when state = DATA_OUT else '0';
    

    sel_nxt(0) <= sel_hold(0) when sel_hold(0) = MUX_SIZE-1 else sel_hold(0) + '1';
    SEL_GEN : for i in 1 to MUX_NUM-1 generate
        sel_nxt(i) <= sel_hold(i-1);
    end generate SEL_GEN;
    sel <= sel_hold;

end rtl;
