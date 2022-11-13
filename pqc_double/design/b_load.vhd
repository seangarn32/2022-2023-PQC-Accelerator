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
        B_out       : out   b_section;
        P_out       : out   b_section
    );
end entity;

architecture rtl of b_load is

    signal b_tmp        :   b_section;
    signal p_tmp        :   b_section;
    signal b_sec_0      :   b_section;
    signal b_sec_1      :   b_section;
    signal b_sec_even   :   b_section;
    signal b_sec_odd    :   b_section;
    signal b_sec_n      :   b_section;
    signal b_sec_s      :   b_section;
    signal p_sec_0      :   b_section;
    signal p_sec_1      :   b_section;
    signal p_sec_even   :   b_section;
    signal p_sec_odd    :   b_section;
    signal cnt          :   integer := 0;
    signal count        :   integer := 0;
    signal sig_c        :   integer := 0;
    signal ecnt         :   integer := 0;
    signal offst        :   integer := 0;



-- There are 4 counters being used:
-- cnt is used as the overall program counter that is iterated each clock cycle; 
-- it is used only for encryption and is used to iterate the starting index for the n-length-jump odd vector generate statement;
-- cnt is used for the output selection of the mux for encryption; if the PE_SIZE * 2 = N_SIZE then cnt will be set to 0 and stay at 0
-- since it will never be used in this situation; For other cases, cnt will be incremented by one until sig_c reaches its final vector,
-- then cnt will be incremented by one and then cnt will be stay the same until the reset signal is sent
--
-- count is used only for encryption and is used for instances that the PE_CHAIN only need to run through the first even and odd blocks;
-- Examples: N_SIZE = 8 & DIVIDE = 2 -> PE_SIZE = 4; The PE_CHAIN only needs to run the first 4 even and first 4 odd
--           N_SIZE = 16 & DIVIDE = 2 -> PE_SIZE = 8; The PE_CHAIN only needs to run the first 8 even and first 8 odd
-- count will be incremented by one every clock cycle however it will only ever be selected once in the mux 
--
-- sig_c is used only internally for the n-length-jump even vector generate statement;
-- it is incremented until it reaches the second to last cycle of the total cycle count because the last even vector will always start
-- at the total_clock_cycles_needed - final_odd_vector - final_even_vector = PE_SIZE(it is equal to the total needed input cycles) - 2,
-- so sig_c will stay at the same value until the reset signal is sent
--
-- ecnt is used for decryption and it is used for the decryption output selection on the mux and used for the iteration for the n-length
-- jump section generation;
-- it is being iterated by 2 since decryption uses double the amount of values per section compared to encryption;
-- ecnt will be set to 0 if the PE_SIZE * 2 = N_SIZE since there is no need for the n-length jump section to be generated
-- Example: N_SIZE = 8 & DIVIDE = 2 -> PE_SIZE = 4; All of the B values will be used in the b_sec_s section so b_sec_n should never be
-- used;
-- ecnt*(PE_SIZE*2) = N_SIZE when ecnt in this expression is equal to N_SIZE then ecnt will stay the same number since this is the last
-- vector of the B values until the reset signal is sent
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
                if(rst = '1') then
                    cnt <= 0;
                    sig_c <= 0;
                    count <= 0;
                    ecnt <= 0;
                    offst <= 0;
                elsif (load_b_ena = '1') then
                    if (enc_dec = '0') then
                        if (PE_SIZE*2 = N_SIZE) then -- DIVIDE = 2
                            cnt <= 0;
                            count <= count + 1;
                        elsif (N_SIZE > 16 and PE_SIZE = 4) then -- PE_SIZE = 4
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                offst <= offst + 1;
                            elsif (cnt >= 3) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                offst <= offst + 1;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        elsif (N_SIZE > 256) then                      -- Other
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                offst <= offst + 1;
                            elsif (cnt >= 1) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                if (cnt < 3) then
                                    offst <= -4;
                                else
                                    offst <= offst + 1;
                                end if;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        elsif (N_SIZE = 32) then                      -- Other
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                if (PE_SIZE /= 8) then
                                    offst <= offst + 1;
                                else
                                --offst <= offst + 1;       N=32,D=4,PE=8 No additional increment
                                end if;
                            elsif (cnt >= 1) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                if (cnt < 3) then
                                    offst <= -4;
                                else
                                    offst <= offst + 1;
                                end if;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        elsif (N_SIZE = 64) then                      -- Other
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                if (PE_SIZE = 8) then
                                    offst <= -12;      -- N=64,D=4,PE=16 Subtract 12
                                else
                                    offst <= offst + 1;
                                end if;
                            elsif (cnt >= 1) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                if (cnt < 3) then
                                    offst <= -4;
                                else
                                    offst <= offst + 1;
                                end if;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        elsif (N_SIZE = 128) then                      -- Other
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                if (PE_SIZE = 32) then
                                    offst <= -28;      -- N=128,D=4,PE=32 Subtract 28
                                elsif (PE_SIZE = 16) then
                                    offst <= -8;    -- N=128,D=8,PE=16 Subtract 8
                                else
                                    offst <= offst + 1;
                                end if;
                            elsif (cnt >= 1) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                if (cnt < 3) then
                                    offst <= -4;
                                else
                                    offst <= offst + 1;
                                end if;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        elsif (N_SIZE = 256) then                      -- Other
                            if (cnt*PE_SIZE + PE_SIZE = N_SIZE) then
                                cnt <= cnt;
                            elsif ((sig_c*PE_SIZE) + (PE_SIZE*2) = N_SIZE) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                                if (PE_SIZE = 64) then
                                    offst <= -60;           -- N=256,D=4,PE=64 Subtract 60
                                elsif (PE_SIZE = 32) then
                                    offst <= -24;           -- N=256,D=8,PE=32 Subtract 24
                                elsif (PE_SIZE = 16) then
                                    offst <= 0;             -- N=256,D=16,PE=16 Offst = 0
                                else
                                    offst <= offst + 1;      
                                end if;
                            elsif (cnt >= 1) then
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                                if (cnt < 3) then
                                    offst <= -4;
                                else
                                    offst <= offst + 1;
                                end if;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c + 1;
                            end if;
                        else                            -- N_SIZE = 8,16
                            if (cnt = PE_SIZE-1) then
                                cnt <= cnt;
                            elsif (sig_c = PE_SIZE-2) then
                                sig_c <= sig_c;
                                cnt <= cnt + 1;
                            else
                                cnt <= cnt + 1;
                                sig_c <= sig_c +1;
                            end if;
                        end if;
                    elsif (enc_dec = '1') then
                        if (PE_SIZE*2 = N_SIZE) then -- DIVIDE = 2
                            ecnt <= 0;
                        elsif (PE_SIZE*2 /= N_SIZE and PE_SIZE*4 /= N_SIZE) then
                            if(ecnt*PE_SIZE + PE_SIZE*2 = N_SIZE) then -- DIVIDE = 8,16,32,etc
                                ecnt <= ecnt;
                            else
                                ecnt <= ecnt + 2;
                            end if;
                        else
                            if(ecnt*(PE_SIZE*2) = N_SIZE) then -- DIVIDE = 4
                                ecnt <= ecnt;
                            else
                                ecnt <= ecnt + 2;
                            end if;
                        end if;
                    end if;
                end if;
        end if;
    end process;

    -- Generate statements for all encryption B values
    LOAD_B_SEC : for i in 0 to PE_SIZE-1 generate
        -- b_sec_0 is the first even set of B values
        b_sec_0(i) <= B_in(i*2);
        -- b_sec_1 is the first odd set of B values
        b_sec_1(i) <= B_in(2*i + 1);
        -- b_sec_even is the next even set of B values; the index is determined by sig_c
        b_sec_even(i) <= B_in((PE_SIZE)*sig_c + (2*i));
        -- b_sec_odd is the next odd set of B values; the index is determined by cnt
        b_sec_odd(i) <= B_in((PE_SIZE-1)*cnt + (2*i + offst));
    end generate LOAD_B_SEC;

    -- Generate statements for all decryption B values
    LOAD_B_SEC_N : for i in 0 to PE_SIZE*2-1 generate
        -- b_sec_s is the first set of B values
        b_sec_s(i) <= B_in(i);
        -- b_sec_n is the next set of B values; the index is determined by ecnt
        b_sec_n(i) <= B_in((PE_SIZE)*ecnt + i);
    end generate LOAD_B_SEC_N;

    -- Generate statements for all encryption P values
    LOAD_P_SEC : for i in 0 to PE_SIZE-1 generate
        -- p_sec_0 is the first even set of P values
        p_sec_0(i) <= P_in(i*2);
        -- p_sec_1 is the first odd set of P values
        p_sec_1(i) <= P_in(2*i + 1);
        -- p_sec_even is the next even set of P values; the index is determined by sig_c
        p_sec_even(i) <= P_in((PE_SIZE)*sig_c + (2*i));
        -- p_sec_odd is the next odd set of P values; the index is determined by cnt
        p_sec_odd(i) <= P_in((PE_SIZE-1)*cnt + (2*i + offst));
    end generate LOAD_P_SEC;
    
    -- This is the output mux for the B values; There are 7 possible outputs for this mux: 5 for encryption and 2 for decryption;
    -- The output of the mux will be set to the b_tmp signal
    -- Encryption:
    -- When b_load is reset, the first output of the mux is going to be b_sec_0 i.e. the first set of even B values;
    -- Next, if the conditions are set that count is activated then the first b_sec_1(The one with count parameter) is outputted &
    -- then this will be the final output for this set of B vlaues;
    -- Otherwise, the second b_sec_1 will be outputted of the mux i.e. the first set of odd B values;
    -- Third, b_sec_even will then be selected i.e. the next set of even B values;
    -- Fourth, b_sec_odd will then be selected i.e. the next set of odd B values;
    -- The output will then flip between b_sec_even and b_sec_odd every clock cycle with b_sec_even on every even clock cycle and 
    -- b_sec_odd on every odd clock cycle; this will continue until cnt reaches the final index for the B values
    -- Decryption:
    -- when b_load is resest, the first output of the mux is going to be b_sec_s i.e. the first set of B values;
    -- Next, if ecnt is set to zero then the output will stay at b_sec_s; Otherwise, b_sec_n will be set to the output and it will
    -- stay as the output
    b_tmp <= b_sec_0 when (rst = '1' and enc_dec = '0' and load_b_ena = '1') else
                b_sec_1 when (enc_dec = '0' and load_b_ena = '1' and count = 1) else
                b_sec_1 when (enc_dec = '0' and load_b_ena = '1' and cnt = 1) else
                b_sec_even when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 0) else
                b_sec_odd when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 1) else
                b_sec_s when (rst = '1' and enc_dec = '1' and load_b_ena = '1') else
                b_sec_n when (enc_dec = '1' and load_b_ena = '1' and ecnt > 0);


    -- This is the output mux for the P values; There are 5 possible outputs for this mux: all are for encryption
    -- The output of the mux will be set to the p_tmp signal
    -- Encryption:
    -- When b_load is reset, the first output of the mux is going to be p_sec_0 i.e. the first set of even P values;
    -- Next, if the conditions are set that count is activated then the first p_sec_1(The one with count parameter) is outputted &
    -- then this will be the final output for this set of P vlaues;
    -- Otherwise, the second p_sec_1 will be outputted of the mux i.e. the first set of odd P values;
    -- Third, p_sec_even will then be selected i.e. the next set of even P values;
    -- Fourth, p_sec_odd will then be selected i.e. the next set of odd P values;
    -- The output will then flip between p_sec_even and b_sec_odd every clock cycle with p_sec_even on every even clock cycle and 
    -- p_sec_odd on every odd clock cycle; this will continue until cnt reaches the final index for the P values
    p_tmp <= p_sec_0 when (rst = '1' and enc_dec = '0' and load_b_ena = '1') else 
                p_sec_1 when (enc_dec = '0' and load_b_ena = '1' and count = 1) else
                p_sec_1 when (enc_dec = '0' and load_b_ena = '1' and cnt = 1) else
                p_sec_even when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 0) else
                p_sec_odd when (enc_dec = '0' and load_b_ena = '1' and cnt > 1 and cnt mod 2 = 1);


    -- B_out is the output of the component and it will be set to the values of b_tmp every clock cycle
    -- P_out is the output of the component and it will be set to the values of p_tmp every clock cycle
    B_out <= b_tmp;
    P_out <= p_tmp;

 end rtl;