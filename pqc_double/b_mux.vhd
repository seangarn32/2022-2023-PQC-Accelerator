library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity b_mux is
    port(
        B_in     : in    b_mux_input;
        sel      : in    std_logic_vector(MUX_SEL_SIZE-1 downto 0); 

        B_out    : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of b_mux is

begin

    B_out <= B_in(to_integer(unsigned(sel)));

end rtl;