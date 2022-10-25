library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity data_shift_out is
    port(
        clk     : in    std_logic;
        rst     : in    std_logic;
        ena     : in    std_logic;
        c_accum : in    c_matrix;
		  
        c_out   : out   std_logic_vector(7 downto 0)
    );
end entity;

architecture rtl of data_shift_out is

    signal c_sel        : c_matrix;
    signal c_nxt        : c_matrix;
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

    c_sel <= c_accum when shift_ena = '0' else
	 c_nxt;
    REG_GEN : for i in 0 to N_SIZE-2 generate
			
        REG : entity work.reg_8bit(rtl)
            port map(
                clk,
                rst,
                ena,
                c_sel(i),
                c_nxt(i+1)
            );
    end generate REG_GEN;

    REG_N : entity work.reg_8bit(rtl)
        port map(
            clk,
            rst,
            ena,
            c_sel(N_SIZE-1),
            c_out
        );

end rtl;