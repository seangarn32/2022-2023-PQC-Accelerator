library ieee;
use ieee.std_logic_1164.all;

entity multiplier is
	port( 	A   : in STD_LOGIC_VECTOR(7 downto 0);
		B   : in STD_LOGIC;
		SUM : out STD_LOGIC_VECTOR(7 downto 0)
	);
end multiplier;

architecture a of multiplier is
begin
	SUM(0) <= A(0) AND B;
	SUM(1) <= A(1) AND B;
	SUM(2) <= A(2) AND B;
	SUM(3) <= A(3) AND B;
	SUM(4) <= A(4) AND B;
	SUM(5) <= A(5) AND B;
	SUM(6) <= A(6) AND B;
	SUM(7) <= A(7) AND B;
end a;