-- Description:
--
-- Read Load A description to gain sense of processing.
--
-- The signed_set_shift computes the first even vector of the next set.
-- i.e. if the set size is 8, A_in is A0 and A_nxt_set is A8

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity signed_set_shift is
    port(
        A_in          : in    a_vector;
        A_nxt_set     : out   a_vector
    );
end entity;

architecture rtl of signed_set_shift is

begin
    -- Negates and shifts the last SET_SIZE elements in A_in
    SHIFT_BEGINNING : for i in 0 to SET_SIZE - 1 generate
        A_nxt_set(i) <= NOT(A_in(N_SIZE - SET_SIZE + i)) + 1;
    end generate SHIFT_BEGINNING;

    -- Shifts A_in by SET_SIZE
    SHIFT_END : for i in SET_SIZE to N_SIZE-1 generate
        A_nxt_set(i) <= A_in(i - SET_SIZE);
    end generate SHIFT_END;

end rtl;