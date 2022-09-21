library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity circulant is
    port(
        A0  : in    a_matrix;
        AN  : out   a_wire
    );
end entity;

architecture rtl of circulant is

    signal A : a_wire;

begin

    A(0) <= A0;

    CIRC_GEN_0 : entity work.signed_shift(rtl)
        port map(
            A0,
            A(1)
        );

    CIRC_GEN : for i in 1 to N_SIZE-2 generate
        SHIFT : entity work.signed_shift(rtl)
            port map(
                A(i),
                A(i+1)
            );
    end generate CIRC_GEN;

    AN <= A;

end rtl;