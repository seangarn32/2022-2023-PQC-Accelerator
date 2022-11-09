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
        B_out       : out   b_matrix;
        P_out       : out   b_matrix
    );
end entity;

architecture rtl of load_b is

    signal b_tmp        :   b_matrix;
    signal p_tmp        :   b_matrix;
    signal b_sec_0      :   b_matrix;
    signal b_sec_1      :   b_matrix;
    signal b_sec_even   :   b_matrix;
    signal b_sec_odd    :   b_matrix;
    signal b_sec_n      :   b_matrix;
    signal b_sec_s      :   b_matrix;
    signal p_sec_0      :   b_matrix;
    signal p_sec_1      :   b_matrix;
    signal p_sec_even   :   b_matrix;
    signal p_sec_odd    :   b_matrix;
    signal cnt          :   integer := 0;
    signal count        :   integer := 0;
    signal sig_c        :   integer := 0;
    signal ecnt         :   integer := 0;

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
                if(rst = '1') then
                    cnt <= 0;
                    sig_c <= 0;
                elsif (load_b_ena = '1') then
                if (enc_dec = '0') then
                    --if (count = 1) then
                        --cnt <= cnt + 1;
                        --sig_c <= sig_c +1;
                        --count <= 0;
                    if (cnt = PE_SIZE-1) then
                        cnt <= cnt;
                    elsif (sig_c = PE_SIZE -2) then
                        sig_c <= sig_c;
                        cnt <= cnt + 1;
                    elsif (PE_SIZE*2 = N_SIZE) then
                        cnt <= 0;
                        count <= count+1;
                    else
                        --count <= count + 1;
                        cnt <= cnt + 1;
                        sig_c <= sig_c +1;
                    end if;
                elsif (enc_dec = '1') then
                    if(ecnt*(PE_SIZE*2) = N_SIZE) then
                        ecnt <= ecnt;
                    elsif(PE_SIZE*2 = N_SIZE) then
                        ecnt <= 0;
                    else
                        ecnt <= ecnt + 2;
                    end if;
                end if;
                end if;
        end if;
    end process;

    
    LOAD_B_SEC_0 : for i in 0 to PE_SIZE-1 generate
        b_sec_0(i) <= B_in(i*2);
    end generate LOAD_B_SEC_0;

    LOAD_B_SEC_1 : for i in 0 to PE_SIZE-1 generate
        b_sec_1(i) <= B_in(2*i + 1);
    end generate LOAD_B_SEC_1;

    LOAD_B_SEC_EVEN : for i in 0 to PE_SIZE-1 generate
        b_sec_even(i) <= B_in((PE_SIZE)*sig_c + (2*i));
    end generate LOAD_B_SEC_EVEN;
    
    LOAD_B_SEC_ODD : for i in 0 to PE_SIZE-1 generate
        b_sec_odd(i) <= B_in((PE_SIZE-1)*cnt + 2*i);
    end generate LOAD_B_SEC_ODD;
    
    LOAD_B_SEC_N : for i in 0 to PE_SIZE*2-1 generate
        b_sec_n(i) <= B_in((PE_SIZE)*ecnt + i);
    end generate LOAD_B_SEC_N;

    LOAD_B_SEC_S : for i in 0 to PE_SIZE*2-1 generate
        b_sec_s(i) <= B_in(i);
    end generate LOAD_B_SEC_S;

    LOAD_P_SEC_0 : for i in 0 to PE_SIZE-1 generate
        p_sec_0(i) <= P_in(i*2);
    end generate LOAD_P_SEC_0;

    LOAD_P_SEC_1 : for i in 0 to PE_SIZE-1 generate
        p_sec_1(i) <= P_in(2*i + 1);
    end generate LOAD_P_SEC_1;
        
    LOAD_P_SEC_EVEN : for i in 0 to PE_SIZE-1 generate
        p_sec_even(i) <= P_in((PE_SIZE)*sig_c + (2*i));
    end generate LOAD_P_SEC_EVEN;
    
    LOAD_P_SEC_ODD : for i in 0 to PE_SIZE-1 generate
        p_sec_odd(i) <= P_in((PE_SIZE-1)*cnt + 2*i);
    end generate LOAD_P_SEC_ODD;
        

    b_tmp <= b_sec_0 when (rst = '1' and enc_dec = '0' and load_b_ena = '1') else
                b_sec_1 when (enc_dec = '0' and load_b_ena = '1' and count = 1) else
                b_sec_1 when (enc_dec = '0' and load_b_ena = '1' and cnt = 1) else
                b_sec_even when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 0) else
                b_sec_odd when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 1) else
                b_sec_s when (rst = '1' and enc_dec = '1' and load_b_ena = '1') else
                b_sec_n when (enc_dec = '1' and load_b_ena = '1' and ecnt > 0);

    p_tmp <= p_sec_0 when (rst = '1' and enc_dec = '0' and load_b_ena = '1') else 
                p_sec_1 when (enc_dec = '0' and load_b_ena = '1' and count = 1) else
                p_sec_1 when (enc_dec = '0' and load_b_ena = '1' and cnt = 1) else
                p_sec_even when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 0) else
                p_sec_odd when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 1);

    B_out <= b_tmp;
    P_out <= p_tmp;

 end rtl;