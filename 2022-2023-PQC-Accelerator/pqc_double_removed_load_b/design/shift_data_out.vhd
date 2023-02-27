library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_out is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;
        
        c_in_0    : in    c_matrix;
        c_in_1    : in    c_matrix;
        c_in_2    : in    c_matrix;

        c_out_0   : out   std_logic_vector(7 downto 0);
        c_out_1   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of data_shift_out is

    signal c_sel_0        : c_matrix;
    signal c_sel_1        : c_matrix;
    signal c_nxt_0        : c_matrix;
    signal c_nxt_1        : c_matrix;
    signal c_enc_dec         : c_matrix;
    signal shift_ena    : std_logic;
    

begin

    process(clk)
    begin
        if(rising_edge(clk)) then
            if(rst = '1') then
                shift_ena <= '0';
            else 
                if(ena = '1') then
                    shift_ena <= '1';
                end if;
            end if;
        end if;
    end process;

    -- assigns c_enc_dec c_in_0 for encryption, or c_in_2 for decryption
    C_SELECT : entity work.mux2to1_C(rtl) 
        port map (
            c_in_0,
            c_in_2,

            enc_dec,

            c_enc_dec
        );

        c_sel_0(0) <= c_enc_dec(0) when shift_ena = '0' else c_nxt_0(0);

        REG_N_0 : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                c_sel_0(0),
                c_out_0
            );

    REG_GEN_0 : for i in 1 to N_SIZE-1 generate

        c_sel_0(i) <= c_enc_dec(i) when shift_ena = '0' else c_nxt_0(i);

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                c_sel_0(i),
                c_nxt_0(i-1)
            );
    end generate REG_GEN_0;

    c_sel_1(0) <= c_in_1(0) when shift_ena = '0' else c_nxt_1(0);

    REG_N_1 : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,
            c_sel_1(0),
            c_out_1
        );


    REG_GEN_1 : for i in 1 to N_SIZE-1 generate

        c_sel_1(i) <= c_in_1(i) when shift_ena = '0' else c_nxt_1(i);

        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                c_sel_1(i),
                c_nxt_1(i-1)
            );
    end generate REG_GEN_1;





end rtl;