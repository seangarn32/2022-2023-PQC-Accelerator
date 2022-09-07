LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;

entity adder1bit is
	PORT( 	cin : in STD_LOGIC;
		A : in STD_LOGIC;
		B : in STD_LOGIC;
		sum : out STD_LOGIC;
		cout : out STD_LOGIC
	);
END adder1bit;
architecture a of adder1bit is
begin
	        
        -- Calculate the sum of the 1-BIT adder.
        sum <=  (not A and not B and cin) or
                        (not A and B and not cin) or
                        (A and not B and not cin) or
                        (A and B and cin);

        -- Calculates the carry out of the 1-BIT adder.
        cout <= (not A and B and cin) or
                        (A and not B and cin) or
                        (A and B and not cin) or
                        (A and B and cin);

end a;