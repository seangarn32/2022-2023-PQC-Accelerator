library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity circulant_a_nxt is
    port(
        A0  : in    std_logic_vector(N_SIZE-1 downto 0);
        A   : out   a_matrix
    );  
end entity;

architecture rtl of circulant_a_nxt is

    signal A_sign : a_vector;
    signal A_n : a_matrix;

begin

    A_n(0) <= A_sign;

    CIRC_GEN : for i in 0 to N_SIZE-2 generate
        SHIFT : entity work.signed_shift(rtl)
            port map(
                A_n(i),
                A_n(i+1)
            );
    end generate CIRC_GEN;

    A <= A_n;

end rtl;