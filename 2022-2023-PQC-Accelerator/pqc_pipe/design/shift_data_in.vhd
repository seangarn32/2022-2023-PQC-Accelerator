library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_in is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        a_in    : in    std_logic;
        b_in    : in    std_logic_vector(7 downto 0);

        a_out   : out   std_logic_vector(N_SIZE-1 downto 0);
        b_out   : out   b_matrix
    );
end entity;

architecture rtl of data_shift_in is

    signal a       : std_logic_vector(N_SIZE-1 downto 0);
    signal b       : b_matrix;

begin

    REG_1_0 : entity work.reg_1bit(rtl)
        port map(
            clk,
            rst,
            ena,
            a_in,
            a(0)
        );

    REG_1_GEN : for i in 1 to N_SIZE-1 generate
        REG_1 : entity work.reg_1bit(rtl)
            port map(
                clk,
                rst,
                ena,
                a(i-1),
                a(i)
            );
    end generate REG_1_GEN;

    REG_8_0 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,
            b_in,
            b(0)
        );

    REG_8_GEN : for i in 1 to N_SIZE-1 generate
        REG_8 : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                b(i-1),
                b(i)
            );
    end generate REG_8_GEN;

    a_out <= a;
    b_out <= b;

end rtl;