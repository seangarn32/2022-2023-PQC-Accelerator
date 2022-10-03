library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity multiplier_nbit is
    port(
        A   : in    a_vector;
        B   : in    std_logic_vector(7 downto 0);

        C   : out   c_matrix
    );
end entity;

architecture rtl of multiplier_nbit is

    signal C_hold   : c_matrix;
    signal C_inv    : c_matrix;

begin

    LOOP_N : for i in 0 to N_SIZE-1 generate

        LOOP_8 : for j in 0 to 7 generate
            C_hold(i)(j) <= (A(i)(0)) AND B(j);
        end generate LOOP_8;

        C_inv(i) <= NOT(C_hold(i)) + "00000001" when (A(i)(1)) = '1'
                    else C_hold(i);

    end generate LOOP_N;

    C <= C_inv;

end rtl;