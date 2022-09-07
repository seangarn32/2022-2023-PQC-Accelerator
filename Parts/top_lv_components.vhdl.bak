LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY top_lv_components IS
GENERIC (N:INTEGER:=256);
PORT (  A_in	: in STD_LOGIC_VECTOR(7 downto 0);
	B_in	: in STD_LOGIC;
	C_in	: in STD_LOGIC_VECTOR(7 downto 0);
	clock	: in STD_LOGIC;
	reset	: in STD_LOGIC;
	load	: in STD_LOGIC;
	clear	: in STD_LOGIC;
	done	: out STD_LOGIC;
	D_out	: out STD_LOGIC_VECTOR(7 downto 0)
);
END top_lv_components;

ARCHITECTURE main of top_lv_components IS
SIGNAL A_to_mux	: STD_LOGIC_VECTOR(8*N-1 downto 0);
SIGNAL muxA, muxA_to_mult, C_to_2to1 : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL mult_to_2to1, mux_to_inv, inv_to_adder : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL shift_A, shift_B, shift_C, cir_shift, clr, cout : STD_LOGIC;
SIGNAL B_to_mult: STD_LOGIC;
SIGNAL enable_reg, clear_reg : STD_LOGIC;
SIGNAL ctrl_1, ctrl_2 : STD_LOGIC;
SIGNAL reg_to_adder, adder_to_reg : STD_LOGIC_VECTOR(7 downto 0);
SIGNAL D_sig : STD_LOGIC;

COMPONENT control_unit	PORT(	clock		: in STD_LOGIC;
				reset		: in STD_LOGIC;
				load		: in STD_LOGIC;
				clear		: in STD_LOGIC;
				done		: out STD_LOGIC;
				en_A		: out STD_LOGIC;
				en_B	 	: out STD_LOGIC;
				en_C		: out STD_LOGIC;
				en_reg		: out STD_LOGIC;
				clear_all	: out STD_LOGIC;
				cir_shift	: out STD_LOGIC;
				ctrl_1	    	: out STD_LOGIC;
				ctrl_2	    	: out STD_LOGIC;
				ctrl_mux_1	: out STD_LOGIC_VECTOR(7 downto 0);
				clear_reg 	: out STD_LOGIC;
				D_valid		: out STD_LOGIC
    			);
END COMPONENT;
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
COMPONENT mux2to1	PORT( 	a1,a2	: in STD_LOGIC_VECTOR(7 downto 0);
			   	sel	: in STD_LOGIC;
			   	b1	: out STD_LOGIC_VECTOR(7 downto 0)
		     	);
END COMPONENT;
COMPONENT multiplier	PORT(	A	: in STD_LOGIC_VECTOR(7 downto 0);
			   	B	: in STD_LOGIC;
			   	SUM	: out STD_LOGIC_VECTOR(7 downto 0)
		     	);		
END COMPONENT;
COMPONENT muxinverter	PORT( 	a1	: in STD_LOGIC_VECTOR(7 downto 0);
				sel	: in STD_LOGIC;
			   	b1	: out STD_LOGIC_VECTOR(7 downto 0)
		     	);
END COMPONENT;
COMPONENT adder8bit	PORT( 	cin	: in STD_LOGIC;
			   	A	: in STD_LOGIC_VECTOR(7 downto 0);
			   	B	: in STD_LOGIC_VECTOR(7 downto 0);
			  	sum	: out STD_LOGIC_VECTOR(7 downto 0);
				cout	: out STD_LOGIC
		     	);
END COMPONENT;
COMPONENT csr_siso_1_bit PORT( clk, clr, en, cir_shift : in STD_LOGIC;
				d : in STD_LOGIC;
				q : out STD_LOGIC
			);
END COMPONENT;
COMPONENT csr_siso_8_bit PORT( clk, clr, en, cir_shift : in STD_LOGIC;
				d : in STD_LOGIC_VECTOR(7 downto 0);
				q : out STD_LOGIC_VECTOR(7 downto 0)
			);
END COMPONENT;
COMPONENT reg_aclr_en_8bit PORT(clk 	: in STD_LOGIC;
				clr, en : in STD_LOGIC;
				d	: in STD_LOGIC_VECTOR(7 downto 0);
				e	: out STD_LOGIC_VECTOR(7 downto 0)
			);
END COMPONENT;
BEGIN

U1 : control_unit	PORT MAP(clock	 	=> clock,		-- CONTROL UNIT
				 reset		=> reset,
				 load		=> load,
				 clear		=> clear,
				 done		=> done,
				 en_A	  	=> shift_A,
				 en_B	 	=> shift_B,
				 en_C		=> shift_C,
				 en_reg		=> enable_reg,
				 clear_all	=> clr,
				 cir_shift	=> cir_shift,
				 ctrl_1	  	=> ctrl_1,
				 ctrl_2	  	=> ctrl_2,
				 ctrl_mux_1	=> muxA,
				 clear_reg 	=> clear_reg,
				 D_valid	=> D_sig
			);
U2 : b8			PORT MAP(clk		=> clock,		-- REG A
				 clr		=> clr,
				 en		=> shift_A,
				 cir_shift	=> cir_shift,
				 d		=> A_in,
				 q		=> A_to_mux
			);	
U3 : csr_siso_1_bit	PORT MAP(clk		=> clock,		-- REG B
				 clr		=> clr,
				 en		=> shift_B,
				 cir_shift	=> cir_shift,
				 d		=> B_in,
				 q		=> B_to_mult
			);
U4 : csr_siso_8_bit	PORT MAP(clk		=> clock,		-- REG C
				 clr		=> clr,
				 en		=> shift_C,
				 cir_shift	=> cir_shift,
				 d		=> C_in,
				 q		=> C_to_2to1
			);	
U5 : mux_256		PORT MAP(A 		=> A_to_mux,		-- connects to A reg
			 	 SEL 		=> muxA,
			 	 B		=> muxA_to_mult
			);

U6 : multiplier 	PORT MAP(A	 	=> muxA_to_mult,	-- multiplies A & B
			 	 B		=> B_to_mult,
			 	 SUM		=> mult_to_2to1
			);
U7 : mux2to1		PORT MAP(a1		=> mult_to_2to1,	-- select between A & C	
			 	 a2		=> C_to_2to1,
			 	 sel		=> ctrl_2,
			 	 b1		=> mux_to_inv
			);
U8 : muxinverter 	PORT MAP(a1		=> mux_to_inv,		-- negatives
			 	 sel	 	=> ctrl_1,
			 	 b1		=> inv_to_adder
			);
U9 : adder8bit		PORT MAP(cin		=> ctrl_1,		-- adds, connects to reg
		   	 	 A		=> inv_to_adder,
      			 	 B		=> reg_to_adder,
         	 	 	 sum		=> adder_to_reg,
				 cout		=> cout
			);
U10 : reg_aclr_en_8bit	PORT MAP(clk		=> clock,		-- reg D
				 clr		=> clear_reg,
				 en		=> enable_reg,
				 d		=> adder_to_reg,
				 e		=> reg_to_adder
			);
process(D_sig)
begin
	IF D_sig = '1' THEN
		D_out <= reg_to_adder;
	END IF;
end process;
END main;