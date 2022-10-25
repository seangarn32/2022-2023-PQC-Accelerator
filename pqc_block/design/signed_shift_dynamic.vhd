library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity signed_shift_dynamic is
    port(
        inv_sel : in    std_logic_vector(N_SIZE-1 downto 0);
        A_in    : in    a_vector;

        A_out   : out   a_vector
    );
end entity;

architecture rtl of signed_shift_dynamic is

    signal a_not    : a_vector;
    signal a_shift  : a_vector;
    signal a_inv    : a_vector;

begin

    INV_GEN : for i in 0 to N_SIZE-1 generate
        a_not(i) <= NOT(A_in(i)) + "01";

        a_inv(i) <= A_in(i) when inv_sel(i) = '0' else a_not(i);
    end generate INV_GEN;

    a_shift(0) <= a_inv(N_SIZE-1);
    SHIFT_GEN : for i in 1 to N_SIZE-1 generate
        a_shift(i) <= a_inv(i-1);
    end generate SHIFT_GEN;

    A_out <= a_shift;

end rtl;