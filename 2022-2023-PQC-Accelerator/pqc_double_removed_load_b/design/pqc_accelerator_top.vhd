library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic;
        B_in    : in    std_logic_vector(7 downto 0);
        P_in    : in    std_logic_vector(7 downto 0);

        e1      : in    std_logic;
        e2      : in    std_logic;
        c2      : in    std_logic;

        C_out_0   : out   std_logic_vector(7 downto 0);
        C_out_1   : out   std_logic_vector(7 downto 0);

        a_index_out : out   std_logic_vector(7 downto 0);
        b_index_out : out   std_logic_vector(7 downto 0);
        p_index_out : out   std_logic_vector(7 downto 0);

        c_out_0_index_out : out   std_logic_vector(7 downto 0);
        c_out_1_index_out : out   std_logic_vector(7 downto 0);

        C_out_error_0     : out   std_logic_vector(7 downto 0);
        C_out_error_1     : out   std_logic_vector(7 downto 0);

        out_ena     : out   std_logic
    );
end entity;

architecture rtl of pqc_accelerator_top is

    signal A            : std_logic_vector(N_SIZE-1 downto 0);
    signal A0           : a_vector;
    signal B            : b_matrix;
    signal B0           : b_hold_matrix;
    signal P            : b_matrix;
    signal P0            : b_hold_matrix;
    signal C_0            : c_matrix;
    signal C_1            : c_matrix;
    signal C_accum_0      : c_matrix;
    signal C_accum_1      : c_matrix;
    signal C_accum_2      : c_matrix;

    signal dsi_ena      : std_logic;
    signal load_a_rst   : std_logic;
    signal load_a_ena   : std_logic;
    signal load_b_rst   : std_logic;
    signal load_b_ena   : std_logic;
    signal pe_ena       : std_logic;
    signal accum_ena    : std_logic;
    signal dso_ena      : std_logic;
    signal dso_rst      : std_logic;
    signal err_ena      : std_logic;

    signal C_out_0_hold : std_logic_vector(7 downto 0);
    signal C_out_1_hold : std_logic_vector(7 downto 0);

    signal b_tmp        :   b_hold_matrix;
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

    FSM : entity work.fsm(rtl)
        port map(
            clk,
            rst,
            ena,
            enc_dec,

            dsi_ena,
            load_a_rst,
            load_a_ena,
            load_b_rst,
            load_b_ena,
            pe_ena,
            accum_ena,
            dso_ena,
            dso_rst,
            err_ena,

            a_index_out,
            b_index_out,
            p_index_out,
            c_out_0_index_out,
            c_out_1_index_out,
            out_ena
        );

    DSI : entity work.data_shift_in(rtl)
        port map(
            clk,
            rst,
            dsi_ena,

            A_in,
            B_in,
            P_in,

            A,
            B,
            P
        );
    
    LOAD_A : entity work.load_a(rtl)
        port map(
            clk,
            load_a_rst,
            load_a_ena,
            enc_dec,
            A,

            A0
        );

        b_init <= '1' when (rst = '0' and load_b_ena = '1') else '0';
        count_hold <= count + 1 when (rst = '0' and load_b_ena = '1' and ((enc_dec = '0' and count < 2) or (enc_dec = '1' and count <= 0))) else 0;
        count_enc_hold <= count_enc + 1 when (rst = '0' and load_b_ena = '1' and (enc_dec = '0' and count >= 2));
        count_2_hold <= count_2 + 1 when (rst = '0' and load_b_ena = '1' and enc_dec = '0') else 0;
        count_dec_hold <= count_dec + 1 when (rst = '0' and load_b_ena = '1' and enc_dec = '1' and count > 0);

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

    LOAD_B_P_ENC : for i in 0 to PE_SIZE-1 generate
        b_even(i) <= B((PE_SIZE*2)*count_enc + i*2);
        b_odd(i) <= B((PE_SIZE*2)*count_enc + (i*2 + 1));

        p_even(i) <= P((PE_SIZE*2)*count_enc + i*2);
        p_odd(i) <= P((PE_SIZE*2)*count_enc + (i*2 + 1));
    end generate LOAD_B_P_ENC;

    LOAD_B_DEC : for i in 0 to PE_SIZE*2-1 generate
        b_dec(i) <= B((PE_SIZE*2)*count_dec + i);
    end generate LOAD_B_DEC;

    b_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
        b_even when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 1) else
        b_odd when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 0) else
        b_dec when (enc_dec = '1' and b_init = '1');
    
    p_tmp <= (others => (others => '0')) when (rst = '1' and b_init = '0') else
        p_even when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 1) else
        p_odd when (enc_dec = '0' and b_init = '1' and count_2 mod 2 = 0);   
    
    B0 <= b_tmp;
    P0 <= p_tmp;

    PE_CHAIN : entity work.pe_chain(rtl)
        port map(
            clk,
            rst,
            pe_ena,
            enc_dec,

            A0,
            B0,
            P0,

            C_0,
            C_1
        );

    ACCUM : entity work.accumulator_cell(rtl)
        port map(
            clk,
            rst,
            accum_ena,

            C_0,
            C_1,

            C_accum_0,
            C_accum_1,
            C_accum_2
        );

    DSO : entity work.data_shift_out(rtl)
        port map(
            clk,
            dso_rst,
            dso_ena,
            enc_dec,

            C_accum_0,
            C_accum_1,
            C_accum_2,

            C_out_0_hold, -- will be either cyphertext 1 or the decrypted plaintext
            C_out_1_hold  -- will be either cyphertext 2 or random data
        );

    ERR : entity work.const_error(rtl)
        port map(
            clk,
            rst,
            err_ena,
            enc_dec,

            C_out_0_hold, -- will be either cyphertext 1 or the decrypted plaintext
            C_out_1_hold, -- will be either cyphertext 2 or random data

            e1,
            e2,
            c2,

            C_out_error_0,
            C_out_error_1
        );

    C_out_0 <= C_out_0_hold;
    C_out_1 <= C_out_1_hold;

end architecture;