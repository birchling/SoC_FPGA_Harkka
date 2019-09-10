library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bit_counter is port(
							X0   : in std_logic_vector(31 downto 0);
							X1   : in std_logic_vector(31 downto 0);
							X2   : in std_logic_vector(31 downto 0);
							Yin  : in integer;
							--clk  : in std_logic;
							Yout : out integer;
							fitness1 : out integer;
							fitness2 : out integer;
							fitness3 : out integer
							);
end entity bit_counter;

architecture arch of bit_counter is
	begin
	p0: process(Yin) is
	variable count1 : integer := 0;
	variable count2 : integer := 0;
	variable count3 : integer := 0;
	variable Y : integer;
	begin
		
		Y := YIn;
		if (y = 0) then
			count1 := 0;
			count1 := 0;
			count1 := 0;
		end if;
		if (Y = 1) then
			
			for i in 0 to 31 loop   --for all the bits.
				
					count1 := count1 + to_integer(signed'(X"00000000" & X0(31-i)));   --Add the bit to the count.
					count2 := count2 + to_integer(signed'(X"00000000" & X1(31-i)));
					count3 := count3 + to_integer(signed'(X"00000000" & X2(31-i)));
				
			end loop;
			Y := 2;
		end if;
		YOut <= Y;
		
		fitness1 <= count1;    --assign the count to output.
		fitness2 <= count2;
		fitness3 <= count3;
	end process p0;
end arch;
	