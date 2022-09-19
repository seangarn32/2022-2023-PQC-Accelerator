library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A0      : in    std_logic_vector(N_SIZE-1 downto 0);
        B_in    : in    std_logic_vector(7 downto 0);

        A_out   : out   a_matrix;
        C_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal B : b_matrix;
    signal C : b_matrix;

    signal dsi_ena : std_logic;
    signal pe_ena  : std_logic;
    signal dso_ena : std_logic;

begin

    FSM : entity work.fsm(rtl)
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
            B_in,

            B
        );

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,

            A0,
            B,

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