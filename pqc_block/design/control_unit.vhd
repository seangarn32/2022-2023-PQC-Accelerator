library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity control_unit is
    port ( 
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;

        dsi_ena     : out   std_logic;
        bl_ena      : out   std_logic;
        pe_ena      : out   std_logic;
        accum_ena   : out   std_logic;
        dso_ena     : out   std_logic
    );
end control_unit;

architecture rtl of control_unit is

    type state_available is (SETUP, DSI, B_LOAD, PE_PIPE, PE_ACCUM, DSO);
    signal state            : state_available := SETUP;
    signal state_nxt        : state_available;
    
    signal count            : std_logic_vector(COUNTER_SIZE_FSM-1 downto 0);
    signal count_nxt        : std_logic_vector(COUNTER_SIZE_FSM-1 downto 0);

begin

    count_nxt <= count + '1' when (state = DSO and count < N_SIZE-1)
                               or (state = DSI and count < N_SIZE-1)
                               or (state = PE_PIPE and count < COLS-1)
                               or (state = PE_ACCUM and count < NUM_A_SECTIONS-1)
                             else (others => '0');

    state_nxt <= SETUP      when (state = DSO and count = N_SIZE-1) 
            else DSI        when (state = SETUP and ena = '1' and rst = '0')
            else B_LOAD     when (state = DSI and count = N_SIZE-1)
            else PE_PIPE    when (state = B_LOAD)
            else PE_ACCUM   when (state = PE_PIPE and count = COLS-1)
            else DSO        when (state = PE_ACCUM and count = NUM_A_SECTIONS-1)
            else state;

    dsi_ena     <= '1' when state = DSI else '0';
    bl_ena      <= '1' when (state = B_LOAD or state = PE_PIPE or state = PE_ACCUM) else '0'; 
    pe_ena      <= '1' when (state = PE_PIPE or state = PE_ACCUM) else '0';
    accum_ena   <= '1' when state = PE_ACCUM else '0';
    dso_ena     <= '1' when (state = DSO or state = PE_ACCUM) else '0';

    process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1' or ena = '0') then
                state <= SETUP;
                count <= (others => '0');
            else
                state <= state_nxt;
                count <= count_nxt;
            end if;
        end if;
    end process;

end rtl;
