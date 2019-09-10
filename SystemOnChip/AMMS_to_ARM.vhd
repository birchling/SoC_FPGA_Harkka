-- Janne Koljonen
-- University of Vaasa
-- Dec. 14th, 2015
-- Project: SystemOnChip; reference design for Advanced Digital Electronics
-- Entity: Avalon Memory-mapped slave (AMMS) for LW_HPS2FPGA: to ARM

library ieee;
use ieee.std_logic_1164.all;
use work.Types.all;

entity AMMS_to_ARM is
port(
	-- Avalon MMS ports
	reset, clk : in std_logic;
	read : in std_logic;
	readdata : out std_logic_vector(M*32-1 downto 0);
	
	-- Custon logic ports
	from_FPGA : in int32_to_ARM_conduit );
end AMMS_to_ARM;

architecture arch of AMMS_to_ARM is
begin
	synchronize: process(clk, reset) is
	begin
		if reset = '1' then
			readdata <= (others => '0');
		elsif rising_edge(clk) then
			if read = '1' then
				readdata <= from_FPGA;
			end if;
		end if;
	end process;
	
end arch;
