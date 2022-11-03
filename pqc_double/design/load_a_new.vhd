library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        pe_ena  : in    std_logic;
        shift_select : in std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is

    signal a0           : a_vector;
    signal a_signed     : a_vector;
    
begin

    -- Sign A_in to create A0
    SHIFT_0 : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SHIFT_0;

    REG_A  : entity work.reg_n_bit_a (rtl)
        port map(
            clk,
            rst,
            ena,

            a0,
            a_signed
        );

    A_out <= a_signed;
end rtl;