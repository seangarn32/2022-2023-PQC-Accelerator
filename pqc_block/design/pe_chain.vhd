library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_chain is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;

        A       : in    a_vector;
        B       : in    b_section;

        C_out   : out   c_section
    );
end entity;

architecture rtl of pe_chain is

    signal a_wire       : a_array;
    signal c_wire       : c_array;

begin

    a_wire(0) <= A;

    PE_0 :   entity work.processing_element_0(rtl)
        port map(
            clk,
            rst,
            ena,

            a_wire(0),
            B(0),

            a_wire(1),
            c_wire(0)
        );

    PE_I_GEN : for i in 1 to COLS-2 generate

        type reg_link_i_wire is array (0 to i) of std_logic_vector(7 downto 0);
        signal reg_link_i   : reg_link_i_wire := (others=>(others=>'0'));

    begin

        reg_link_i(0) <= B(i);

        REG_FEED_GEN_I : for j in 0 to i-1 generate
            REG_8 : entity work.reg_8bit(rtl)
                port map(
                    clk,
                    rst,
                    ena,

                    reg_link_i(j),

                    reg_link_i(j+1)
                );
        end generate REG_FEED_GEN_I;

        PE : entity work.processing_element_i(rtl)
            port map(
                clk,
                rst,
                ena,

                a_wire(i),
                reg_link_i(i),
                c_wire(i-1),

                a_wire(i+1),
                c_wire(i)
            );
    end generate PE_I_GEN;



    PE_N_GEN : for i in 1 to 1 generate

        type reg_link_n_wire is array (0 to COLS-1) of std_logic_vector(7 downto 0);
        signal reg_link_n   : reg_link_n_wire := (others=>(others=>'0'));

    begin

        reg_link_n(0) <= B(COLS-1);

        REG_FEED_GEN_N : for j in 0 to COLS-2 generate
            REG_8 : entity work.reg_8bit(rtl)
                port map(
                    clk,
                    rst,
                    ena,

                    reg_link_n(j),

                    reg_link_n(j+1)
                );
        end generate REG_FEED_GEN_N;

        PE_N :   entity work.processing_element_n(rtl)
            port map(
                clk,
                rst,
                ena,

                a_wire(COLS-1),
                reg_link_n(COLS-1),
                c_wire(COLS-2),

                c_wire(COLS-1)
            );

    end generate PE_N_GEN;

    C_out <= c_wire(COLS-1);






end architecture;