library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

package globals_pkg is

    constant N_SIZE : integer := 8;

    type a_matrix is array (0 to N_SIZE-1) of std_logic_vector(1 downto 0);
    type b_matrix is array (0 to N_SIZE-1) of std_logic_vector(7 downto 0);

    type a_wire is array (1 to N_SIZE-1) of a_matrix;
    type c_wire is array (1 to N_SIZE-1) of b_matrix;

end package;