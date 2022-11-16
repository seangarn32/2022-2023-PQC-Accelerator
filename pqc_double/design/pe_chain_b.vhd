library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_chain_b is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;

        A0      : in    a_vector;
        B0      : in    b_section;
        B1      : in    b_section;

        C_out_0   : out   c_matrix;
        C_out_1   : out   c_matrix
    );
end entity;

architecture rtl of pe_chain_b is

    signal a_wire       : a_array;
    signal b_wire       : b_section;
    signal b_wire_temp       : b_section;
    signal b_wire_0       : b_section;
    signal b_wire_1       : b_section;
    signal p_wire       : b_section;
    signal p_wire_0       : b_section;
    signal p_wire_1       : b_section;
    signal c0_wire      : c_array;
    signal c1_wire      : c_array;

begin

    a_wire(0) <= A0;
    b_wire_temp <= B0;
            
    DEC_ASSIGN: for i in 0 to 3 generate
        p_wire_1(i) <= b_wire_temp(2*i+1);
        b_wire_1(i) <= b_wire_temp(2*i);
    end generate DEC_ASSIGN;

    p_wire_0 <= B1;
    b_wire_0 <= B0;

    WIRE_SELECT : entity work.mux2to1_Bselect(rtl)
        port map (
            p_wire_0,
            b_wire_0,
            p_wire_1,
            b_wire_1,

            enc_dec,

            p_wire,
            b_wire
        );

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

    PE_N_GEN : for i in 1 to PE_SIZE-2 generate

        type reg_link_i_wire is array (0 to i) of std_logic_vector(7 downto 0);
        signal reg_link_i_0   : reg_link_i_wire := (others=>(others=>'0'));
        signal reg_link_i_1   : reg_link_i_wire := (others=>(others=>'0'));

    begin

        reg_link_i_0(0) <= b_wire(i);
        reg_link_i_1(0) <= p_wire(i);

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



    PE_L_GEN : for i in 1 to 1 generate

        type reg_link_n_wire is array (0 to PE_SIZE-1) of std_logic_vector(7 downto 0);
        signal reg_link_n_0   : reg_link_n_wire := (others=>(others=>'0'));
        signal reg_link_n_1   : reg_link_n_wire := (others=>(others=>'0'));

   begin

    reg_link_n_0(0) <= b_wire(PE_SIZE-1);
    reg_link_n_1(0) <= p_wire(PE_SIZE-1);

        REG_FEED_GEN_N0 : for j in 0 to PE_SIZE-2 generate
            REG_8 : entity work.reg_8bit(rtl)
                port map(
                    clk,
                    rst,
                    ena,

                    reg_link_n_0(j),

                    reg_link_n_0(j+1)
                );
        end generate REG_FEED_GEN_N0;

        REG_FEED_GEN_N1 : for j in 0 to PE_SIZE-2 generate
        REG_8 : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,

                reg_link_n_1(j),

                reg_link_n_1(j+1)
            );
        end generate REG_FEED_GEN_N1;

        PE_N :   entity work.processing_element_l(rtl)
            port map(
                clk,
                rst,
                ena,
                enc_dec,

                a_wire(PE_SIZE-1),
                reg_link_n_0(PE_SIZE-1),
                reg_link_n_1(PE_SIZE-1),
                c0_wire(PE_SIZE-2),
                c1_wire(PE_SIZE-2),

                c0_wire(PE_SIZE-1),
                c1_wire(PE_SIZE-1)
            );

    end generate PE_L_GEN; 

    C_out_0 <= c0_wire(PE_SIZE-1);
    C_out_1 <= c1_wire(PE_SIZE-1);

end architecture;