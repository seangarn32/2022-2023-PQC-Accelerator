library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity accumulator_cell is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        sel     : in    std_logic;
        
        A0      : in    c_matrix;
        A1      : in    c_matrix;    

        C0      : out   c_matrix;
        C1      : out   c_matrix;
        C2      : out   c_matrix

    );
end entity;

architecture rtl of accumulator_cell is

    signal sum       : c_matrix;
    signal c0_out    : c_matrix;
    signal c1_out    : c_matrix;
    signal sc1_out   : c_matrix;

begin

    ACCUM0 :      entity work.pe_accum(rtl)
        port map(
            clk,
            rst,
            ena,
            A0,

            C0_out
        );

    ACCUM1 :   entity work.pe_accum(rtl)
        port map(
            clk,
            rst,
            ena,
            A1,

            C1_out
        );

    RSC : entity work.reverse_shift_cell(rtl)
        port map(
            C1_out,
            sc1_out
        );

    if(sel='1') then
        SUM_GEN : for i in 0 to N_SIZE-1 generate
            sum(i) <= C0_out(i) + sc1_out(i);
        end generate SUM_GEN;
    end if;

    C0 <= C0_out;
    C1 <= sc1_out;
    C2 <= sum;

end rtl;