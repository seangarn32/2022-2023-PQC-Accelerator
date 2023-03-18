library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity signed_set_shift is
    port(
        A_in          : in    a_vector;
        A_nxt_set   : out   a_vector
    );
end entity;

architecture rtl of signed_set_shift is

    --signal set_offset   : std_logic_vector(COUNTER_SIZE - 1 downto 0);

begin
    --set_offset <= std_logic_vector(to_unsigned(SET_SIZE, set_offset'length));
    
    SHIFT_BEGINNING : for i in 0 to SET_SIZE - 1 generate
        A_nxt_set(i) <= NOT(A_in(N_SIZE - SET_SIZE + i)) + 1;
    end generate SHIFT_BEGINNING;

    SHIFT_END : for i in SET_SIZE to N_SIZE-1 generate
        A_nxt_set(i) <= A_in(i - SET_SIZE);
    end generate SHIFT_END;

end rtl;