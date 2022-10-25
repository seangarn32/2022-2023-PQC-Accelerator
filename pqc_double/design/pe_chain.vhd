library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_chain is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A0      : in    std_logic_vector(N_SIZE-1 downto 0);
        B0      : in    b_matrix;
        B1      : in    b_matrix;

        C_out_0   : out   c_matrix
        C_out_1   : out   c_matrix
    );
end entity;

architecture rtl of pe_chain is

    signal B_REG_IN : in    std_logic_vector(7 downto 0)
    signal B_REG_OUT : in    std_logic_vector(7 downto 0)

begin

    REG_B_GEN : for i in 1 to (N_SIZE / DIVIDE) generate 

        B_REG : entity work.reg_8bit(rtl)
            port map(
                clk;
                rst; 
                ena;
        
                B_REG_IN;
                B_REG_OUT;
            );

    end generate REG_B_GEN;

    MUX_B_GEN : for i in 0 to MUX_NUM-1 generate 

        B_HOLD_ASSIGN : for j in 0 to DIVIDE-1 generate
            B_hold(i)(j) <= B(i+j*MUX_NUM);
            -- B_hold(i)(j) <= B(i*DIVIDE+j)
            -- To send B0, B1 to PE0
        end generate B_HOLD_ASSIGN;

        B_MUX : entity work.b_mux(rtl)
            port map(
                B_hold(i),
                sel(i),

                B_mux2pe(i)
            );
    end generate MUX_B_GEN;

    PE_0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,

            A_mux2pe(0),
            B_mux2pe(0),

            C(1)
        );

    PE_GEN : for i in 1 to MUX_NUM-2 generate
        PE : entity work.processing_element_n(rtl)
            port map(
                clk,
                rst,
                ena,

                A_mux2pe(i),
                B_mux2pe(i),
                C(i),

                C(i+1)
            );
    end generate PE_GEN;

    PE_N :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,

            A_mux2pe(MUX_NUM-1),
            B_mux2pe(MUX_NUM-1),
            C(MUX_NUM-1),

            C_out
        );

end architecture;