library ieee;
use ieee.std_logic_1164.all;

entity crc is
	port( 	A   : in STD_LOGIC_VECTOR(7 downto 0);
		CRC_A : out STD_LOGIC_VECTOR(7 downto 0)
	);
end crc;

architecture a of crc is
begin
	CRC_A(0) <= A(7);
	CRC_A(1) <= A(0);
	CRC_A(2) <= A(1);
	CRC_A(3) <= A(2);
	CRC_A(4) <= A(3);
	CRC_A(5) <= A(4);
	CRC_A(6) <= A(5);
	CRC_A(7) <= A(6);
end a;