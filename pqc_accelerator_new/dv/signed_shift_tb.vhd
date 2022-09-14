library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity signed_shift_tb is
end entity;

architecture tb of signed_shift_tb is

    signal A_in : a_matrix := ("01", "00", "00", "00", "00", "00", "00", "01");
    signal A_nxt: a_matrix;

begin
    SSTB :  entity work.signed_shift(rtl)
        port map(
            A_in,
            A_nxt
        );
end tb;