library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_mean_4_clocks is
end tb_mean_4_clocks;

-- Implement the testbench and find the errors in this model.
-- Consider the following expected behavior:
--      Every rising edge of CLK input, the content of INPUT
--      is added to a register chain and used to calculate the
--      mean value over 4 clock periods

architecture test of tb_mean_4_clocks is
	component mean_4_clocks is 
		 port (
			  CLK     : in    std_logic;
			  RESET   : in    std_logic;
			  INPUT   : in    std_logic_vector(7 downto 0);
			  OUTPUT  : out   std_logic_vector(7 downto 0)
		 );
	end component mean_4_clocks;
	
	signal S_CLK	 : std_logic := '0';
	signal S_RESET	 : std_logic := '1';
	signal S_INPUT	 : std_logic_vector(7 downto 0);
	signal S_OUTPUT : std_logic_vector(7 downto 0);
	
begin
	instancia_clocks : mean_4_clocks port map(
				CLK    => S_CLK,
				RESET  => S_RESET,
				INPUT  => S_INPUT,
				OUTPUT => S_OUTPUT
		);
	S_CLK <= not S_CLK after 5 ns;
	S_INPUT <=  "00001000", "00000100" after 10 ns,"00001000" after 20 ns, "00000011" after 30 ns, x"01" after 40 ns ;
	S_RESET <= '0', '1' after 100 ns;
	
end test;