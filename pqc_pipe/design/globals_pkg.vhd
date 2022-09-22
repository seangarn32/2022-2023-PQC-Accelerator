library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.math_real."log2";

package globals_pkg is

    constant N_SIZE : integer := 8;
    constant DIVIDE : integer := 2;
    constant MUX_NUM : integer := N_SIZE/DIVIDE;
    constant MUX_SIZE : integer := DIVIDE;
    constant MUX_LN_SIZE : integer := N_SIZE;
    constant MUX_SEL_SIZE : integer := integer(log2(real(MUX_SIZE)));

    type a_matrix is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    type a_wire is array (0 to N_SIZE-1) of a_matrix;
    type c_wire is array (0 to N_SIZE-1) of b_matrix;

    type a_wire_mux2pe is array (0 to MUX_NUM-1) of a_matrix;
    type b_wire_mux2pe is array (0 to MUX_NUM-1) of std_logic_vector(7 downto 0);

    type a_mux_input is array (0 to DIVIDE-1) of a_matrix;
    type a_mux_input_wire is array (0 to MUX_NUM-1) of a_mux_input;

    type b_mux_input is array (0 to DIVIDE-1) of std_logic_vector(7 downto 0);
    type b_mux_input_wire is array (0 to MUX_NUM-1) of b_mux_input;
    
    type mux_sel_array is array (0 to MUX_NUM) of std_logic_vector(MUX_SEL_SIZE-1 downto 0); 


end package;