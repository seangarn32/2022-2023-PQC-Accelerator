library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity fsm_chain is
    port ( 
        clk     : in  std_logic;
        rst     : in  std_logic;
        ena     : in  std_logic;

        dsi_ena : out   std_logic;
        pe_ena  : out   std_logic;
        dso_ena : out   std_logic
    );
end fsm_chain;

architecture rtl of fsm_chain is

    type state_available is (SETUP, DATA_IN, PE, DATA_OUT);  --type of state machine.
    signal state_current    : state_available := SETUP;
    signal state_nxt        : state_available := SETUP;

    signal cnt              : std_logic_vector(7 downto 0);
    signal cnt_ena          : std_logic;
    signal cnt_rst          : std_logic;

begin

    STATE_COUNTER: entity work.counter(rtl)
            port map (
                clk, cnt_rst, cnt_ena, cnt
            );

    process (clk, rst)
    begin
        if (rst = '1') then
            state_current <= SETUP;
        else
            if (rising_edge(clk)) then
                state_current <= state_nxt;
            end if;
        end if;
    end process;

    cnt_rst <= '1' when state_current = SETUP    else '0'; 
    cnt_ena <= '0' when state_current = SETUP    else '1';
    dsi_ena <= '1' when state_current = DATA_IN  else '0';
    pe_ena  <= '1' when state_current = PE       else '0';
    dso_ena <= '1' when state_current = DATA_OUT else '0';

    state_nxt <=  SETUP     when rst = '1' or (state_current = DATA_OUT and cnt = N_SIZE-1)
            else  DATA_IN   when state_current = SETUP and ena = '1'
            else  PE        when state_current = DATA_IN and cnt = N_SIZE-1
            else  DATA_OUT  when state_current = PE and cnt = N_SIZE-1
            else  state_current;

end rtl;
