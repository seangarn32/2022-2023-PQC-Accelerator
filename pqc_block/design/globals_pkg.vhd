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

    -- NUM_X_SECTIONS -> Number of sections to be processed, also number of cycles necessary (1 section/cycle)
    constant NUM_A_SECTIONS : integer := (N_SIZE*N_SIZE)/(ROWS*COLS);
    constant NUM_B_SECTIONS : integer := (N_SIZE/COLS);
    constant NUM_C_SECTIONS : integer := (N_SIZE/ROWS);
    
    -- COUNTER_SIZE -> Bit length of counters
    constant COUNTER_SIZE_FSM : integer := integer(log2(real(N_SIZE)));
    constant COUNTER_SIZE_A : integer := integer(log2(real(NUM_A_SECTIONS)));
    constant COUNTER_SIZE_B : integer := integer(log2(real(NUM_B_SECTIONS)));
    constant COUNTER_SIZE_C : integer := integer(log2(real(NUM_C_SECTIONS)));

    -- "section" -> 1 block used for PE operation
    type a_section_col is array (0 to ROWS-1) of std_logic_vector(1 downto 0);
    type b_section is array (0 to COLS-1) of std_logic_vector(7 downto 0);
    type c_section is array (0 to ROWS-1) of std_logic_vector(7 downto 0);

    -- "vector" -> 1 signed A column
    type a_vector is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);

    -- "matrix" -> 1 complete N_SIZE matrix of A, B, or C values
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);
    type c_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    -- "array" -> Array of wires to connect PEs/REGs
    type a_array is array (0 to COLS-1) of a_vector;
    type b_array is array (0 to NUM_B_SECTIONS-1) of b_section;
    type c_array is array (0 to COLS-1) of c_section;

end package;