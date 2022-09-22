library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_chain is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A0      : in    std_logic_vector(N_SIZE-1 downto 0);
        A_sel   : in    mux_sel_array;

        B       : in    b_matrix;
        B_sel   : in    mux_sel_array;

        A_out   : out   a_matrix;
        C_out   : out   b_matrix
    );
end entity;

architecture rtl of pe_chain is

    signal A    : a_wire;

    signal A_hold : a_mux_input_wire;
    signal B_hold : b_mux_input_wire;

    signal A_mux2pe : a_wire_mux2pe;
    signal B_mux2pe : b_wire_mux2pe;

    signal C    : c_wire;

begin

    CIRC_MATRIX : entity work.circulant(rtl)
        port map(
            A0,
            A
        );

    MUX_A_GEN : for i in 0 to MUX_NUM-1 generate 

        A_HOLD_ASSIGN : for j in 0 to DIVIDE-1 generate
            A_hold(i)(j) <= A(i*DIVIDE+j);
        end generate A_HOLD_ASSIGN;

        A_MUX : entity work.a_mux(rtl)
            port map(
                A_hold(DIVIDE*i),
                A_sel(i),

                A_mux2pe(i)
            );
    end generate MUX_A_GEN;

    MUX_B_GEN : for i in 0 to MUX_NUM-1 generate 

        B_HOLD_ASSIGN : for j in 0 to DIVIDE-1 generate
            B_hold(i)(j) <= B(i*DIVIDE+j);
        end generate B_HOLD_ASSIGN;

        B_MUX : entity work.b_mux(rtl)
            port map(
                B_hold(DIVIDE*i),
                B_sel(i),

                B_mux2pe(i)
            );
    end generate MUX_B_GEN;

    PE_0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,

            A_mux2pe(0),
            B_mux2pe(0),

            C(1)
        );

    PE_GEN : for i in 1 to MUX_NUM-2 generate
        PE : entity work.processing_element_n(rtl)
            port map(
                clk,
                rst,
                ena,

                A_mux2pe(i),
                B_mux2pe(i),
                C(i),

                C(i+1)
            );
    end generate PE_GEN;

    PE_N :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,

            A_mux2pe(MUX_NUM-1),
            B_mux2pe(MUX_NUM-1),
            C(MUX_NUM-1),

            C_out
        );

end architecture;