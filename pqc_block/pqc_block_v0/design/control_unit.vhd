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

        dso_count   : in    std_logic_vector(COUNTER_SIZE_B-1 downto 0);

        a_selout    : out   std_logic_vector(A_INDEX_SIZE-1 downto 0);

        dsi_ena     : out   std_logic;
        pe_ena      : out   std_logic;
        accum_ena   : out   std_logic;
        dso_ena     : out   std_logic;

        a_val_index_out : out   std_logic_vector(7 downto 0);
        b_val_index_out : out   std_logic_vector(7 downto 0);
        z_val_index_out : out   std_logic_vector(7 downto 0);
        o_val_index_out : out   std_logic_vector(7 downto 0)
    );
end control_unit;

architecture rtl of control_unit is

    type state_available is (SETUP, DSI, B_LOAD, PE_PIPE, PE_ACCUM, DSO);
    signal state            : state_available := SETUP;
    signal state_nxt        : state_available;

    signal dsi_ena_hold     : std_logic;
    signal dso_ena_hold     : std_logic;
    
    signal count            : std_logic_vector(COUNTER_SIZE_A-1 downto 0);
    signal count_nxt        : std_logic_vector(COUNTER_SIZE_A-1 downto 0);

    signal a_sel            : std_logic_vector(A_INDEX_SIZE-1 downto 0);
    signal a_sel_nxt        : std_logic_vector(A_INDEX_SIZE-1 downto 0);

    signal count_a_sel      : std_logic_vector(COUNTER_SIZE_B-1 downto 0);
    signal count_a_sel_nxt  : std_logic_vector(COUNTER_SIZE_B-1 downto 0);

    signal a_val_index      : std_logic_vector(7 downto 0);
    signal a_val_index_nxt  : std_logic_vector(7 downto 0);
    signal b_val_index      : std_logic_vector(7 downto 0);
    signal b_val_index_nxt  : std_logic_vector(7 downto 0);
    signal z_val_index      : std_logic_vector(7 downto 0);
    signal z_val_index_nxt  : std_logic_vector(7 downto 0);
    signal z_ena            : std_logic;
    signal o_val_index      : std_logic_vector(7 downto 0);
    signal o_val_index_nxt  : std_logic_vector(7 downto 0);
    signal o_ena            : std_logic;

begin

    count_nxt <= count + '1' when (state = DSO and count < ROWS) -- Should it be COLS-1?
                               or (state = DSI and count < N_SIZE-1)
                               or (state = PE_PIPE and count < COLS-1)
                               or (state = PE_ACCUM and count < NUM_A_SECTIONS-1)
                             else (others => '0');

    state_nxt <= SETUP      when (state = DSO and count = ROWS) 
            else DSI        when (state = SETUP and ena = '1' and rst = '0')
            else PE_PIPE    when (state = DSI and count = N_SIZE-1)
            else PE_ACCUM   when (state = PE_PIPE and count = COLS-1)
            else DSO        when (state = PE_ACCUM and count = NUM_A_SECTIONS-1)
            else state;

    dsi_ena_hold    <= '1' when state = DSI else '0';
    dsi_ena         <= dsi_ena_hold;
    pe_ena          <= '1' when (state = PE_PIPE or state = PE_ACCUM) else '0';
    accum_ena       <= '1' when state = PE_ACCUM else '0';
    -- Should it be NUM_B_SECTIONS-1 ??
    dso_ena_hold    <= '1' when (state = DSO or (state = PE_ACCUM and count > 0)) else '0';
    dso_ena         <= dso_ena_hold;

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

    count_a_sel_nxt <= count_a_sel + '1' when (state = PE_PIPE or state = PE_ACCUM) 
                                          and (count_a_sel < NUM_B_SECTIONS-1)
                                         else (others => '0'); 
    a_sel_nxt <= a_sel - ROWS when (state = PE_PIPE or state = PE_ACCUM)
                               and (count_a_sel = NUM_B_SECTIONS-1)
                              else (a_sel);
    
    process (clk)
    begin
        if rising_edge(clk) then
            if (rst = '1' or ena = '0') then
                count_a_sel <= (others => '0');
                a_sel <= std_logic_vector(to_unsigned(N_SIZE-1, A_INDEX_SIZE));
            else 
                count_a_sel <= count_a_sel_nxt;
                a_sel <= a_sel_nxt;
            end if;
        end if;
    end process;

    a_selout <= a_sel;

    a_val_index_nxt <= a_val_index + '1' when dsi_ena_hold = '1' and count < N_SIZE-1 else (others=>'0');
    b_val_index_nxt <= b_val_index + '1' when dsi_ena_hold = '1' and count < N_SIZE-1 else (others=>'0');
    z_val_index_nxt <= z_val_index + '1' when z_ena = '1' else (others=>'0');
    o_val_index_nxt <= o_val_index + '1' when o_ena = '1' else (others=>'0');

    process (clk)
    begin
        if rising_edge(clk) then
            if(rst = '1') then
                a_val_index <= (others=>'0');
                b_val_index <= (others=>'0');
                z_val_index <= (others=>'0');
                z_ena <= '0';
                o_val_index <= (others=>'0');
                o_ena <= '0';
            else
                if(ena = '1') then
                    if(dso_ena_hold = '1') then
                        if(z_ena = '1') then
                            o_ena <= '1';
                        end if;
                        if(dso_count = NUM_B_SECTIONS-1) then
                        z_ena <= '1';
                        end if;
                    else
                        z_ena <= '0';
                        o_ena <= '0';
                    end if;
                    a_val_index <= a_val_index_nxt;
                    b_val_index <= b_val_index_nxt;
                    z_val_index <= z_val_index_nxt;
                    o_val_index <= o_val_index_nxt;
                end if;
            end if;
        end if;
    end process;

    a_val_index_out <= a_val_index;
    b_val_index_out <= b_val_index;
    z_val_index_out <= z_val_index;
    o_val_index_out <= o_val_index;

end rtl;
