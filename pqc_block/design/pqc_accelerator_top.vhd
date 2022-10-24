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

    signal a0           : std_logic_vector(N_SIZE-1 downto 0);
    signal b_all        : b_matrix;

    signal a_shift2pe   : a_vector; 
    signal b_shift2pe   : b_section;

    signal c_pe2accum   : c_section;
    signal c_accum2dso  : c_section;

    signal dsi_ena      : std_logic;
    signal bl_ena       : std_logic;
    signal pe_ena       : std_logic;
    signal accum_ena    : std_logic;
    signal dso_ena      : std_logic;

begin

    FSM : entity work.control_unit(rtl)
        port map(
            clk,
            rst,
            ena,

            dsi_ena,
            bl_ena,
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

            a0,
            b_all
        );

    ASHIFT : entity work.load_a(rtl)
        port map(
            clk,
            rst,
            pe_ena,

            a0,
            a_shift2pe
        );

    BSHIFT : entity work.load_b(rtl)
        port map(
            clk,
            rst,
            bl_ena,

            b_all,
            b_shift2pe
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,

            a_shift2pe,
            b_shift2pe,

            c_pe2accum
        );

    PE_ACCUM : entity work.pe_accum(rtl)
        port map(
            clk,
            rst,
            accum_ena,

            c_pe2accum,
            c_accum2dso
        );

    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            rst,
            dso_ena,

            c_accum2dso,
            C_out
        );

end architecture;