library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A0      : in    std_logic_vector(N_SIZE-1 downto 0);
        B       : in    b_matrix;

        A_out   : out   a_matrix;
        C_out   : out   b_matrix
    );
end entity;

architecture rtl of pqc_accelerator_top is

begin

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            ena,
            A0,
            B,
            A_out,
            C_out
        );

end architecture;