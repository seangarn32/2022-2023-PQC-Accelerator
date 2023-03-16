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
    signal p_tmp        :   b_hold_matrix;
    signal b_even        :   b_hold_matrix;
    signal b_odd      :   b_hold_matrix;
    signal p_even        :   b_hold_matrix;
    signal p_odd      :   b_hold_matrix;
    signal b_dec        : b_hold_matrix;
    signal count      :  std_logic_vector (1 downto 0) := "00";
    signal count_hold      :  std_logic_vector (1 downto 0) := "00";
    signal b_init       :  std_logic;
    signal set_idx            :  integer := 0;
    signal set_idx_hold            :  integer := 0;

    begin
        --b_init <= '1' when (rst = '0' and load_b_ena = '1') else '0';
        --count_hold <= count + "01" when (rst = '0' and load_b_ena = '1' and ((enc_dec = '0' and count < "10") or (enc_dec = '1' and count <= "00"))) else "00";
        --set_idx_hold <= set_idx + SET_SIZE when (rst = '0' and load_b_ena = '1' and ((enc_dec = '0' and count = "10")
                                                                                     --or (enc_dec = '1' and count > "00")));

        LOAD_B_P_ENC : for i in 0 to PE_SIZE-1 generate
            b_even(i) <= B_in(set_idx + i*2);
            b_odd(i) <= B_in(set_idx + i*2 + 1);
            p_even(i) <= P_in(set_idx + i*2);
            p_odd(i) <= P_in(set_idx + i*2 + 1);
        end generate LOAD_B_P_ENC;

        LOAD_B_DEC : for i in 0 to PE_SIZE*2-1 generate
            b_dec(i) <= B_in(set_idx + i);
        end generate LOAD_B_DEC;

        --b_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
            --b_even when (enc_dec = '0' and b_init = '1' and count = "01") else
            --b_odd when (enc_dec = '0' and b_init = '1' and count = "10") else 
            --b_dec when (enc_dec = '1' and b_init = '1');

        --p_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
        --    p_even when (enc_dec = '0' and b_init = '1' and count = "01") else
        --    p_odd when (enc_dec = '0' and b_init = '1' and count = "10");   
    
        B_out <= b_tmp;
        P_out <= p_tmp;

        process(clk)
        begin
            if (rst = '1') then
                b_tmp <= (others => (others => '0'));
                p_tmp <= (others => (others => '0'));
                --b_init <= '0';
                count <= "00";
                set_idx <= 0;
            else 
                if (rising_edge(clk)) then
                    if (load_b_ena = '1') then
                        --b_init <= '1';
                        if (enc_dec = '0') then
                            if (count < "01") then
                                b_tmp <= b_even;
                                p_tmp <= p_even;
                                count <= count + "01";
                            elsif (count = "01") then
                                b_tmp <= b_odd;
                                p_tmp <= p_odd;
                                count <= "00";
                                if (set_idx < N_SIZE - SET_SIZE) then
                                    set_idx <= set_idx + SET_SIZE;
                                end if;
                            end if;
                        else
                            b_tmp <= b_dec;
                            if (count <= "00") then
                                count <= count + "01";
                                if (set_idx < N_SIZE - SET_SIZE) then
                                    set_idx <= set_idx + SET_SIZE;
                                end if;
                            else
                                count <= "00";
                            end if;
                        end if;
                    else
                        set_idx <= set_idx;
                    end if;
                end if;
            end if;
        end process;
end rtl;