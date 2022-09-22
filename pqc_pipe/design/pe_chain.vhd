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
        B       : in    b_matrix;

        A_out   : out   a_matrix;
        C_out   : out   b_matrix
    );
end entity;

architecture rtl of pe_chain is

    signal A_sel : a_matrix; 
    signal B_sel : 

    signal A    : a_wire;
    signal C    : c_wire;

begin

    CIRC : entity work.circulant(rtl)
        port map(
            A0,
            A
        );

    MUX_A_GEN : for i in 0 to (N_SIZE/DIVIDE)-1 generate 
        entity work.MUX_A_NAME(rtl)
            port map(

            );
    end generate MUX_A_GEN;

    MUX_B_GEN : for i in 0 to (N_SIZE/DIVIDE)-1 generate 
        entity work.MUX_B_NAME(rtl)
            port map(

            );
    end generate MUX_B_GEN;

    PE_0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,

            A(0),
            B(0),

            C(1)
        );

    PE_GEN : for i in 1 to N_SIZE-2 generate
        PE : entity work.processing_element_n(rtl)
            port map(
                clk,
                rst,
                ena,

                A(i),
                B(i),
                C(i),

                C(i+1)
            );
    end generate PE_GEN;

    PE_N :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,

            A(N_SIZE-1),
            B(N_SIZE-1),
            C(N_SIZE-1),

            C_out
        );

end architecture;