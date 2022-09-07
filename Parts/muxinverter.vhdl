library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity muxinverter is
	port( a1	: in std_logic_vector(7 downto 0);
	      sel	: in std_logic;
	      b1	: out std_logic_vector(7 downto 0)
);
end muxinverter;

architecture a of muxinverter is

component mux2to1
	port( a1, a2	: in std_logic_vector(7 downto 0);
	      sel	: in std_logic;
	      b1	: out std_logic_vector(7 downto 0)
);
end component;

signal T1: std_logic_vector(7 downto 0);

begin


T1 <= NOT a1;



u1: mux2to1 
port map(a1=>a1, a2=>T1, sel=>sel, b1=>b1);



end a;