library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux2to1_B is
	port( b0,b1, b2, b3		: in b_hold_matrix;
	      sel		: in STD_LOGIC;
	      res_0, res_1		: out b_hold_matrix
);
end mux2to1_B;

architecture rtl of mux2to1_B is
begin

    res_0 <= b2 when sel = '1' else
           b0;
	res_1 <= b3 when sel = '1' else
           b1;
end rtl;