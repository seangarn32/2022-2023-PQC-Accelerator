-- Takes in input values from load_a and load_b
-- First, it will determine what values are needed for the b values in the WIRE_SELECT section:
-- if it is encryption then it will use the two seperate vectors B and P
-- if it is decryption then it will split the B vector into an even vector and an odd vector

-- The a_wire, b_wire, p_wire are used for the inputs of the PEs
-- The c0_wire, c1_wire are used to link together results of the PEs

-- The wires allow for the inputs and results to be linked together so that they can be used in other components dynamically
-- The registers are used to delay the input values for the B/P values until they are needed-# of registers = # of cycles delayed
-- The registers_links are used to link the inputs and outputs of the registers together

-- Only the final element of each c_wires needs to be outputted as this is the final accumulated sum of the computation

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pe_chain is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;

        A0      : in    a_vector;
        B0      : in    b_hold_matrix;
        B1      : in    b_hold_matrix;

        C_out_0   : out   c_matrix;
        C_out_1   : out   c_matrix
    );
end entity;

architecture rtl of pe_chain is

    signal a_wire       : a_array;
    signal b_wire       : b_hold_matrix;
    signal b_wire_temp       : b_hold_matrix;
    signal b_wire_0       : b_hold_matrix;
    signal b_wire_1       : b_hold_matrix;
    signal p_wire       : b_hold_matrix;
    signal p_wire_0       : b_hold_matrix;
    signal p_wire_1       : b_hold_matrix;
    signal c0_wire      : c_array;
    signal c1_wire      : c_array;

begin

    a_wire(0) <= A0;
    b_wire_temp <= B0;
            
    DEC_ASSIGN: for i in 0 to PE_SIZE-1 generate
        p_wire_1(i) <= b_wire_temp(2*i+1);
        b_wire_1(i) <= b_wire_temp(2*i);
    end generate DEC_ASSIGN;

    p_wire_0 <= B1;
    b_wire_0 <= B0;

    WIRE_SELECT : entity work.mux2to1_B(rtl)
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