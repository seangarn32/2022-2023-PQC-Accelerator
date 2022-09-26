library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;
 
entity pe_accum is
    port(
            clk     : in    std_logic;
            rst     : in    std_logic;
            ena     : in    std_logic;

            D_in    : in    std_logic_vector(0 to N_SIZE-1);
            Q       : out   std_logic_vector(0 to N_SIZE-1)
        );
end pe_accum;

architecture rtl of pe_accum is

    signal tmp: std_logic_vector(0 to N_SIZE-1);
    constant C: std_logic_vector(0 to N_SIZE-1) := (others => '0');

begin

    process (clk)
        begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                tmp <= C;
            else
                if (ena = '1') then
                    tmp <= tmp + D_in;
                end if;
            end if;
        end if;
    end process;

    Q <= tmp;

end rtl;