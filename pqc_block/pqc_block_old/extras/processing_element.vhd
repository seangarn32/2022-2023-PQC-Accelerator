library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        
        A       : in    a_section;
        B       : in    b_section;

        C       : out   c_section
    );
end entity;

architecture rtl of processing_element is

    signal ab_mult  : ab_section;
    signal rows     : row_array;
    signal C_hold   : c_section;

begin

    -- Multiply AxB -> C_mult
    MULT_COL : for i in 0 to ROWS-1 generate
        MULT_ROW : for j in 0 to COLS-1 generate
            MULT_N : entity work.multiplier_8bit(rtl)
                port map(
                    A(j+i*COLS),
                    B(j),

                    row_array(i)(j)
                );
        end generate MULT_ROW;
    end generate MULT_COL;

    SUM : for i in 0 to ROWS-1 generate
        SUM_N : entity work.sum_row(rtl)
            port map(
                row_array(i),

                C_hold(i)
            );
    end generate SUM;

    REG : entity work.reg_c(rtl)
        port map(
            C_hold,

            C
        );

end rtl;