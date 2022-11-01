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

        C_out_0   : out   std_logic_vector(7 downto 0);
        C_out_1   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal A            : std_logic_vector(N_SIZE-1 downto 0);
    signal A0           : a_vector;
    signal B            : b_matrix;
    signal P            : b_matrix;
    signal C_0            : c_matrix;
    signal C_1            : c_matrix;
    signal C_accum_0      : c_matrix;
    signal C_accum_1      : c_matrix;
    signal C_accum_2      : c_matrix;

    signal dsi_ena      : std_logic;
    signal pe_ena       : std_logic;
    signal accum_ena    : std_logic;
    signal dso_ena      : std_logic;

begin

    FSM : entity work.fsm(rtl)
        port map(
            clk,
            rst,
            ena,

            dsi_ena,
            pe_ena,
            accum_ena,
            dso_ena
        );

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
            rst,
            pe_ena,
            A,

            A0
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,
            enc_dec,

            A0,
            B,
            P,

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
            rst,
            dso_ena,
            enc_dec,

            C_accum_0,
            C_accum_1,
            C_accum_2,

            C_out_0, -- will be either cyphertext 1 or the decrypted plaintext
            C_out_1  -- will be either cyphertext 2 or random data
        );

end architecture;