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
        enc_dec : in std_logic;

        dsi_ena : out   std_logic;
        load_a_rst  : out   std_logic;
        load_a_ena  : out   std_logic;
        load_b_rst  : out   std_logic;
        load_b_ena  : out   std_logic;
        pe_ena      : out   std_logic;
        accum_ena   : out   std_logic;
        dso_ena     : out   std_logic;
        dso_rst     : out   std_logic;
        err_ena     : out   std_logic;

        a_index_out : out   std_logic_vector(7 downto 0) := (others=>'0');
        b_index_out : out   std_logic_vector(7 downto 0) := (others=>'0');
        p_index_out : out   std_logic_vector(7 downto 0) := (others=>'0');
        c_out_0_index_out : out   std_logic_vector(7 downto 0) := (others=>'0');
        c_out_1_index_out : out   std_logic_vector(7 downto 0) := (others=>'0');
        out_ena     : out   std_logic
    );
end fsm;

architecture rtl of fsm is

    type state_available is (SETUP, DATA_IN, PE_PIPE, DATA_OUT, FINISHED);  --type of state machine.
    signal state            : state_available := SETUP;
    signal state_nxt        : state_available;
    
    signal count            : std_logic_vector(COUNTER_SIZE downto 0);
    signal count_nxt        : std_logic_vector(COUNTER_SIZE downto 0);
    signal counter_ena      : std_logic := '0';
    signal counter_rst      : std_logic := '1';

    signal a_index_val      : std_logic_vector(7 downto 0) := (others=>'0');
    signal b_index_val      : std_logic_vector(7 downto 0) := (others=>'0');
    signal p_index_val      : std_logic_vector(7 downto 0) := (others=>'0');
    signal a_index_val_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal b_index_val_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal p_index_val_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_out_0_index_val : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_out_1_index_val : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_out_0_index_val_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_out_1_index_val_hold : std_logic_vector(7 downto 0) := (others=>'0');
begin

    count_nxt <= count + '1' when (state = DATA_OUT and count < N_SIZE + 1) -- Should it be COLS-1?
                               or (state = DATA_IN and count < N_SIZE + 1)
                               or (state = PE_PIPE and ((count < PE_SIZE + (N_SIZE/PE_SIZE) + 1 and enc_dec = '0') 
                                                     or (count < PE_SIZE + N_SIZE / (PE_SIZE * 2) + 2 and enc_dec = '1')))
                             else (others => '0');

    state_nxt <= SETUP      when (state = FINISHED) 
                             else DATA_IN    when (state = SETUP and ena = '1' and rst = '0')
                             else PE_PIPE    when (state = DATA_IN and count = N_SIZE + 1)
                             else DATA_OUT   when (state = PE_PIPE and ((count = PE_SIZE + (N_SIZE/PE_SIZE) + 1 and enc_dec = '0') 
                                                                     or (count = PE_SIZE + N_SIZE / (PE_SIZE * 2) + 2 and enc_dec = '1')))
                             else FINISHED   when (state = DATA_OUT and count = N_SIZE + 1)
                             else state;
    
    -- DSI
    dsi_ena <= '1'      when (state = DATA_IN and count < N_SIZE) else '0';
    a_index_val_hold <= a_index_val + '1' when (state = DATA_IN and count < N_SIZE);
    b_index_val_hold <= b_index_val + '1' when (state = DATA_IN and count < N_SIZE);
    p_index_val_hold <= p_index_val + '1' when (state = DATA_IN and count < N_SIZE);
    out_ena <= '1'          when ((state = DATA_IN and count < N_SIZE + 1) 
                                  or (state = DATA_OUT and count < N_SIZE + 1)) else '0';
    load_a_rst <= '1'       when (state = DATA_IN and count = N_SIZE) else '0';
    load_b_rst <= '1'       when (state = DATA_IN and count = N_SIZE) else '0';
    

    -- PE PIPE
    accum_ena <= '1'        when (state = PE_PIPE and ((count >= PE_SIZE + 1 and count <= PE_SIZE + (N_SIZE/PE_SIZE) and enc_dec = '0') 
                                                    or (count >= PE_SIZE + 1 and count <= PE_SIZE + (N_SIZE/(PE_SIZE * 2)) and enc_dec = '1'))) else '0';
    pe_ena <= '1'           when (state = PE_PIPE and ((count /= PE_SIZE + (N_SIZE/PE_SIZE) + 1 and enc_dec = '0')
                                                    or (count /= PE_SIZE + N_SIZE / (PE_SIZE * 2) + 2 and enc_dec = '1'))) else '0';
    load_a_ena <= '1'       when (state = PE_PIPE and ((count < (N_SIZE / PE_SIZE) and enc_dec = '0')
                                                    or (count < (N_SIZE / (PE_SIZE * 2)) and enc_dec = '1'))) else '0';
    load_b_ena <= '1'       when (state = PE_PIPE and ((count < (N_SIZE / PE_SIZE) and enc_dec = '0') 
                                                    or (count < (N_SIZE / (PE_SIZE * 2)) and enc_dec = '1'))) else '0';
    dso_rst <= '1'     when (state = PE_PIPE and ((count = PE_SIZE + (N_SIZE/PE_SIZE) + 1 and enc_dec = '0') 
                                                    or (count = PE_SIZE + N_SIZE / (PE_SIZE * 2) + 2 and enc_dec = '1'))) else '0';
    
    -- DSO
    dso_ena <= '1'     when (state = DATA_OUT and count < N_SIZE) else '0';
    err_ena <= '1'          when (state = DATA_OUT and count < N_SIZE + 1) else '0';
    c_out_0_index_val_hold <= c_out_0_index_val + '1' when (state = DATA_OUT and count < N_SIZE);
    c_out_1_index_val_hold <= c_out_1_index_val + '1' when (state = DATA_OUT and count < N_SIZE);


    process (clk)
        begin
            if rising_edge(clk) then
                if (rst = '1' or ena = '0') then
                    state <= SETUP;
                    count <= (others => '0');

                    a_index_out <= (others=>'0');
                    b_index_out <= (others=>'0');
                    p_index_out <= (others=>'0');
                    
                else
                    state <= state_nxt;
                    count <= count_nxt;

                    a_index_out <= a_index_val_hold;
                    b_index_out <= b_index_val_hold;
                    p_index_out <= p_index_val_hold;
                    c_out_0_index_out <= c_out_0_index_val_hold;
                    c_out_1_index_out <= c_out_1_index_val_hold;
                end if;
            end if;
    end process;
end rtl;
