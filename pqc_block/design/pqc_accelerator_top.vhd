library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A_in    : in    std_logic;
        B_in    : in    std_logic_vector(7 downto 0);

        C_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal A            : std_logic_vector(N_SIZE-1 downto 0);
    signal B            : b_matrix;
    signal C            : c_matrix;
    signal C_accum      : c_matrix;

    signal pe_mux_sel   : mux_sel_array; 

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
            dso_ena,

            pe_mux_sel
        );

    DSI : entity work.data_shift_in(rtl)
        port map(
            clk,
            rst,
            dsi_ena,

            A_in,
            B_in,

            A,
            B
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,

            A,
            B,
            pe_mux_sel,

            C
        );

    PE_ACCUM : entity work.pe_accum(rtl)
        port map(
            clk,
            rst,
            accum_ena,

            C,
            C_accum
        );

    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            rst,
            dso_ena,
            C_accum,

            C_out
        );

end architecture;