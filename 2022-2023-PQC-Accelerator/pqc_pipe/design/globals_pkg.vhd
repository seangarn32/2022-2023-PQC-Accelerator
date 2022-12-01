library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real.log2;

package globals_pkg is

    -- N_SIZE -> Size of initial A vector 
    constant N_SIZE : integer := 8;
    -- DIVIDE -> Number of times to divide down PEs for pipelining
    constant DIVIDE : integer := 2;
    
    -- MUX_NUM -> Number of muxes
    constant MUX_NUM : integer := N_SIZE/DIVIDE;
    -- MUX_SIZE -> Number of mux input lines
    constant MUX_SIZE : integer := DIVIDE;
    -- MUX_LN_SIZE -> Bit length of mux input line
    constant MUX_LN_SIZE : integer := N_SIZE;
    -- MUX_SEL_SIZE -> Bit length of mux selector signal
    constant MUX_SEL_SIZE : integer := integer(log2(real(MUX_SIZE)));
    -- COUNTER_SIZE -> Bit length of fsm counter
    constant COUNTER_SIZE : integer := integer(log2(real(N_SIZE)));

    -- "vector" -> 1 signed A column
    type a_vector is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);

    -- "matrix" -> 1 complete N_SIZE matrix of A, B, or C values
    type a_matrix is array (0 to N_SIZE-1) of a_vector;
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);
    type c_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    -- "array" -> full array of matrix wires to link PEs
    type c_array is array (0 to MUX_NUM-1) of c_matrix;

    -- Individual bundle of inputs for each mux
    type a_mux_input is array (0 to DIVIDE-1) of a_vector;
    type b_mux_input is array (0 to DIVIDE-1) of std_logic_vector(7 downto 0);

    -- "array" -> full array of mux input wire bundles, each element feeds 1 mux
    type a_mux_input_array is array (0 to MUX_NUM-1) of a_mux_input;
    type b_mux_input_array is array (0 to MUX_NUM-1) of b_mux_input;

    -- "array" -> full array of mux selector wires, each element feeds 1 mux
    type mux_sel_array is array (0 to MUX_NUM-1) of std_logic_vector(MUX_SEL_SIZE-1 downto 0); 

    -- "array" -> full array of mux output wires feeding PEs, each element feeds 1 PE
    type a_mux2pe_array is array (0 to MUX_NUM-1) of a_vector;
    type b_mux2pe_array is array (0 to MUX_NUM-1) of std_logic_vector(7 downto 0);

end package;