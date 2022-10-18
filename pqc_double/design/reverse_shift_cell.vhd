library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity reverse_shift_cell is
    port (
        A_in    : in    a_vector;
        A_nxt   : out   a_vector
    );
end entity;

architecture rtl of reverse_shift_cell is
begin

    A_nxt(N_SIZE-1) <= A_in(0);

    SHIFT : for i in 0 to N_SIZE-2 generate
        A_nxt(i) <= A_in(i+1);
    end generate SHIFT;

end rtl;