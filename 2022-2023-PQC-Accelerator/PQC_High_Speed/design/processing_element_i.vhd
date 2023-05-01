-- This is the first processing element in the chain
-- It takes in a column of the a matrix from load_a as well as the set of b/p values from load_b
-- It will it will do the multiplication of the a vector with the first set of b/p values and store the result in a register
-- It will then take the a vector and shift it to the next column
-- The result will be sent to the enc_dec mux which if it is encryption it will output the shifted vector; if it is decryption it will sign invert the top element
-- That resultant vector will be then multiplied with the second set of values of b/p values and stored in a register
-- Next, the original input a vector will be shifted and sign inverted twice and outputted of the pe 
-- Finally both values in the registers are outputted of the pe as well

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity processing_element_i is
    port (
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;
        
        A0       : in    a_vector;

        B_0       : in    std_logic_vector(7 downto 0);
        B_1       : in    std_logic_vector(7 downto 0);

        C_out_0   : out   c_matrix;
        C_out_1   : out   c_matrix;

        A2     : out    a_vector
    );
end entity;

architecture rtl of processing_element_i is

    signal C_mult_0 : c_matrix;
    signal C_mult_1 : c_matrix;
    signal A1     : a_vector;
    signal tmp     : a_vector;
    signal sc_A0  : a_vector;


begin
    -- Multiply AxB -> C_mult
    MULT_0 :      entity work.multiplier_nbit(rtl)
        port map(
            A0,
            B_0,

            C_mult_0
        );

    -- Register Output -> C_out
    REG_SUM_0 :   entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,
            C_mult_0,

            C_out_0
        );

    -- Add code to circular shift A0 to A1.  If encryption, don't add sign
    SHIFT_CELL:   entity work.shift_cell(rtl)
        port map (
            A0,

            sc_A0
        );

    ENC_DEC_MUX:  entity work.enc_dec_mux(rtl)
        port map (
            sc_A0,
            enc_dec,

            A1
        );

    MULT_1 :      entity work.multiplier_nbit(rtl)
        port map(
            A1,
            B_1,

            C_mult_1
        );

    REG_SUM_1 :   entity work.reg_nbit_matrix(rtl)
        port map(
            clk,
            rst,
            ena,
            C_mult_1,

            C_out_1
        );

    -- Add code to circular shift A0 to A2
    DOUBLE_SIGNED_CS : entity work.Dsigned_shift(rtl)
        port map (
            A0,

            tmp
        );
    
    REG_A :   entity work.reg_nbit_a(rtl)
        port map(
            clk,
            rst,
            ena,
            tmp,
    
            A2
        );

end rtl;