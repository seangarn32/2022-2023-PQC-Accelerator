-- Description:
--
-- The pqc_accelerator_top is the top level file that integrates the subcomponents together.
-- The top level components are the following:
-- FSM, DSI, LOAD_A, LOAD_B, PE_CHAIN, ACCUM, DSO, and ERR

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

        -- Indexs that control the registers in the top level Quartus project
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

begin

    -- Controls when the control signals are set
    FSM : entity work.fsm(rtl)
        port map(
            clk,
            rst,
            ena,
            enc_dec,

            dsi_ena,
            load_a_rst,
            load_a_ena,
            load_b_rst,
            load_b_ena,
            pe_ena,
            accum_ena,
            dso_ena,
            dso_rst,
            err_ena,

            a_index_out,
            b_index_out,
            p_index_out,
            c_out_0_index_out,
            c_out_1_index_out,
            out_ena
        );

    -- Shifts in the input vectors A0, B, and P, which are stored within the system registers in the 
    -- top level Quartus project
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

    -- Supplies PE_CHAIN with the correct input vector in accordance to set notation
    LOAD_A : entity work.load_a(rtl)
        port map(
            clk,
            load_a_rst,
            load_a_ena,
            enc_dec,
            A,

            A0
        );

    -- Supplies PE_CHAIN with the correct B and P index values that matches the A vector
    -- set being processed
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

    -- Computes the matrix multiplication of A x B and/or A x P
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

    -- Accumulates the results that are pushed out of the last PE in the PE chain
    -- This is part of the matrix multiplication
    ACCUM : entity work.accumulator_cell(rtl)
        port map(
            clk,
            rst,
            accum_ena,

            C_0,
            C_1,

            C_accum_0,  -- Cyphertext 1
            C_accum_1,  -- Cyphertext 2
            C_accum_2   -- Decrypted plaintext, which is C_accum_0 + C_accum_1
        );

    -- Shifts the matrix multiplication out of the system's registers
    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            dso_rst,
            dso_ena,
            enc_dec,

            C_accum_0,
            C_accum_1,
            C_accum_2,

            C_out_0_hold, -- Encryption: Cyphertext 1, Decryption: Decrypted plaintext
            C_out_1_hold  -- Encryption: Cyphertext 2, Decryption: Don't care
        );

    -- Adds the error vectors to A x B and/or A x P
    ERR : entity work.const_error(rtl)
        port map(
            clk,
            rst,
            err_ena,
            enc_dec,

            C_out_0_hold, -- Encryption: Cyphertext 1, Decryption: Decrypted plaintext
            C_out_1_hold  -- Encryption: Cyphertext 2, Decryption: Don't care

            e1,
            e2,
            c2,

            C_out_error_0,
            C_out_error_1
        );

    C_out_0 <= C_out_0_hold;
    C_out_1 <= C_out_1_hold;

end architecture;