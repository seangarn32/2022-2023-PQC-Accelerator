library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic;
        B_in    : in    std_logic_vector(7 downto 0);
        P_in    : in    std_logic_vector(7 downto 0);

        e1      : in    std_logic;
        e2      : in    std_logic;
        c2      : in    std_logic;

        C_out_0   : out   std_logic_vector(7 downto 0);
        C_out_1   : out   std_logic_vector(7 downto 0);

        a_index_out : out   std_logic_vector(7 downto 0);
        b_index_out : out   std_logic_vector(7 downto 0);
        p_index_out : out   std_logic_vector(7 downto 0);

        c_out_0_index_out : out   std_logic_vector(7 downto 0);
        c_out_1_index_out : out   std_logic_vector(7 downto 0);

        C_out_error_0     : out   std_logic_vector(7 downto 0);
        C_out_error_1     : out   std_logic_vector(7 downto 0);

        out_ena     : out   std_logic
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal A            : std_logic_vector(N_SIZE-1 downto 0);
    signal A0           : a_vector;
    signal B            : b_matrix;
    signal B0           : b_hold_matrix;
    signal P            : b_matrix;
    signal P0            : b_hold_matrix;
    signal C_0            : c_matrix;
    signal C_1            : c_matrix;
    signal C_accum_0      : c_matrix;
    signal C_accum_1      : c_matrix;
    signal C_accum_2      : c_matrix;

    signal dsi_ena      : std_logic;
    signal load_a_rst   : std_logic;
    signal load_a_ena   : std_logic;
    signal load_b_rst   : std_logic;
    signal load_b_ena   : std_logic;
    signal pe_ena       : std_logic;
    signal accum_ena    : std_logic;
    signal dso_ena      : std_logic;
    signal dso_rst      : std_logic;
    signal err_ena      : std_logic;

    signal C_out_0_hold : std_logic_vector(7 downto 0);
    signal C_out_1_hold : std_logic_vector(7 downto 0);

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

    DSI : entity work.data_shift_in(rtl)
        port map(
            clk,
            rst,
            dsi_ena,

            A_in,
            B_in,
            P_in,

            A,
            B,
            P
        );
    
    LOAD_A : entity work.load_a(rtl)
        port map(
            clk,
            load_a_rst,
            load_a_ena,
            enc_dec,
            A,

            A0
        );

    LOAD_B : entity work.load_b(rtl)
        port map(
            clk,
            load_b_rst,
            load_b_ena,
            enc_dec,
            B,
            P,

            B0,
            P0
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,
            enc_dec,

            A0,
            B0,
            P0,

            C_0,
            C_1
        );

    ACCUM : entity work.accumulator_cell(rtl)
        port map(
            clk,
            rst,
            accum_ena,

            C_0,
            C_1,

            C_accum_0,
            C_accum_1,
            C_accum_2
        );

    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            dso_rst,
            dso_ena,
            enc_dec,

            C_accum_0,
            C_accum_1,
            C_accum_2,

            C_out_0_hold, -- will be either cyphertext 1 or the decrypted plaintext
            C_out_1_hold  -- will be either cyphertext 2 or random data
        );

    ERR : entity work.const_error(rtl)
        port map(
            clk,
            rst,
            err_ena,
            enc_dec,

            C_out_0_hold, -- will be either cyphertext 1 or the decrypted plaintext
            C_out_1_hold, -- will be either cyphertext 2 or random data

            e1,
            e2,
            c2,

            C_out_error_0,
            C_out_error_1
        );

    C_out_0 <= C_out_0_hold;
    C_out_1 <= C_out_1_hold;

end architecture;