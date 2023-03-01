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
        P_in        : in    b_matrix;
        B_out       : out   b_hold_matrix;
        P_out       : out   b_hold_matrix
    );
end entity;

architecture rtl of load_b is

    signal b_tmp        :   b_hold_matrix;
    signal b_tmp_two        :   b_hold_matrix;
    signal p_tmp        :   b_hold_matrix;
    signal b_even        :   b_hold_matrix;
    signal b_odd      :   b_hold_matrix;
    signal p_even        :   b_hold_matrix;
    signal p_odd      :   b_hold_matrix;
    signal b_dec        : b_hold_matrix;
    signal count      :  integer := 0;
    signal count_hold      :  integer := 0;
    signal count_2      :  integer := 0;
    signal count_2_hold      :  integer := 0;
    signal count_enc        :  integer := 0;
    signal count_enc_hold        :  integer := 0;
    signal count_dec        :  integer := 0;
    signal count_dec_hold        :  integer := 0;
    signal b_init       :  std_logic;

    begin
        b_init <= '1' when (rst = '0' and load_b_ena = '1') else '0';
        count_hold <= count + 1 when (rst = '0' and load_b_ena = '1' and ((enc_dec = '0' and count < 2) or (enc_dec = '1' and count <= 0))) else 0;
        count_enc_hold <= count_enc + 1 when (rst = '0' and load_b_ena = '1' and (enc_dec = '0' and count >= 2));
        count_2_hold <= count_2 + 1 when (rst = '0' and load_b_ena = '1' and enc_dec = '0') else 0;
        count_dec_hold <= count_dec + 1 when (rst = '0' and load_b_ena = '1' and enc_dec = '1' and count > 0);

        LOAD_B_P_ENC : for i in 0 to PE_SIZE-1 generate
            b_even(i) <= B_in((PE_SIZE*2)*count_enc + i*2);
            b_odd(i) <= B_in((PE_SIZE*2)*count_enc + (i*2 + 1));

            p_even(i) <= P_in((PE_SIZE*2)*count_enc + i*2);
            p_odd(i) <= P_in((PE_SIZE*2)*count_enc + (i*2 + 1));
        end generate LOAD_B_P_ENC;

        LOAD_B_DEC : for i in 0 to PE_SIZE*2-1 generate
            b_dec(i) <= B_in((PE_SIZE*2)*count_dec + i);
        end generate LOAD_B_DEC;

        b_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
            b_even when (b_init = '1' and count_2 mod 2 = 1) else
            b_odd when (b_init = '1' and count_2 mod 2 = 0);

        b_tmp_two <= b_tmp when (enc_dec = '0') else b_dec when (enc_dec = '1' and b_init = '1');
    
        p_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
            p_even when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 1) else
            p_odd when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 0);   
    
        B_out <= b_tmp_two;
        P_out <= p_tmp;

        process(clk)
        begin
            if(rising_edge(clk)) then
                if (rst = '0' and load_b_ena = '1' and enc_dec = '0' and count >= 2) then
                    count <= 1;
                else 
                    count <= count_hold;
                end if;
                if (load_b_ena = '0') then
                    count_enc <= count_enc;
                else 
                    count_enc <= count_enc_hold;
                end if;
                count_2 <= count_2_hold;
                count_dec <= count_dec_hold;
            end if;
        end process;
end rtl;