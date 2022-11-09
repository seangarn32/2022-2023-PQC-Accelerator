library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity b_load is
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

architecture rtl of b_load is

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



-- There are 4 counters being used:
-- cnt is used as the overall program counter that is iterated each clock cycle; 
-- it is used only for encryption and is used to iterate the starting index for the n-length-jump odd vector generate statement;
-- cnt is used for the output selection of the mux for encryption
--
-- count is used only for encryption and is used for instances that the PE_CHAIN only need to run through the first even and odd blocks;
-- Examples: N_SIZE = 8 & DIVIDE = 2 -> PE_SIZE = 4; The PE_CHAIN only needs to run the first 4 even and first 4 odd
--           N_SIZE = 16 & DIVIDE = 2 -> PE_SIZE = 8; The PE_CHAIN only needs to run the first 8 even and first 8 odd
--
-- sig_c is used only internally for the n-length-jump even vector generate statement;
-- it is incremented until it reaches the second to last cycle of the total cycle count because the last even vector will always start
-- at the total_clock_cycles_needed - final_odd_vector - final_even_vector = PE_SIZE(it is equal to the total needed input cycles) - 2
--
-- ecnt is used for decryption and it is used for the decryption output selection on the mux and used for the iteration for the n-length
-- jump section generation;
-- it is being iterated by 2 since decryption uses double the amount of values per section compared to encryption;
-- ecnt will be set to 0 if the PE_SIZE * 2 = N_SIZE since there is no need for the n-length jump section to be generated
-- Example: N_SIZE = 8 & DIVIDE = 2 -> PE_SIZE = 4; All of the B values will be used in the b_sec_s section so b_sec_n should never be
-- used;
-- when ecnt is equal to 
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
                if(rst = '1') then
                    cnt <= 0;
                    sig_c <= 0;
                    count <= 0;
                    ecnt <= 0;
                elsif (load_b_ena = '1') then
                    if (enc_dec = '0') then
                        if (cnt = PE_SIZE-1) then
                            cnt <= cnt;
                        elsif (sig_c = PE_SIZE -2) then
                            sig_c <= sig_c;
                            cnt <= cnt + 1;
                        elsif (PE_SIZE*2 = N_SIZE) then
                            cnt <= 0;
                            count <= count+1;
                        else
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

    
    LOAD_B_SEC : for i in 0 to PE_SIZE-1 generate
        b_sec_0(i) <= B_in(i*2);
        b_sec_1(i) <= B_in(2*i + 1);
        b_sec_even(i) <= B_in((PE_SIZE)*sig_c + (2*i));
        b_sec_odd(i) <= B_in((PE_SIZE-1)*cnt + 2*i);
    end generate LOAD_B_SEC;
    
    LOAD_B_SEC_N : for i in 0 to PE_SIZE*2-1 generate
        b_sec_s(i) <= B_in(i);
        b_sec_n(i) <= B_in((PE_SIZE)*ecnt + i);
    end generate LOAD_B_SEC_N;

    LOAD_P_SEC : for i in 0 to PE_SIZE-1 generate
        p_sec_0(i) <= P_in(i*2);
        p_sec_1(i) <= P_in(2*i + 1);
        p_sec_even(i) <= P_in((PE_SIZE)*sig_c + (2*i));
        p_sec_odd(i) <= P_in((PE_SIZE-1)*cnt + 2*i);
    end generate LOAD_P_SEC;
    
    

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