library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity signed_shift is
    port (
        A_in    : in    a_vector;
        A_nxt   : out   a_vector
    );
end entity;

architecture rtl of signed_shift is
begin

    A_nxt(0) <= NOT(A_in(N_SIZE-1)) + "01";

    SHIFT : for i in 1 to N_SIZE-1 generate
        A_nxt(i) <= A_in(i-1);
    end generate SHIFT;

end rtl;