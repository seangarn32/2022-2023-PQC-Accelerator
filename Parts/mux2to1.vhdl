library ieee;
use ieee.std_logic_1164.all;

entity mux2to1 is
	port( a1,a2		: in STD_LOGIC_VECTOR(7 downto 0);
	      sel		: in STD_LOGIC;
	      b1		: out STD_LOGIC_VECTOR(7 downto 0)
);
end mux2to1;

architecture a of mux2to1 is
begin

with sel select
b1 <= 	a1 when '0',
	a2 when '1',
	"00000000" when others;
end a;



