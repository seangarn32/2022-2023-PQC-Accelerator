library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals_pkg.all;

entity pqc_accelerator_top is
end entity;

architecture rtl of pqc_accelerator_top is

    signal clk :  std_logic;
    signal rst :  std_logic;
    signal ena :  std_logic;

    signal A0  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A1  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A2  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A3  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A4  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A5  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A6  :  std_logic_vector(N_SIZE-1 downto 0);
    signal A7  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B0  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B1  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B2  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B3  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B4  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B5  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B6  :  std_logic_vector(N_SIZE-1 downto 0);
    signal B7  :  std_logic_vector(N_SIZE-1 downto 0);
    signal C7  :  std_logic_vector(N_SIZE-1 downto 0);

begin

    PE0 :   entity work.processing_element_i(rtl)
        port map(
            clk,
            rst,
            ena,
            A0,
            B0,
            A1,
        );

    PE1 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A1,
            B1,
            A2,
        );

    PE2 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A2,
            B2,
            A3,
        );

    PE3 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A3,
            B3,
            A4,
        );
    PE4 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A4,
            B4,
            A5,
        );
    PE5 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A5,
            B5,
            A6,
        );
    PE6 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A6,
            B6,
            A7,
        );
    PE7 :   entity work.processing_element_n(rtl)
        port map(
            clk,
            rst,
            ena,
            A7,
            B7,
            C7,
        );

end architecture;