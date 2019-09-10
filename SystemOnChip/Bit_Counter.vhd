library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit_counter is port(
							X0   : in std_logic_vector(31 downto 0);
							X1   : in std_logic_vector(31 downto 0);
							X2   : in std_logic_vector(31 downto 0);
							Yin  : in integer;
							clk  : in std_logic;
							Yout : out integer;
							fitness1 : out std_logic_vector(31 downto 0);
							fitness2 : out std_logic_vector(31 downto 0);
							fitness3 : out std_logic_vector(31 downto 0)
							);
end entity bit_counter;

architecture arch of bit_counter is
	begin
	p0: process(clk, Yin) is
	variable count1 : unsigned(31 downto 0) := (others => '0');
	variable count2 : unsigned(31 downto 0) := (others => '0');
	variable count3 : unsigned(31 downto 0) := (others => '0');
	variable Y : integer;
	begin
		
		Y := YIn;
		if (Y = 1) then
			for i in 0 to 31 loop   --for all the bits.
				if rising_edge(clk) then
					count1 := count1 + (X"0000000" & X0(i));   --Add the bit to the count.
					count2 := count2 + (X"0000000" & X1(i));
					count3 := count3 + (X"0000000" & X2(i));
				end if;
			end loop;
			Y := 2;
		end if;
		YOut <= Y;
		
		fitness1 <= std_logic_vector(count1);    --assign the count to output.
		fitness2 <= std_logic_vector(count2);
		fitness3 <= std_logic_vector(count3);
	end process p0;
end arch;
	