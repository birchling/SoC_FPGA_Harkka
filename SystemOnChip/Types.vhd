-- Janne Koljonen
-- University of Vaasa
-- Dec. 1st, 2015
-- Project: LW_delay_line; Loopback with a shift register
-- Type definitions

library ieee;
use ieee.std_logic_1164.all;

package Types is

-- Basic data type, corresponds to int in software
subtype int32 is std_logic_vector(31 downto 0);
constant zero : int32 := (others => '0');

-- Corresponds to int[]
type int32_vector is array (integer range <>) of int32;


-- Number of int32 data variables lead though the conduit
constant M : Natural range 1 to 32 := 4;
-- A bundle of M x int32 data + write + clk + reset, respectively
-- I.e.: x(0) <= reset, x(1) <= clk, x(2) <= write
-- Is used to deliver int32 data and control signals
-- through the conduit from ARM to FPGA
subtype int32_to_FPGA_conduit is std_logic_vector(M*32 - 1 + 3 downto 0);
-- A bundle of M x int32 data 
-- through the conduit from FPGA to ARM
subtype int32_to_ARM_conduit is std_logic_vector(M*32 - 1 downto 0);

end Types;
