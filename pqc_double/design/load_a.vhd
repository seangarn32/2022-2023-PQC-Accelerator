library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity load_a is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        pe_ena  : in    std_logic;
        enc_dec : in    std_logic;

        A_in    : in    std_logic_vector(N_SIZE-1 downto 0);
        A_out   : out   a_vector
    );
end entity;

architecture rtl of load_a is

    signal a0          : a_vector;
    signal a_nxt         : a_matrix;
    signal a1          : a_vector;
    signal a2           : a_vector;
    signal tmp         : a_vector;
    signal a_reg         : a_vector;
    
    signal count        : std_logic_vector(N_SIZE/PE_SIZE downto 0) := (others => '0');
    signal count_nxt    : std_logic_vector(N_SIZE/PE_SIZE downto 0) := (others => '0');
    
begin
    count <= count_nxt;
    

    -- Sign A_in to create A0
    SIGNED : for i in 0 to N_SIZE-1 generate
        a0(i) <= '0' & A_in(N_SIZE-1-i);
    end generate SIGNED;

    a_nxt(0) <= a0;

    --ENC_SHIFT_CELL_1:   entity work.signed_shift(rtl)
    --port map (
    --        a_nxt(i),
--
    --        a_nxt(i + 1)
    --    );

    ENC_DEC_SHIFT_CELL : for i in 0 to PE_SIZE*2 - 2 generate
        ENC_SHIFT_CELL_N: entity work.signed_shift(rtl)
            port map (
                a_nxt(i),

                a_nxt(i+1)
            );
    end generate ENC_DEC_SHIFT_CELL;

    tmp <= a0 when (rst = '1' AND count /= (N_SIZE/PE_SIZE)) else
             a_nxt(1) when (count /= (N_SIZE/PE_SIZE) AND enc_dec = '0') else
             a_nxt(PE_SIZE*2 - 1) when ((count(0) = '0') AND count /= (N_SIZE/PE_SIZE) AND enc_dec = '1');
             --a3 when (count mod 2 = '1' AND count /= (N_SIZE/PE_SIZE) AND enc_dec = '1');

    REG_A :   entity work.reg_nbit_a(rtl)
    port map(
        clk,
        rst,
        pe_ena,
        tmp,

        a_reg
    );
    
    count_nxt <= count + '1';
    a_nxt(0) <= a_reg;
    A_out <= a_reg;

end rtl;