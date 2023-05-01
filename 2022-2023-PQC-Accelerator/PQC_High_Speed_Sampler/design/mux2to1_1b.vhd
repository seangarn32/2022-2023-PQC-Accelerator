library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux2to1_1b is
	port( a0,a1		: in std_logic;
	      sel		: in std_logic;
	      res		: out std_logic
);
end mux2to1_1b;

architecture rtl of mux2to1_1b is
begin

    res <= a1 when sel = '1' else
           a0;
end rtl;