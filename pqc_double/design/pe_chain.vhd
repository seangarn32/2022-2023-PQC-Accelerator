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

        C_out_0   : out   c_matrix;
        C_out_1   : out   c_matrix
    );
end entity;

architecture rtl of pe_chain is

    signal B_REG_IN : in    std_logic_vector(7 downto 0)
    signal B_REG_OUT : in    std_logic_vector(7 downto 0)
    signal a_wire       : a_array;
    signal b_wire       : b_matrix;
    signal p_wire       : b_matrix;
    signal c0_wire      : c_array;
    signal c1_wire      : c_array;

begin

    begin

    a_wire(0) <= A;
    b_wire(0) <= B0;
    p_wire(0) <= B1;

    PE_0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,
            enc_dec,

            a_wire(0),
            b_wire(0),
            p_wire(0),

            
            c0_wire(0),
            c1_wire(0),
            a_wire(1)
        );

    PE_N_GEN : for i in 1 to PE_SIZE-1 generate

        type reg_link_i_wire is array (0 to i) of std_logic_vector(7 downto 0);
        signal reg_link_i_0   : reg_link_i_wire := (others=>(others=>'0'));
        signal reg_link_i_1   : reg_link_i_wire := (others=>(others=>'0'));

    begin

        reg_link_i_0(0) <= B0(i);
        reg_link_i_1(0) <= B1(i);

        REG_FEED_GEN_I_0 : for j in 0 to i-1 generate
            REG_8 : entity work.reg_8bit(rtl)
                port map(
                    clk,
                    rst,
                    ena,

                    reg_link_i_0(j),

                    reg_link_i_0(j+1)
                );
        end generate REG_FEED_GEN_I_0;

        REG_FEED_GEN_I_1 : for j in 0 to i-1 generate
            REG_8 : entity work.reg_8bit(rtl)
                port map(
                    clk,
                    rst,
                    ena,

                    reg_link_i_1(j),

                    reg_link_i_1(j+1)
                );
        end generate REG_FEED_GEN_I_1;

        PE : entity work.processing_element_n(rtl)
            port map(
                clk,
                rst,
                ena,
                enc_dec,

                a_wire(i),
                reg_link_i_0(i),
                reg_link_i_1(i),
                c0_wire(i-1),
                c1_wire(i-1),

                
                c0_wire(i),
                c1_wire(i),
                a_wire(i+1)
            );
    end generate PE_N_GEN;



--    PE_N_GEN : for i in 1 to 1 generate
--
--        type reg_link_n_wire is array (0 to COLS-1) of std_logic_vector(7 downto 0);
--        signal reg_link_n   : reg_link_n_wire := (others=>(others=>'0'));
--
--    begin
--
--        reg_link_n(0) <= B(COLS-1);
--
--        REG_FEED_GEN_N : for j in 0 to COLS-2 generate
--            REG_8 : entity work.reg_8bit(rtl)
--                port map(
--                    clk,
--                    rst,
--                    ena,
--
--                    reg_link_n(j),
--
--                    reg_link_n(j+1)
--                );
--        end generate REG_FEED_GEN_N;
--
--        PE_N :   entity work.processing_element_n(rtl)
--            port map(
--                clk,
--                rst,
--                ena,
--
--                a_wire(COLS-1),
--                reg_link_n(COLS-1),
--                c_wire(COLS-2),
--
--                c_wire(COLS-1)
--            );
--
--    end generate PE_N_GEN; 

    C_out_0 <= c0_wire(PE_SIZE-1);
    C_out_1 <= c1_wire(PE_SIZE-1);

end architecture;