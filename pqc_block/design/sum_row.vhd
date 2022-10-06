library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity sum_row is
    port(
        row     : in    ab_row;

        sum     : out   std_logic_vector(7 downto 0);
    );
end entity;

architecture rtl of sum_row is

    signal sum_wire : ab_row;

begin

    sum_wire(0) <= ab_row(0);
    SUM : for i in 1s to COLS-1 generate
        sum_wire(i) <= sum_wire(i-1) + ab_row(i)
    end generate SUM;

    sum <= sum_wire(COLS-1);

begin


end rtl;