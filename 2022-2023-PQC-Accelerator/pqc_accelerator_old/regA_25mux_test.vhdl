LIBRARY ieee;               
USE ieee.std_logic_1164.ALL;

ENTITY regA_256mux_test is
generic (N:INTEGER:=256);
PORT(	clk, clr, en, cir_shift : in STD_LOGIC;
	A_in			: in STD_LOGIC_VECTOR(7 downto 0);
	mux_sel			: in STD_LOGIC_VECTOR(7 downto 0);
	mux_out			: out STD_LOGIC_VECTOR(7 downto 0)
);
END ENTITY;
architecture a of regA_256mux_test is
COMPONENT b8	     	PORT( 	clk, clr, en, cir_shift : in STD_LOGIC;
			   	d 	: in STD_LOGIC_VECTOR(7 downto 0);
			   	q 	: out STD_LOGIC_VECTOR(8*N-1 downto 0)
		     	);
END COMPONENT;
COMPONENT mux_256	PORT( 	A	: in STD_LOGIC_VECTOR(8*N-1 downto 0);
			   	SEL	: in STD_LOGIC_VECTOR(7 downto 0);
			   	B	: out STD_LOGIC_VECTOR(7 downto 0)
		     	);
END COMPONENT;

SIGNAL fat_signal : STD_LOGIC_VECTOR(8*N-1 downto 0);

BEGIN

U1 : b8 PORT MAP(clk, clr, en, cir_shift, d=>A_in, q=>fat_signal);

U2 : mux_256 PORT MAP(A=>fat_signal, SEL=>mux_sel, B=>mux_out);

END a;
