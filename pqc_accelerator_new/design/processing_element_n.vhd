library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.globals.all;

entity processing_element_n is
--    clk
--    rst
--    shift_en
--    A0-in(8x1) - unsigned
--    b0-in(1x8)
--    C0-out(8x1) - unsigned
end entity;

architecture rtl of processing_element_n is
--  A0xB0=C0
-- if rst, set everything to 0
-- if shift_en!, do nothing
-- if clk and shift_en...
    -- C0 = A0 x b0 --> REGISTER OUT
    
end rtl;