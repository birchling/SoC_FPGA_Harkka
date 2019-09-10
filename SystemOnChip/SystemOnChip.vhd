-- Janne Koljonen
-- University of Vaasa
-- Dec. 15th, 2015
-- Project: SystemOnChip; Reference design for Advanced Digital Electronics
-- Top-level entity

library ieee;
use ieee.std_logic_1164.all;
use work.Types.all;
use ieee.numeric_std.all;

entity SystemOnChip is
port(
	-- I/O ports
	OSC_50_B8A : in std_logic;
	KEY : in std_logic_vector(3 downto 0);
	SW : in std_logic_vector(3 downto 0);
	LED : out std_logic_vector(3 downto 0);

	-- Memory ports
	memory_mem_a : 		out std_logic_vector(12 downto 0);
	memory_mem_ba : 		out std_logic_vector(2 downto 0);
	memory_mem_ck : 		out std_logic;
	memory_mem_ck_n : 	out std_logic;
	memory_mem_cke : 		out std_logic;
	memory_mem_cs_n: 		out std_logic;
	memory_mem_ras_n : 	out std_logic;
	memory_mem_cas_n : 	out std_logic;
	memory_mem_we_n : 	out std_logic;
	memory_mem_reset_n : out std_logic;
	memory_mem_dq : 		inout std_logic_vector(7 downto 0);
	memory_mem_dqs : 		inout std_logic;
	memory_mem_dqs_n : 	inout std_logic;
	memory_mem_odt : 		out std_logic;
	memory_mem_dm : 		out std_logic;
	memory_oct_rzqin : 	in std_logic );

end SystemOnChip; 
	
architecture arch of SystemOnChip is

------------------------------------------------------------------------
-- Framework declations

-- Declations of the QSYS-system
component SoC_QSYS is
	port (
		clk_clk                            : in    std_logic                      := 'X';             -- clk
		memory_mem_a                       : out   std_logic_vector(12 downto 0);                     -- mem_a
		memory_mem_ba                      : out   std_logic_vector(2 downto 0);                      -- mem_ba
		memory_mem_ck                      : out   std_logic;                                         -- mem_ck
		memory_mem_ck_n                    : out   std_logic;                                         -- mem_ck_n
		memory_mem_cke                     : out   std_logic;                                         -- mem_cke
		memory_mem_cs_n                    : out   std_logic;                                         -- mem_cs_n
		memory_mem_ras_n                   : out   std_logic;                                         -- mem_ras_n
		memory_mem_cas_n                   : out   std_logic;                                         -- mem_cas_n
		memory_mem_we_n                    : out   std_logic;                                         -- mem_we_n
		memory_mem_reset_n                 : out   std_logic;                                         -- mem_reset_n
		memory_mem_dq                      : inout std_logic_vector(7 downto 0)   := (others => 'X'); -- mem_dq
		memory_mem_dqs                     : inout std_logic                      := 'X';             -- mem_dqs
		memory_mem_dqs_n                   : inout std_logic                      := 'X';             -- mem_dqs_n
		memory_mem_odt                     : out   std_logic;                                         -- mem_odt
		memory_mem_dm                      : out   std_logic;                                         -- mem_dm
		memory_oct_rzqin                   : in    std_logic                      := 'X';             -- oct_rzqin
		reset_reset_n                      : in    std_logic                      := 'X';             -- reset_n
		amms_to_fpga_0_custom_logic_export : out   std_logic_vector(130 downto 0);                    -- export
		amms_to_arm_0_custom_logic_export  : in    std_logic_vector(127 downto 0) := (others => 'X')  -- export
	);
end component SoC_QSYS;

