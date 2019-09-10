-- Janne Koljonen
-- University of Vaasa
-- Dec. 14th, 2015
-- Project: SystemOnChip; reference design for Advanced Digital Electronics
-- Entity: Avalon Memory-mapped slave (AMMS) for LW_HPS2FPGA: to FPGA

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.Types.all;

entity AMMS_to_FPGA is
port(
	-- Avalon MMS ports
	reset, clk : in std_logic;
	write : in std_logic;
	writedata : in std_logic_vector(M*32-1 downto 0);
	-- 4 signals for each int32
	byteenable : in std_logic_vector(M*4 - 1 downto 0);
	
	-- Custon logic ports
	to_FPGA : out int32_to_FPGA_conduit );
end AMMS_to_FPGA;

architecture arch of AMMS_to_FPGA is
begin
	-- Concatenate signals to conduit
	to_FPGA(2) <= write;
	to_FPGA(1) <= clk;
	to_FPGA(0) <= reset;

	synchronize: process(reset, clk, write) is
	begin
		if reset = '1' then
			to_FPGA(M*32 + 2 downto 3) <= (others => '0');
		elsif rising_edge(clk) then
			if write = '1' then
--				With two int32: 
--				case byteenable is
--					when x"000f" => to_FPGA(1*32+2 downto 0*32 + 3) <= writedata(1*32-1 downto 0*32);
--					when x"00f0" => to_FPGA(2*32+2 downto 1*32 + 3) <= writedata(2*32-1 downto 1*32);
--					when others => null;
--				end case;
--				General case: 
				for i in 0 to M-1 loop
					-- Check the four byte enables of each word
					if byteenable(i*4+3 downto i*4) = x"f" then
						to_FPGA((i+1)*32 + 2 downto i*32 + 3) <= writedata((i+1)*32 - 1 downto i*32);
					end if;
				end loop;
			end if;
		end if;
	end process;
end arch;
