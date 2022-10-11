library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity mux2to1 is
	port( a0,a1		: in STD_LOGIC_VECTOR(7 downto 0);
	      sel		: in STD_LOGIC;
	      res		: out STD_LOGIC_VECTOR(7 downto 0)
);
end mux2to1;

architecture rtl of mux2to1 is
begin

    with sel select
    res <= 	a1 when '0',
        a2 when '1',
        "00000000" when others;
        
end rtl;