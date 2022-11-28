library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real."log2";

package globals_pkg is

    -- N_SIZE -> Size of initial A vector 
    constant N_SIZE : integer := 8;
    -- DIVIDE -> Number of times to divide down PEs for pipelining
    constant DIVIDE : integer := 2;
    -- PE_SIZE -> Number of PEs used in design
    constant PE_SIZE : integer := N_SIZE/DIVIDE;
    
    -- COUNTER_SIZE -> Bit length of fsm counter
    constant COUNTER_SIZE : integer := 9;  --integer(log2(real(N_SIZE)));

    -- "vector" -> 1 signed A column
    type a_vector is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);

    -- "matrix" -> 1 complete N_SIZE matrix of A, B, or C values
    type a_matrix is array (0 to N_SIZE-1) of a_vector;
    type a_circ_hold_matrix is array (0 to N_SIZE + 1) of a_vector;
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);
    type c_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    -- "array" -> full array of matrix wires to link PEs
    type c_array is array (0 to PE_SIZE-1) of c_matrix;

    -- "array" -> Array of wires to connect PEs/REGs
    type a_array is array (0 to PE_SIZE-1) of a_vector;

    type b_section is array (0 to (PE_SIZE*2)-1) of std_logic_vector(7 downto 0);

end package;