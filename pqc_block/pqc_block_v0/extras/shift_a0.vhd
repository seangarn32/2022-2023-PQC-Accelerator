library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity shift_a0 is
    port(
        a_in        : in    a_vector;

        a_out       : out   a_vector
    );
end entity;

architecture rtl of shift_a0 is

    signal a_nxt : a_vector;

begin

    -- Shift current a0_shift to bring up top a_section_col
    A0_SHIFT_AROUND : for i in 0 to ROWS-1 generate
        a_nxt(i+N_SIZE-ROWS) <= a_in(i); 
    end generate A0_SHIFT_AROUND;
    A0_SHIFT_UP : for i in ROWS to N_SIZE-1 generate
        a_nxt(i-ROWS) <= a_in(i);
    end generate A0_SHIFT_UP;

    a_out <= a_nxt;

end rtl;