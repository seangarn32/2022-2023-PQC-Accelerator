library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_i is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        
        A       : in    a_matrix;
        B       : in    std_logic_vector(7 downto 0);

        C_out   : out   b_matrix
    );
end entity;

architecture rtl of processing_element_i is

    signal C_mult : b_matrix;

begin
    -- Multiply AxB -> C_mult
    MULT :      entity work.multiplier_8bit(rtl)
        port map(
            A,
            B,
            C_mult
        );

    -- Register Output -> C_out
    REG_SUM :   entity work.reg_aclr_en_8bit(arch)
        port map(
            clk,
            rst,
            ena,
            C_mult,

            C_out
        );

end rtl;