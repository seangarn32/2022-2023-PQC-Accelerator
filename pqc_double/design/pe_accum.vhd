library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;
 
entity pe_accum is
    port(
            clk     : in    std_logic;
            rst     : in    std_logic;
            ena     : in    std_logic;

            D_in    : in    c_matrix;
            Q       : out   c_matrix
        );
end pe_accum;

architecture rtl of pe_accum is

    signal sum      : c_matrix;
    signal sum_nxt  : c_matrix;

begin

    SUM_GEN : for i in 0 to N_SIZE-1 generate
        sum_nxt(i) <= sum(i) + D_in(i);
    end generate SUM_GEN;

    ACCUM_REG : entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,

            sum_nxt,
            sum
        );

    Q <= sum;

end rtl;