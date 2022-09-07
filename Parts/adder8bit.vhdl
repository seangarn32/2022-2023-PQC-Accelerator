LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;

entity adder8bit is
	PORT( 	cin : in STD_LOGIC;
		A : in STD_LOGIC_VECTOR(7 downto 0);
		B : in STD_LOGIC_VECTOR(7 downto 0);
		sum : out STD_LOGIC_VECTOR(7 downto 0);
		cout : out STD_LOGIC
	);
END adder8bit;
architecture a of adder8bit is

SIGNAL carry : STD_LOGIC_VECTOR(6 downto 0);

COMPONENT adder1bit	PORT( 	cin : in STD_LOGIC;
				A : in STD_LOGIC;
				B : in STD_LOGIC;
				sum : out STD_LOGIC;
				cout : out STD_LOGIC
			);
END COMPONENT;
begin

U0 : adder1bit		PORT MAP(cin => cin,
				 A	=> A(0),
				 B	=> B(0),
				 sum	=> sum(0),
				 cout	=> carry(0)
			);
U1 : adder1bit		PORT MAP(cin => carry(0),
				 A	=> A(1),
				 B	=> B(1),
				 sum	=> sum(1),
				 cout	=> carry(1)
			);
U2 : adder1bit		PORT MAP(cin => carry(1),
				 A	=> A(2),
				 B	=> B(2),
				 sum	=> sum(2),
				 cout	=> carry(2)
			);
U3 : adder1bit		PORT MAP(cin => carry(2),
				 A	=> A(3),
				 B	=> B(3),
				 sum	=> sum(3),
				 cout	=> carry(3)
			);
U4 : adder1bit		PORT MAP(cin => carry(3),
				 A	=> A(4),
				 B	=> B(4),
				 sum	=> sum(4),
				 cout	=> carry(4)
			);
U5 : adder1bit		PORT MAP(cin => carry(4),
				 A	=> A(5),
				 B	=> B(5),
				 sum	=> sum(5),
				 cout	=> carry(5)
			);
U6 : adder1bit		PORT MAP(cin => carry(5),
				 A	=> A(6),
				 B	=> B(6),
				 sum	=> sum(6),
				 cout	=> carry(6)
			);
U7 : adder1bit		PORT MAP(cin => carry(6),
				 A	=> A(7),
				 B	=> B(7),
				 sum	=> sum(7),
				 cout	=> cout
			);
end a;