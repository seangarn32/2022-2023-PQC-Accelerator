library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
end entity;

architecture rtl of pqc_accelerator_top is

    signal clk :  std_logic;
    signal rst :  std_logic;
    signal ena :  std_logic;

    signal A0       : std_logic_vector(N_SIZE-1 downto 0);
    signal B        : b_matrix;

    signal A1       : a_matrix;
    signal A2       : a_matrix;
    signal A3       : a_matrix;
    signal A4       : a_matrix;
    signal A5       : a_matrix;
    signal A6       : a_matrix;
    signal A7       : a_matrix;

--    signal C0       : b_matrix;
    signal C1       : b_matrix;
    signal C2       : b_matrix;
    signal C3       : b_matrix;
    signal C4       : b_matrix;
    signal C5       : b_matrix;
    signal C6       : b_matrix;
    signal C7       : b_matrix;

    signal A_out : a_matrix;
    signal C_out : b_matrix;

begin

    PE0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,
            A0,
            B(0),
            A1,
            C1
        );

    PE1 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A1,
            B(1),
            C1,
            A2,
            C2
        );

    PE2 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A2,
            B(2),
            C2,
            A3,
            C3
        );

    PE3 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A3,
            B(3),
            C3,
            A4,
            C4
        );
    PE4 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A4,
            B(4),
            C4,
            A5,
            C5
        );
    PE5 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A5,
            B(5),
            C5,
            A6,
            C6
        );
    PE6 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A6,
            B(6),
            C6,
            A7,
            C7
        );
    PE7 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A7,
            B(7),
            C7,
            A_out,
            C_out
        );

end architecture;