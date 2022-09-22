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

        A_out   : out   a_matrix;
        C_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal A : std_logic_vector(N_SIZE-1 downto 0);
    signal B : b_matrix;
    signal C : b_matrix;

    signal A_sel : mux_sel_array;
    signal B_sel : mux_sel_array;

    signal dsi_ena : std_logic;
    signal pe_ena  : std_logic;
    signal dso_ena : std_logic;

begin

    FSM : entity work.fsm_chain(rtl)
        port map(
            clk,
            rst,
            ena,

            dsi_ena,
            pe_ena,
            dso_ena
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
            A_sel,

            B,
            B_sel,

            A_out,
            C
        );

    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            rst,
            dso_ena,
            C,

            C_out
        );

end architecture;