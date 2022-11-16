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
        Z_in    : in    std_logic;

        C_out   : out   std_logic_vector(7 downto 0);
        EN_out  : out   std_logic_vector(7 downto 0);
        DE_out  : out   std_logic
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal a_sel        : std_logic_vector(A_INDEX_SIZE-1 downto 0);

    signal a_dsi2pe     : a_vector; 
    signal b_dsi2pe     : b_section;

    signal c_pe2accum   : c_section;
    signal c_accum2dso  : c_section;

    signal dsi_ena      : std_logic;
    signal pe_ena       : std_logic;
    signal accum_ena    : std_logic;
    signal dso_ena      : std_logic;

    signal W            : std_logic_vector(7 downto 0);

begin

    FSM : entity work.control_unit(rtl)
        port map(
            clk,
            rst,
            ena,

            a_sel,

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
            pe_ena,

            a_sel,
            A_in,
            B_in,

            a_dsi2pe,
            b_dsi2pe
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,

            a_sel,
            a_dsi2pe,
            b_dsi2pe,

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
            W
        );

    ERR : entity work.add_error(rtl)
        port map(
            clk,
            rst,
            dso_ena,

            W,
            Z_in,

            C_out,
            EN_out,
            DE_out
        );

end architecture;