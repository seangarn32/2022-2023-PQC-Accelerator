library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux2to1 is
	port( a0,a1		: in a_vector;
	      sel		: in STD_LOGIC;
	      res		: out a_vector
);
end mux2to1;

architecture rtl of mux2to1 is
begin

with sel select
res <= 	a0 when '0',
    a1 when '1',
    "00000000" when others;

end rtl;