library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity enc_dec_mux is
	port( a0	: in a_vector;
	      sel	: in std_logic;
	      res	: out a_vector
);
end enc_dec_mux;

architecture rtl of enc_dec_mux is

component mux2to1
	port( a0, a1	: in a_vector;
	      sel	: in std_logic;
	      res	: out a_vector
);
end component;

signal T1: a_vector;

begin

    T1 <= NOT a0;

    u1: mux2to1 
    port map(a0=>a0, a1=>T1, sel=>sel, res=>res);

end rtl;