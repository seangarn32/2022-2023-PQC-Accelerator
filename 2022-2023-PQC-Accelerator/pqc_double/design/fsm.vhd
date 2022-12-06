library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.globals_pkg.all;

entity fsm is
    port ( 
        clk : in  std_logic;
        rst : in  std_logic;
        ena : in  std_logic;
        enc_dec : in std_logic;

        dsi_ena     : out   std_logic;
        load_a_rst  : out   std_logic;
        load_a_ena  : out   std_logic;
        load_b_rst  : out   std_logic;
        load_b_ena  : out   std_logic;
        pe_ena      : out   std_logic;
        accum_ena   : out   std_logic;
        dso_ena     : out   std_logic;
        dso_rst     : out   std_logic;
        err_ena     : out   std_logic;

        a_index_out : out   std_logic_vector(7 downto 0);
        b_index_out : out   std_logic_vector(7 downto 0);
        p_index_out : out   std_logic_vector(7 downto 0);
        c_out_0_index_out : out   std_logic_vector(7 downto 0);
        c_out_1_index_out : out   std_logic_vector(7 downto 0);
        out_ena     : out   std_logic
    );
end fsm;

architecture rtl of fsm is

    type state_available is (SETUP, DATA_IN, PE_PIPE, DATA_OUT, FINISHED);  --type of state machine.
    signal state            : state_available := SETUP;
    
    signal count            : std_logic_vector(COUNTER_SIZE downto 0);
    signal counter_ena      : std_logic := '0';
    signal counter_rst      : std_logic := '1';
    signal a_index_out_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal b_index_out_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal p_index_out_hold : std_logic_vector(7 downto 0) := (others=>'0');

    signal c_out_0_index_out_hold : std_logic_vector(7 downto 0) := (others=>'0');
    signal c_out_1_index_out_hold : std_logic_vector(7 downto 0) := (others=>'0');
begin

    STATE_COUNTER: entity work.counter(rtl)
            port map (
                clk, counter_rst, counter_ena, count
            );

    process (clk)
    begin

        if falling_edge(clk) then

            if (rst='1') then
                state <= SETUP;
            else
                case state is

                    when SETUP =>
                        dsi_ena <= '0';
                        load_a_rst <= '0';
                        load_a_ena <= '0';
                        load_b_ena <= '0';
                        pe_ena <= '0';
                        accum_ena <= '0';
                        dso_ena <= '0';
                        counter_ena <= '0';
                        if(ena = '1') then
                            state <= DATA_IN;
                            counter_rst <= '1';
                        end if;

                    when DATA_IN =>
                        if(count = N_SIZE) then
                            dsi_ena <= '0';
                            load_a_rst <= '1';
                            load_b_rst <= '1';
                            load_a_ena <= '0';
                            pe_ena <= '0';
                        elsif (count = N_SIZE + 1) then
                            state <= PE_PIPE;
                            out_ena <= '0';
                            counter_rst <= '1';
                        else
                            dsi_ena <= '1';
                            counter_ena <= '1';
                            counter_rst <= '0';
                            a_index_out_hold <= a_index_out_hold + '1';
                            b_index_out_hold <= b_index_out_hold + '1';
                            p_index_out_hold <= p_index_out_hold + '1';
                            out_ena <= '1';
                        end if;

                    when PE_PIPE =>
                        if (enc_dec = '0') then
                            if (count = PE_SIZE + (N_SIZE/PE_SIZE) + 1) then
                                pe_ena <= '0';
                                counter_rst <= '1';
                                accum_ena <= '0';
                                dso_rst <= '1';
                                state <= DATA_OUT;
                            else
                                if(count >= PE_SIZE + 1 and count <= PE_SIZE + (N_SIZE/PE_SIZE)) then
                                    accum_ena <= '1';
                                else 
                                    accum_ena <= '0';
                                end if;
                                if (count < (N_SIZE / PE_SIZE)) then -- changed from < to <=
                                    load_a_ena <= '1';
                                    load_b_ena <= '1'; 
                                else
                                    load_a_ena <= '0';
                                    load_b_ena <= '0';
                                end if;
                                dsi_ena <= '0';
                                load_a_rst <= '0';
                                if (count = 0) then
                                    --load_b_rst <= '1';
                                    load_b_ena <= '1';
                                else
                                    load_b_rst <= '0';
                                end if;
                                if (count > 0) then
                                    pe_ena <= '1';
                                end if;
                                counter_rst <= '0';
                            end if;
                        else
                            if(count = PE_SIZE + N_SIZE / (PE_SIZE * 2) + 2) then
                                pe_ena <= '0';
                                counter_rst <= '1';
                                accum_ena <= '0';
                                dso_rst <= '1';
                                state <= DATA_OUT;
                            else
                                if (count >= PE_SIZE + 1 and count <= PE_SIZE + (N_SIZE/(PE_SIZE * 2))) then 
                                    accum_ena <= '1';
                                 else
                                    accum_ena <= '0';
                                end if;
                                if (count < (N_SIZE / (PE_SIZE * 2))) then -- changed from < to <=
                                    load_a_ena <= '1';
                                    load_b_ena <= '1';
                                else
                                    load_a_ena <= '0';
                                    load_b_ena <= '0';
                                end if;
                                dsi_ena <= '0';
                                load_a_rst <= '0';
                                if (count = 0) then
                                    --load_b_rst <= '1';
                                    load_b_ena <= '1';
                                else
                                    load_b_rst <= '0';
                                end if;
                                if (count > 0) then
                                    pe_ena <= '1';
                                end if;
                                counter_rst <= '0';
                            end if;
                        end if;
                        load_b_rst <= '0';

                    when DATA_OUT =>
                        if(count = N_SIZE) then
                            dso_ena <= '0';
                        elsif (count = N_SIZE + 1) then
                            counter_rst <= '1';
                            state <= FINISHED;
                            out_ena <= '0';
                            err_ena <= '0';
                        else
                            pe_ena <= '0';
                            accum_ena <= '0';
                            dso_ena <= '1';
                            err_ena <= '1';
                            dso_rst <= '0';
                            counter_rst <= '0';
                            c_out_0_index_out_hold <= c_out_0_index_out_hold + '1';
                            c_out_1_index_out_hold <= c_out_0_index_out_hold + '1';
                            out_ena <= '1';
                        end if;
                    
                    when FINISHED =>
                end case;
            end if;
        end if;
    end process;

    a_index_out <= a_index_out_hold;
    b_index_out <= b_index_out_hold;
    p_index_out <= p_index_out_hold;

    c_out_0_index_out <= c_out_0_index_out_hold;
    c_out_1_index_out <= c_out_1_index_out_hold;

end rtl;
