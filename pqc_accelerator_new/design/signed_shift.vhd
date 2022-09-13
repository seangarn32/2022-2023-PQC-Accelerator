library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity signed_shift is
    port (
        A_in    : in    a_matrix;
        A_nxt   : out   a_matrix
    );
end entity;

architecture rtl of signed_shift is
begin
    process begin

        A_nxt(0) <= (NOT(A_in(N_SIZE-1)(1)) & NOT(A_in(N_SIZE-1)(0))) + "01";

        for i in 1 to N_SIZE-1 loop
            A_nxt(i) <= A_in(i-1);
            wait for 1 ns;
        end loop;

    end process;
end rtl;