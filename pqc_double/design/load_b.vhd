library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_b is
    port(
        clk         : in    std_logic;
        rst         : in    std_logic;
        load_b_ena  : in    std_logic;
        enc_dec     : in    std_logic;

        B_in        : in    b_matrix;
        B_out       : out   b_matrix
    );
end entity;

architecture rtl of load_b is

    signal b_hold   :   b_matrix;
    signal b_reg    :   b_matrix;

    -- Register either initial B values or next shifted B values
    REG_B : entity work.reg_b(rtl)
    port map(
        clk,
        rst,
        ena,

        b_hold,
        b_reg
    );

    B_out <= b_reg(0);

 end rtl;