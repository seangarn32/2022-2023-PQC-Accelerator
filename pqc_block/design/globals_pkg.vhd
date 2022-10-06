library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real."log2";

package globals_pkg is

    -- N_SIZE -> Size of initial A vector 
    constant N_SIZE : integer := 64;
    -- ROWS/COLS -> Section size to process (i.e. 4x8)
    constant ROWS : integer := 4;
    constant COLS : integer := 8;
    -- CYCLES -> Number of sections to be processed, also number of cycles necessary (1 section/cycle)
    constant NUM_A_SECT : integer := (N_SIZE*N_SIZE)/(ROWS*COLS);
    constant NUM_B_SECT : integer := (N_SIZE/COLS);

    -- 
    constant A_MUX_SEL_SIZE : integer := integer(log2(real(NUM_A_SECT)));
    constant B_MUX_SEL_SIZE : integer := integer(log2(real(NUM_B_SECT)));
    
    -- COUNTER_SIZE -> Bit length of fsm counter
    constant COUNTER_SIZE : integer := integer(log2(real(N_SIZE)));

    -- "vector" -> 1 signed A column
    type a_vector is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);

    -- "section" -> 1 signed A matrix subset
    type a_section is array (0 to ROWS*COLS-1) of std_logic_vector(1 downto 0);
    type b_section is array (0 to COLS-1) of std_logic_vector(7 downto 0);
    type c_section is array (0 to ROWS-1) of std_logic_vector(7 downto 0);
    
    -- "ab" -> Intermediary handling of multipication result before saving in c_section
    type ab_section is array (0 to ROWS*COLS-1) of std_logic_vector(7 downto 0);
    type ab_row is array (0 to COLS-1) of std_logic_vector(7 downto 0);
    type ab_row_array is array (0 to ROWS-1) of ab_row;

    -- "matrix" -> 1 complete N_SIZE matrix of A, B, or C values
    type a_matrix is array (0 to N_SIZE-1) of a_vector;
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);
    type c_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    -- Individual bundle of inputs for each mux
    type a_mux_input is array (0 to NUM_A_SECT-1) of a_section;
    type b_mux_input is array (0 to COLS-1) of b_section;

end package;