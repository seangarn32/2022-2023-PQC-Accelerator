library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux2to1_C is
	port( c0,c1		: in c_matrix;
	      sel		: in STD_LOGIC;
	      res_0, res_1		: out c_matrix
);
end mux2to1_C;

architecture rtl of mux2to1_C is
begin

    res_0 <= c1 when sel = '1' else
           c0;
end rtl;