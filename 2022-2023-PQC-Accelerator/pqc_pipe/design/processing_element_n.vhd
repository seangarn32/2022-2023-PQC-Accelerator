library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_n is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        
        A       : in    a_vector;
        B       : in    std_logic_vector(7 downto 0);
        C_in    : in    c_matrix;

        C_out   : out   c_matrix
    );
end entity;

architecture rtl of processing_element_n is

    signal C_mult : c_matrix;
    signal C_sum  : c_matrix;

begin
    -- Multiply AxB -> C_mult
    MULT :      entity work.multiplier_nbit(rtl)
        port map(
            A,
            B,
            C_mult
        );

    -- Accumulate (+) C values -> C_sum
    SUM : for i in 0 to N_SIZE-1 generate
        C_sum(i) <= C_in(i) + C_mult(i);
    end generate SUM;

    -- Register Output -> C_out
    REG_SUM :   entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,
            C_sum,

            C_out
        );

end rtl;