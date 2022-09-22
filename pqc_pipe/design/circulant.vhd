library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity circulant is
    port(
        A0  : in    std_logic_vector(N_SIZE-1 downto 0);
        AN  : out   a_wire
    );  
end entity;

architecture rtl of circulant is

    signal A_sign : a_matrix;
    signal A : a_wire;

begin

    SIGNED : for i in 0 to N_SIZE-1 generate
        A_sign(i) <= '0' & A0(N_SIZE-1-i);
    end generate SIGNED;

    A(0) <= A_sign;

    CIRC_GEN_0 : entity work.signed_shift(rtl)
        port map(
            A_sign,
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