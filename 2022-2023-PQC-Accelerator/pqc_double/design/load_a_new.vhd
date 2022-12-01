library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;
use ieee.numeric_std.all;

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

    signal a_col           : a_vector;
    
    signal signedVal  : std_logic_vector(N_SIZE - 1 downto 0) := (others => '0');
    signal signedOne  : signed(N_SIZE - 1 downto 0);
    signal signedN  : signed(N_SIZE - 1 downto 0);
    signal signedDec  : signed(N_SIZE - 1 downto 0);

    signal a_signed     : a_vector;
    


begin

    process
    begin
    signedOne <= shift_left(signed(signedVal), 1);
    signedN <= shift_left(signed(signedVal), N_SIZE / PE_SIZE);
    signedDec <= shift_left(signed(signedVal), PE_SIZE * 2);

    A_SELECTION : entity work.mux4to1 (rtl)
        port map(
            signedVal,
            signedOne,
            signedN,
            signedDec,

            shift_select,

            signedVal
        );

    -- Sign A_in to create A0
    SHIFT_0 : for i in 0 to N_SIZE-1 generate
        a_col(i) <= signedVal(i) & A_in(N_SIZE-1-i);
    end generate SHIFT_0;



    REG_A  : entity work.reg_nbit_a (rtl)
        port map(
            clk,
            rst,
            pe_ena,

            a_col,
            a_signed
        );

        
    

    A_out <= a_signed;
    end process
end rtl;