library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity a_mux is
    port(
        A_in     : in    a_mux_input;
        sel      : in    std_logic_vector(MUX_SEL_SIZE-1 downto 0); 

        A_out    : out   a_vector
    );
end entity;

architecture rtl of a_mux is

begin

    A_out <= A_in(to_integer(unsigned(sel)));

end rtl;