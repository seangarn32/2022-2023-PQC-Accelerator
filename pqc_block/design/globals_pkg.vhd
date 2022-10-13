library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real."log2";

package globals_pkg is

    -- N_SIZE -> Size of initial A vector 
    constant N_SIZE : integer := 8;
    -- ROWS/COLS -> Section size to process (i.e. 4x8)
    constant ROWS : integer := 2;
    constant COLS : integer := 4;
    -- CYCLES -> Number of sections to be processed, also number of cycles necessary (1 section/cycle)
    constant NUM_A_SECTIONS : integer := (N_SIZE*N_SIZE)/(ROWS*COLS);
    constant NUM_B_SECTIONS : integer := (N_SIZE/COLS);
    
    -- COUNTER_SIZE -> Bit length of fsm counter
    constant COUNTER_SIZE : integer := integer(log2(real(N_SIZE)));

    -- "section" -> 1 signed A matrix subset
    type a_section_col is array (0 to ROWS-1) of std_logic_vector(1 downto 0);
    type b_section is array (0 to COLS-1) of std_logic_vector(7 downto 0);
    type c_section is array (0 to ROWS-1) of std_logic_vector(7 downto 0);

    -- "vector" -> 1 signed A column
    type a_vector is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);

    -- "matrix" -> 1 complete N_SIZE matrix of A, B, or C values
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);
    type c_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    -- "array" -> Array of wires to connect PEs
    type a_array is array (0 to COLS-1) of a_vector;
    type b_array is array (0 to NUM_B_SECTIONS-1) of b_section;
    type c_array is array (0 to COLS-1) of c_section;

end package;