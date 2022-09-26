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

    signal tmp  : c_matrix;

begin

    process (clk)
        begin

        if (rising_edge(clk)) then
            if (rst = '1') then
                for i in 0 to N_SIZE-1 loop
                    tmp(i) <= (others => '0');
                end loop;
            else
                if (ena = '1') then
                    for i in 0 to N_SIZE-1 loop
                        tmp(i) <= tmp(i) + D_in(i);
                    end loop;
                end if;
            end if;
        end if;
    end process;

    Q <= tmp;

end rtl;