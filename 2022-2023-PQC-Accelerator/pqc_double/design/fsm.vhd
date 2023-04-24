-- Description:
--
-- The finite state machine (fsm) controls the logic of the design.
-- The design goes through the following states in order:
--      SETUP, DATA_IN, PE_PIPE, DATA_OUT, FINISHED

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
    
    signal count            : std_logic_vector(COUNTER_SIZE downto 0) := (others=>'0');
    signal count_nxt        : std_logic_vector(COUNTER_SIZE downto 0) := (others=>'0');
    signal counter_rst      : std_logic := '1';

    -- index values used for accessing the registers in the top level Quartus project
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

    comb_logic: process(ena, rst, enc_dec, state, count)
    variable state_nxt_v: state_available;
    begin
        -- signals will be zero unless stated otherwise
        -- prevents latches from being inferred in Quartus compilation process
        state_nxt_v := state;
        count_nxt <= count + '1';

        dsi_ena <= '0';
        out_ena <= '0';
        load_a_rst <= '0';
        load_b_rst <= '0';
        accum_ena <= '0';
        pe_ena <= '0';
        load_a_ena <= '0';
        load_b_ena <= '0';
        dso_rst <= '0';
        dso_ena <= '0';
        err_ena <= '0';
        a_index_val_hold <= (others=>'0');
        b_index_val_hold <= (others=>'0');
        p_index_val_hold <= (others=>'0');
        c_out_0_index_val_hold <= (others=>'0');
        c_out_1_index_val_hold <= (others=>'0');

        case state is
            when SETUP =>
                if (ena = '1' and rst = '0') then
                    state_nxt_v := DATA_IN;
                    count_nxt <= (others=>'0');
                end if;

            when DATA_IN =>
                if (count < N_SIZE) then
                    dsi_ena <= '1';
                end if;
                a_index_val_hold <= a_index_val + '1';
                b_index_val_hold <= b_index_val + '1';
                p_index_val_hold <= p_index_val + '1';
                out_ena <= '1';
                if (count = N_SIZE + 1) then
                    state_nxt_v := PE_PIPE;
                    count_nxt <= (others=>'0');
                    out_ena <= '0';
                elsif (count = N_SIZE) then
                    -- resets load a and b before moving to PE_PIPE
                    load_a_rst <= '1';
                    load_b_rst <= '1';
                end if;
                
            when PE_PIPE =>
                if (enc_dec = '0') then
                    if (count < DIVIDE) then
                        load_a_ena <= '1';
                        load_b_ena <= '1';
                    end if;
                    if (count <= PE_SIZE + (DIVIDE)) then
                        -- accumulator is enabled when the first a vector is being processed in the last PE of the PE chain
                        accum_ena <= '1';
                    end if;
                    if (count = PE_SIZE + (DIVIDE) + 1) then
                        state_nxt_v := DATA_OUT;
                        count_nxt <= (others=>'0');
                        dso_rst <= '1';
                    else
                        pe_ena <= '1';
                    end if;
                else
                    if (count < NUM_SETS) then
                        load_a_ena <= '1';
                        load_b_ena <= '1';
                    end if;
                    if (count <= PE_SIZE + (NUM_SETS)) then
                        -- accumulator is enabled when the first a vector is being processed in the last PE of the PE chain
                        accum_ena <= '1';
                    end if;
                    if (count = PE_SIZE + NUM_SETS + 2) then
                        state_nxt_v := DATA_OUT;
                        count_nxt <= (others=>'0');
                        dso_rst <= '1';
                    else
                        pe_ena <= '1';
                    end if;
                end if;

            when DATA_OUT =>
                out_ena <= '1';
                if (count < N_SIZE) then
                    dso_ena <= '1';
                    c_out_0_index_val_hold <= c_out_0_index_val + '1';
                    c_out_1_index_val_hold <= c_out_1_index_val + '1';
                end if;
                if (count < N_SIZE + 1) then
                    err_ena <= '1';
                end if;
                if (count = N_SIZE + 1) then
                    state_nxt_v := FINISHED;
                    count_nxt <= (others=>'0');
                end if;

            when FINISHED =>
                -- do nothing
                count_nxt <= (others=>'0');
                c_out_0_index_val_hold <= (others=>'0');
                c_out_1_index_val_hold <= (others=>'0');
        end case;

        state_nxt <= state_nxt_v;

    end process comb_logic;
    

    process (clk)
        begin
            if rising_edge(clk) then
                if (rst = '1' or ena = '0') then
                    -- initial state is SETUP
                    state <= SETUP;
                    count <= (others => '0');

                    a_index_out <= (others=>'0');
                    b_index_out <= (others=>'0');
                    p_index_out <= (others=>'0');
                    c_out_0_index_out <= (others=>'0');
                    c_out_1_index_out <= (others=>'0');
                else
                    -- enters the next state
                    state <= state_nxt;
                    count <= count_nxt;

                    a_index_val <= a_index_val_hold;
                    b_index_val <= b_index_val_hold;
                    p_index_val <= p_index_val_hold;
                    c_out_0_index_val <= c_out_0_index_val_hold;
                    c_out_1_index_val <= c_out_1_index_val_hold;

                    a_index_out <= a_index_val_hold;
                    b_index_out <= b_index_val_hold;
                    p_index_out <= p_index_val_hold;
                    c_out_0_index_out <= c_out_0_index_val_hold;
                    c_out_1_index_out <= c_out_1_index_val_hold;
                end if;
            end if;
    end process;
end rtl;
