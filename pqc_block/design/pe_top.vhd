library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A0      : in    std_logic_vector(N_SIZE-1 downto 0);
        B       : in    b_matrix;
        sel     : in    mux_sel_array;

        C_out   : out   c_matrix
    );
end entity;

architecture rtl of pe_top is

    signal A    : a_matrix;

    signal A_mux2pe : a_section;
    signal B_mux2pe : b_section;

    signal C    : c_array;

begin

    CIRC_MATRIX : entity work.circulant(rtl)
        port map(
            A0,
            A
        );

    
    A_MUX : entity work.a_mux(rtl)
        port map(
            A_hold(i),
            sel(i),

            A_mux2pe
        );

    
    B_MUX : entity work.b_mux(rtl)
        port map(
            B_hold(i),
            sel(i),

            B_mux2pe
        );

    PE :   entity work.processing_element(rtl)
        port map(
            clk,
            rst,
            ena,

            A_mux2pe,
            B_mux2pe,

            C(1)
        );

end architecture;