component Bit_Counter is
	port (
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
end component Bit_Counter;

-- Framework signals
signal reset_in, clk_in : std_logic;
signal to_FPGA : int32_to_FPGA_conduit;
signal AMMS_reset, AMMS_clk, AMMS_write : std_logic; 
signal AMMS_data : int32_vector(M - 1 downto 0);
signal AMMS_data_to_ARM : int32_vector(M - 1 downto 0);
signal to_ARM : int32_to_ARM_conduit;

-- Framework declarations end
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Application signals
signal X0, X1, X2 : std_logic_vector(31 downto 0); 
signal Yin, Yout : integer;
signal SUM_X, SUM_Y, SUM_ALL, MULTIPLY_X : integer;
signal fitness1, fitness2, fitness3: std_logic_vector(31 downto 0);
------------------------------------------------------------------------

begin

------------------------------------------------------------------------
-- Framework connections and logic


reset_in <= KEY(3);
clk_in <= OSC_50_B8A;

-- Separate conduit signals to FPGA
separate_to_FPGA : process(to_FPGA)
begin
	AMMS_reset <= to_FPGA(0);
	AMMS_clk <= to_FPGA(1);
	AMMS_write <= to_FPGA(2);
	
	-- Similar/~reserve than in AMMS_to_FPGA.vhd but uses int32_vector
	for i in 0 to M-1 loop
		AMMS_data(i) <= to_FPGA((i+1)*32 + 2 downto i*32 + 3);
	end loop;
end process;

-- Concatenate conduit signals to ARM
concatenate_to_ARM : process(AMMS_data_to_ARM)
begin
	for i in 0 to M-1 loop
		to_ARM((i+1)*32 - 1 downto i*32) <= AMMS_data_to_ARM(i);
	end loop;
end process;

--
u0 : component SoC_QSYS
	port map (
		clk_clk                            => clk_in,
		memory_mem_a                       => memory_mem_a,
		memory_mem_ba                      => memory_mem_ba,
		memory_mem_ck                      => memory_mem_ck,
		memory_mem_ck_n                    => memory_mem_ck_n,
		memory_mem_cke                     => memory_mem_cke,
		memory_mem_cs_n                    => memory_mem_cs_n,
		memory_mem_ras_n                   => memory_mem_ras_n,
		memory_mem_cas_n                   => memory_mem_cas_n,
		memory_mem_we_n                    => memory_mem_we_n,
		memory_mem_reset_n                 => memory_mem_reset_n,
		memory_mem_dq                      => memory_mem_dq,
		memory_mem_dqs                     => memory_mem_dqs,
		memory_mem_dqs_n                   => memory_mem_dqs_n,
		memory_mem_odt                     => memory_mem_odt,
		memory_mem_dm                      => memory_mem_dm,
		memory_oct_rzqin                   => memory_oct_rzqin,
		reset_reset_n                      => reset_in,
		amms_to_fpga_0_custom_logic_export => to_FPGA,
		amms_to_arm_0_custom_logic_export  => to_ARM
	);
	
u1 : component Bit_Counter
	port map (
		X0   		=> X0,
		X1   		=> X1,
		X2   		=> X2,
		Yin  		=> Yin,
		clk  		=> clk_in,
		Yout 		=> Yout,
		fitness1 => fitness1,
		fitness2 => fitness2,
		fitness3 => fitness3
		);
		
-- Framework connections and logic end
---------------------------------------------------------------------

---------------------------------------------------------------------
-- Application connections and logic

-- Some debug signals
reset_in <= KEY(3);
clk_in <= OSC_50_B8A;
LED(3) <= SW(3);
LED(2) <= reset_in;
LED(1) <= AMMS_reset;
LED(0) <= AMMS_data(0)(0); 

--	convert to integers
convert_to_integer : process(AMMS_data)
begin
	X0 <= std_logic_vector(unsigned(AMMS_data(0)));
	X1 <= std_logic_vector(unsigned(AMMS_data(1)));
	X2 <= std_logic_vector(unsigned(AMMS_data(2)));
	Yin <= to_integer(signed(AMMS_data(3)));
end process;

--count_ones : process(X0,X1,X2,YIn)
--variable count1 : unsigned(31 downto 0) := (others => '0');
--variable count2 : unsigned(31 downto 0) := (others => '0');
--variable count3 : unsigned(31 downto 0) := (others => '0');
--variable Y : integer;
--
--
--begin
--	count1 := (others => '0');   --initialize count1 variable.
--	count2 := (others => '0');   --initialize count2 variable.
--	count3 := (others => '0');   --initialize count3 variable.
--	Y := YIn;
--	if (Y = 1) then
--		for i in 0 to 31 loop   --for all the bits.
--			count1 := count1 + (X"0000000" & X0(i));   --Add the bit to the count.
--			count2 := count2 + (X"0000000" & X1(i));
--			count3 := count3 + (X"0000000" & X2(i));
--		end loop;
--		Y := 2;
--	end if;
--	YOut <= Y;
--	
--   fitness1 <= std_logic_vector(count1);    --assign the count to output.
--	fitness2 <= std_logic_vector(count2);
--	fitness3 <= std_logic_vector(count3);
--end process;


	
--	convert results to int32 and pack to int32_vector
convert_to_int32 : process(fitness1,fitness2,fitness3,YOut)
begin
	AMMS_data_to_ARM(0) <= fitness1;
	AMMS_data_to_ARM(1) <= fitness2;
	AMMS_data_to_ARM(2) <= fitness3;
	AMMS_data_to_ARM(3) <= std_logic_vector(to_signed(YOut,32));
end process;

-- Application ends
------------------------------------------------------------------------	

end arch;
